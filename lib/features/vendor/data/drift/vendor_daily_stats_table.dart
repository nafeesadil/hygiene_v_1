import 'package:drift/drift.dart';

class VendorDailyStats extends Table {
  TextColumn get dateKey => text()();

  IntColumn get earnedXp => integer().withDefault(const Constant(0))();

  IntColumn get targetXp => integer().withDefault(const Constant(300))();

  BoolColumn get hitHalfTargetFlag =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get shopOpened => boolean().withDefault(const Constant(false))();

  BoolColumn get hitFullTargetFlag =>
      boolean().withDefault(const Constant(false))();

  BoolColumn get notified30 => boolean().withDefault(const Constant(false))();

  BoolColumn get notified70 => boolean().withDefault(const Constant(false))();

  BoolColumn get notified100 => boolean().withDefault(const Constant(false))();

  IntColumn get createdAtMs => integer().withDefault(const Constant(0))();

  IntColumn get updatedAtMs => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {dateKey};
}
