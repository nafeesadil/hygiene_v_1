import 'package:drift/drift.dart';
import 'package:hygiene_v_1/core/local_db/drift_db.dart';
import 'package:hygiene_v_1/features/tasks/domain/built_in_tasks.dart';


class TaskRepository {
  final AppDb _db;
  TaskRepository(this._db);

  String _dateKey(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  Future<void> ensureSeeded() async {
    final countExp = _db.tasks.id.count();
    final count = await (_db.selectOnly(_db.tasks)..addColumns([countExp]))
        .map((row) => row.read(countExp) ?? 0)
        .getSingle();

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

  Future<int> getTodayCount(String taskKey) async {
    final key = _dateKey(DateTime.now());
    final countExp = _db.taskLogs.id.count();

    final query = _db.selectOnly(_db.taskLogs)
      ..addColumns([countExp])
      ..where(_db.taskLogs.taskKey.equals(taskKey))
      ..where(_db.taskLogs.dateKey.equals(key));

    final row = await query.getSingle();
    return row.read(countExp) ?? 0;
  }

  Future<int> addDone(String taskKey) async {
    final now = DateTime.now();
    final key = _dateKey(now);

    await _db
        .into(_db.taskLogs)
        .insert(
          TaskLogsCompanion.insert(
            taskKey: taskKey,
            dateKey: key,
            timestampMs: now.millisecondsSinceEpoch,
          ),
        );

    await (_db.update(_db.tasks)..where((t) => t.taskKey.equals(taskKey)))
        .write(TasksCompanion(lastDoneAtMs: Value(now.millisecondsSinceEpoch)));

    return getTodayCount(taskKey);
  }
}
