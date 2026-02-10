import 'package:drift/drift.dart';

class Tasks extends Table {
  IntColumn get id => integer().autoIncrement()();

  // stable key like "handwash"
  TextColumn get taskKey => text()();

  BoolColumn get isActive => boolean().withDefault(const Constant(false))();

  // 1..5
  IntColumn get level => integer().withDefault(const Constant(1))();

  // your value points
  IntColumn get valuePoints => integer().withDefault(const Constant(0))();

  // for 10-min gap enforcement (0 = never)
  IntColumn get lastDoneAtMs => integer().withDefault(const Constant(0))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {taskKey},
  ];
}

class TaskLogs extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get taskKey => text()();

  // YYYY-MM-DD
  TextColumn get dateKey => text()();

  IntColumn get timestampMs => integer()();

  // helpful indexes
  @override
  Set<Column> get primaryKey => {id};
}
