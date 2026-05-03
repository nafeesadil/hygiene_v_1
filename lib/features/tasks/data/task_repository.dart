import 'package:drift/drift.dart';
import 'package:hygiene_v_1/core/local_db/drift_db.dart';
import 'package:hygiene_v_1/features/tasks/domain/built_in_tasks.dart';
import 'package:hygiene_v_1/features/tasks/domain/task_definition.dart';
import 'package:hygiene_v_1/features/tasks/domain/task_rules.dart';
import 'package:hygiene_v_1/features/vendor/data/vendor_repository.dart';
import 'package:hygiene_v_1/features/shared/application/notification_service.dart';

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
  final int earnedXp;
  final int taskLevel;
  final Duration? waitRemaining;
  final bool leveledUp;

  const MarkDoneResult({
    required this.status,
    required this.done,
    required this.target,
    required this.earnedXp,
    required this.taskLevel,
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

  Future<Duration> getCooldownRemaining(String taskKey) async {
    await ensureSeeded();

    final taskRow = await (_db.select(
      _db.tasks,
    )..where((t) => t.taskKey.equals(taskKey))).getSingleOrNull();

    if (taskRow == null) return Duration.zero;

    final def = _defOf(taskKey);
    final cooldown = taskCooldownFor(def);

    if (cooldown <= Duration.zero) return Duration.zero;
    if (taskRow.lastDoneAtMs == 0) return Duration.zero;

    final last = DateTime.fromMillisecondsSinceEpoch(taskRow.lastDoneAtMs);
    final diff = DateTime.now().difference(last);

    if (diff >= cooldown) return Duration.zero;

    return cooldown - diff;
  }

  Future<void> ensureSeeded() async {
    final existingRows = await _db.select(_db.tasks).get();
    final existingKeys = existingRows.map((e) => e.taskKey).toSet();

    final missingDefs = builtInTasks
        .where((def) => !existingKeys.contains(def.id))
        .toList();

    if (missingDefs.isEmpty) return;

    await _db.batch((batch) {
      batch.insertAll(_db.tasks, [
        for (final def in missingDefs)
          TasksCompanion.insert(
            taskKey: def.id,
            isActive: const Value(false),
            level: const Value(1),
            valuePoints: Value(def.levels.first.valuePoints),
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

    await _db
        .into(_db.shopState)
        .insert(
          ShopStateCompanion(id: const Value(0)),
          mode: InsertMode.insertOrIgnore,
        );

    await (_db.update(_db.shopState)..where((s) => s.id.equals(0))).write(
      ShopStateCompanion(
        isOpen: Value(open),
        openedAtMs: Value(open ? nowMs : 0),
      ),
    );

    if (open) {
      await VendorRepository(_db).markShopOpenedToday();
    } else {
      await NotificationService.instance.cancelAllTaskCooldownNotifications();
    }
  }

  Future<List<Task>> getActiveTasks() async {
    await ensureSeeded();
    return (_db.select(_db.tasks)..where((t) => t.isActive.equals(true))).get();
  }

  Future<bool> isActive(String taskKey) async {
    await ensureSeeded();
    final row = await (_db.select(
      _db.tasks,
    )..where((t) => t.taskKey.equals(taskKey))).getSingleOrNull();
    return row?.isActive ?? false;
  }

  Future<int> getLevel(String taskKey) async {
    await ensureSeeded();
    final row = await (_db.select(
      _db.tasks,
    )..where((t) => t.taskKey.equals(taskKey))).getSingleOrNull();
    return row?.level ?? 1;
  }

  Future<void> setActive(String taskKey, bool active) async {
    await ensureSeeded();

    final existing = await (_db.select(
      _db.tasks,
    )..where((t) => t.taskKey.equals(taskKey))).getSingleOrNull();

    if (existing == null) {
      final def = _defOf(taskKey);
      await _db
          .into(_db.tasks)
          .insert(
            TasksCompanion.insert(
              taskKey: def.id,
              isActive: Value(active),
              level: const Value(1),
              valuePoints: Value(def.levels.first.valuePoints),
              lastDoneAtMs: const Value(0),
            ),
          );
      return;
    }

    await (_db.update(_db.tasks)..where((t) => t.taskKey.equals(taskKey)))
        .write(TasksCompanion(isActive: Value(active)));
  }

  Future<void> setLevel(String taskKey, int level, int valuePoints) async {
    await ensureSeeded();
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

  Future<int> getTodayCount(String taskKey) async {
    final dateKey = _dateKey(DateTime.now());
    return _todayCountFor(taskKey, dateKey);
  }

  Future<MarkDoneResult> tryMarkDone(String taskKey) async {
    return addDoneGuarded(taskKey);
  }

  Future<MarkDoneResult> addDoneGuarded(String taskKey) async {
    await ensureSeeded();

    final now = DateTime.now();
    final dateKey = _dateKey(now);
    final def = _defOf(taskKey);

    return _db.transaction(() async {
      final taskRow = await (_db.select(
        _db.tasks,
      )..where((t) => t.taskKey.equals(taskKey))).getSingleOrNull();

      final currentLevel = taskRow?.level ?? 1;
      final target = taskTargetForLevel(def, currentLevel);
      final doneToday = await _todayCountFor(taskKey, dateKey);

      if (taskRow == null || !taskRow.isActive) {
        return MarkDoneResult(
          status: MarkDoneStatus.notActive,
          done: doneToday,
          target: target,
          earnedXp: 0,
          taskLevel: currentLevel,
        );
      }

      if (def.requiresShopOpen) {
        final open = await isShopOpen();
        if (!open) {
          return MarkDoneResult(
            status: MarkDoneStatus.shopClosed,
            done: doneToday,
            target: target,
            earnedXp: 0,
            taskLevel: currentLevel,
          );
        }
      }

      final cooldown = taskCooldownFor(def);
      final lastMs = taskRow.lastDoneAtMs;

      if (cooldown > Duration.zero && lastMs != 0) {
        final last = DateTime.fromMillisecondsSinceEpoch(lastMs);
        final diff = now.difference(last);
        final effectiveDiff = diff.isNegative ? Duration.zero : diff;

        if (effectiveDiff < cooldown) {
          return MarkDoneResult(
            status: MarkDoneStatus.cooldown,
            done: doneToday,
            target: target,
            earnedXp: 0,
            taskLevel: currentLevel,
            waitRemaining: cooldown - effectiveDiff,
          );
        }
      }

      final hardCap = taskEffectiveDailyCap(def, currentLevel);
      if (doneToday >= hardCap) {
        return MarkDoneResult(
          status: MarkDoneStatus.alreadyComplete,
          done: doneToday,
          target: target,
          earnedXp: 0,
          taskLevel: currentLevel,
        );
      }

      final earnedXp = taskXpForCompletion(def, currentLevel);

      await _db
          .into(_db.taskLogs)
          .insert(
            TaskLogsCompanion.insert(
              taskKey: taskKey,
              dateKey: dateKey,
              timestampMs: now.millisecondsSinceEpoch,
            ),
          );

      await (_db.update(
        _db.tasks,
      )..where((t) => t.taskKey.equals(taskKey))).write(
        TasksCompanion(lastDoneAtMs: Value(now.millisecondsSinceEpoch)),
      );

      final after = doneToday + 1;

      bool leveledUp = false;
      int finalLevel = currentLevel;

      if (after == target) {
        final nextLevel = (currentLevel + 1).clamp(1, 5);
        if (nextLevel != currentLevel) {
          await (_db.update(
            _db.tasks,
          )..where((t) => t.taskKey.equals(taskKey))).write(
            TasksCompanion(
              level: Value(nextLevel),
              valuePoints: Value(taskValuePointsForLevel(def, nextLevel)),
            ),
          );
          leveledUp = true;
          finalLevel = nextLevel;
        }
      }

      return MarkDoneResult(
        status: MarkDoneStatus.success,
        done: after,
        target: target,
        earnedXp: earnedXp,
        taskLevel: finalLevel,
        leveledUp: leveledUp,
      );
    });
  }
}
