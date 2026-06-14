import 'package:drift/drift.dart';

class CustomTaskDefinitions extends Table {
  TextColumn get id => text()();

  TextColumn get name => text()();

  TextColumn get shortDescription => text()();

  IntColumn get minGapMinutes => integer().withDefault(const Constant(15))();

  IntColumn get dailyCap => integer().withDefault(const Constant(12))();

  IntColumn get level1Target => integer()();

  IntColumn get level2Target => integer()();

  IntColumn get level3Target => integer()();

  IntColumn get level4Target => integer()();

  IntColumn get level5Target => integer()();

  IntColumn get createdAtMs => integer()();

  IntColumn get updatedAtMs => integer()();

  @override
  Set<Column> get primaryKey => {id};
}
