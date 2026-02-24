import 'package:drift/drift.dart';
import 'package:hygiene_v_1/core/local_db/drift_db.dart';
import 'package:hygiene_v_1/features/tasks/domain/built_in_tasks.dart';
import 'package:hygiene_v_1/features/tasks/domain/task_definition.dart';

enum MarkDoneStatus {
  success,
  shopClosed,
  cooldown,
  alreadyComplete,
  notActive,
}

class MarkDoneResult {
  final MarkDoneStatus status;
  final int done;
  final int target;
  final Duration? waitRemaining;
  final bool leveledUp;

  const MarkDoneResult({
    required this.status,
    required this.done,
    required this.target,
    this.waitRemaining,
    this.leveledUp = false,
  });
}

class TaskRepository {
  final AppDb _db;
  TaskRepository(this._db);

  String _dateKey(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  TaskDefinition _defOf(String taskKey) =>
      builtInTasks.firstWhere((t) => t.id == taskKey);

  int _targetForLevel(String taskKey, int level) {
    final def = _defOf(taskKey);
    final idx = (level - 1).clamp(0, def.levels.length - 1);
    return def.levels[idx].timesPerDayTarget;
  }

  int _valuePointsForLevel(String taskKey, int level) {
    final def = _defOf(taskKey);
    final idx = (level - 1).clamp(0, def.levels.length - 1);
    return def.levels[idx].valuePoints;
  }

  Future<void> ensureSeeded() async {
    final countExp = _db.tasks.id.count();

    final row = await (_db.selectOnly(
      _db.tasks,
    )..addColumns([countExp])).getSingleOrNull();

    final count = row?.read(countExp) ?? 0;

    if (count > 0) return;

    await _db.batch((batch) {
      batch.insertAll(_db.tasks, [
        for (final def in builtInTasks)
          TasksCompanion.insert(
            taskKey: def.id,
            isActive: const Value(false),
            level: const Value(1),
            valuePoints: Value(def.levels[0].valuePoints),
            lastDoneAtMs: const Value(0),
          ),
      ]);
    });
  }

  Future<bool> isShopOpen() async {
    final row = await (_db.select(
      _db.shopState,
    )..where((s) => s.id.equals(0))).getSingleOrNull();
    return row?.isOpen ?? false;
  }

  Future<void> setShopOpen(bool open) async {
    final nowMs = DateTime.now().millisecondsSinceEpoch;

    // ensure singleton row exists
    await _db
        .into(_db.shopState)
        .insert(
          ShopStateCompanion(
            id: const Value(0),
            // leave defaults for the rest
          ),
          mode: InsertMode.insertOrIgnore,
        );

    await (_db.update(_db.shopState)..where((s) => s.id.equals(0))).write(
      ShopStateCompanion(
        isOpen: Value(open),
        openedAtMs: Value(open ? nowMs : 0),
      ),
    );
  }

  Future<List<Task>> getActiveTasks() {
    return (_db.select(_db.tasks)..where((t) => t.isActive.equals(true))).get();
  }

  Future<bool> isActive(String taskKey) async {
    final row = await (_db.select(
      _db.tasks,
    )..where((t) => t.taskKey.equals(taskKey))).getSingleOrNull();
    return row?.isActive ?? false;
  }

  Future<int> getLevel(String taskKey) async {
    final row = await (_db.select(
      _db.tasks,
    )..where((t) => t.taskKey.equals(taskKey))).getSingleOrNull();
    return row?.level ?? 1;
  }

  Future<void> setActive(String taskKey, bool active) async {
    await (_db.update(_db.tasks)..where((t) => t.taskKey.equals(taskKey)))
        .write(TasksCompanion(isActive: Value(active)));
  }

  Future<void> setLevel(String taskKey, int level, int valuePoints) async {
    await (_db.update(
      _db.tasks,
    )..where((t) => t.taskKey.equals(taskKey))).write(
      TasksCompanion(
        level: Value(level.clamp(1, 5)),
        valuePoints: Value(valuePoints),
      ),
    );
  }

  Future<int> _todayCountFor(String taskKey, String dateKey) async {
    final countExp = _db.taskLogs.id.count();
    final query = _db.selectOnly(_db.taskLogs)
      ..addColumns([countExp])
      ..where(_db.taskLogs.taskKey.equals(taskKey))
      ..where(_db.taskLogs.dateKey.equals(dateKey));
    final row = await query.getSingle();
    return row.read(countExp) ?? 0;
  }

  /// Public wrapper for UI: get today's count for a task.
  Future<int> getTodayCount(String taskKey) async {
    final dateKey = _dateKey(DateTime.now());
    return _todayCountFor(taskKey, dateKey);
  }

  /// Public wrapper that attempts to mark a task done and returns the
  /// [MarkDoneResult] for the UI to handle user feedback.
  Future<MarkDoneResult> tryMarkDone(String taskKey) async {
    return addDoneGuarded(taskKey);
  }

  Future<MarkDoneResult> addDoneGuarded(String taskKey) async {
    final now = DateTime.now();
    final dateKey = _dateKey(now);

    return _db.transaction(() async {
      // 1) shop must be open
      final open = await isShopOpen();
      if (!open) {
        // show current done/target for UI consistency
        final taskRow = await (_db.select(
          _db.tasks,
        )..where((t) => t.taskKey.equals(taskKey))).getSingleOrNull();
        final lvl = taskRow?.level ?? 1;
        final target = _targetForLevel(taskKey, lvl);
        final done = await _todayCountFor(taskKey, dateKey);
        return MarkDoneResult(
          status: MarkDoneStatus.shopClosed,
          done: done,
          target: target,
        );
      }

      // 2) task must be active
      final taskRow = await (_db.select(
        _db.tasks,
      )..where((t) => t.taskKey.equals(taskKey))).getSingleOrNull();

      if (taskRow == null || !taskRow.isActive) {
        final lvl = taskRow?.level ?? 1;
        final target = _targetForLevel(taskKey, lvl);
        final done = await _todayCountFor(taskKey, dateKey);
        return MarkDoneResult(
          status: MarkDoneStatus.notActive,
          done: done,
          target: target,
        );
      }

      // 3) cooldown: DEBUG 10 seconds since lastDoneAtMs
      const cooldown = Duration(seconds: 10); // DEBUG
      final lastMs = taskRow.lastDoneAtMs;

      if (lastMs != 0) {
        final last = DateTime.fromMillisecondsSinceEpoch(lastMs);

        // Guard against weird cases (clock changes / future timestamps)
        final diff = now.difference(last);

        // If last is in the future, treat it as "just done now"
        final effectiveDiff = diff.isNegative ? Duration.zero : diff;

        if (effectiveDiff < cooldown) {
          // Use remaining time based on effectiveDiff
          final wait = cooldown - effectiveDiff;

          final target = _targetForLevel(taskKey, taskRow.level);
          final done = await _todayCountFor(taskKey, dateKey);

          return MarkDoneResult(
            status: MarkDoneStatus.cooldown,
            done: done,
            target: target,
            waitRemaining: wait,
          );
        }
      }

      // 4) cap by target
      final target = _targetForLevel(taskKey, taskRow.level);
      final before = await _todayCountFor(taskKey, dateKey);
      if (before >= target) {
        return MarkDoneResult(
          status: MarkDoneStatus.alreadyComplete,
          done: before,
          target: target,
        );
      }

      // 5) insert log
      await _db
          .into(_db.taskLogs)
          .insert(
            TaskLogsCompanion.insert(
              taskKey: taskKey,
              dateKey: dateKey,
              timestampMs: now.millisecondsSinceEpoch,
            ),
          );

      // 6) update lastDoneAtMs
      await (_db.update(
        _db.tasks,
      )..where((t) => t.taskKey.equals(taskKey))).write(
        TasksCompanion(lastDoneAtMs: Value(now.millisecondsSinceEpoch)),
      );

      final after = before + 1;

      // 7) level-up exactly when finishing today's target
      bool leveledUp = false;
      if (after == target) {
        final nextLevel = (taskRow.level + 1).clamp(1, 5);
        if (nextLevel != taskRow.level) {
          await (_db.update(
            _db.tasks,
          )..where((t) => t.taskKey.equals(taskKey))).write(
            TasksCompanion(
              level: Value(nextLevel),
              valuePoints: Value(_valuePointsForLevel(taskKey, nextLevel)),
            ),
          );
          leveledUp = true;
        }
      }

      return MarkDoneResult(
        status: MarkDoneStatus.success,
        done: after,
        target: target,
        leveledUp: leveledUp,
      );
    });
  }
}
