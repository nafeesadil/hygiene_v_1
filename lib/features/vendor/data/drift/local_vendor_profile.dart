import 'package:drift/drift.dart';

class LocalVendorProfiles extends Table {
  TextColumn get vendorId => text()();

  TextColumn get ownerUid => text()();

  TextColumn get vendorName => text()();

  TextColumn get shopName => text()();

  TextColumn get foodCategory => text()();

  TextColumn get description => text().withDefault(const Constant(''))();

  TextColumn get phoneNumber => text().withDefault(const Constant(''))();

  TextColumn get locationText => text().withDefault(const Constant(''))();

  TextColumn get city => text().withDefault(const Constant(''))();

  TextColumn get country => text().withDefault(const Constant('Bangladesh'))();

  TextColumn get preferredLanguage =>
      text().withDefault(const Constant('en'))();

  TextColumn get profileImageUrl => text().nullable()();

  TextColumn get reviewUrl => text()();

  RealColumn get averageRating => real().withDefault(const Constant(0.0))();

  IntColumn get reviewCount => integer().withDefault(const Constant(0))();

  TextColumn get lastReviewComment => text().nullable()();

  IntColumn get createdAtMs => integer()();

  IntColumn get updatedAtMs => integer()();

  IntColumn get lastSyncedAtMs => integer().withDefault(const Constant(0))();

  BoolColumn get isDirty => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {vendorId};
}
