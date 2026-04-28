import 'package:drift/drift.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  // Stable key like "handwash"
  TextColumn get taskKey => text()();

  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  // Current task level: 1..5
  IntColumn get level => integer().withDefault(const Constant(1))();

  // XP/value points awarded per valid completion at the current level
  IntColumn get valuePoints => integer().withDefault(const Constant(0))();

  // Last completion timestamp in milliseconds since epoch
  // Used for cooldown / minimum gap enforcement
  IntColumn get lastDoneAtMs => integer().withDefault(const Constant(0))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {taskKey},
  ];
}

class TaskLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  // References the stable task key from Tasks.taskKey
  TextColumn get taskKey => text()();

  // YYYY-MM-DD, used for fast per-day aggregation
  TextColumn get dateKey => text()();

  // Exact completion timestamp in milliseconds since epoch
  IntColumn get timestampMs => integer()();
}
