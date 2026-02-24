import 'package:drift/drift.dart';

class ShopState extends Table {
  // singleton row: always id = 0
  IntColumn get id => integer()();

  BoolColumn get isOpen => boolean().withDefault(const Constant(false))();

  // optional: when opened
  IntColumn get openedAtMs => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
