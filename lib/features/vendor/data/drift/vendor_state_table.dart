import 'package:drift/drift.dart';

class VendorState extends Table {
  IntColumn get id => integer().withDefault(const Constant(0))();

  IntColumn get totalXp => integer().withDefault(const Constant(0))();

  IntColumn get vendorLevel => integer().withDefault(const Constant(1))();

  RealColumn get vendorScore => real().withDefault(const Constant(0))();

  IntColumn get bestStreak => integer().withDefault(const Constant(0))();

  IntColumn get updatedAtMs => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
