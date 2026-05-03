import 'package:drift/drift.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../features/tasks/data/drift/tasks_tables.dart';
import '../../features/tasks/data/drift/shop_state_table.dart';
import 'package:hygiene_v_1/features/vendor/data/drift/vendor_daily_stats_table.dart';
import 'package:hygiene_v_1/features/vendor/data/drift/vendor_state_table.dart';

part 'drift_db.g.dart';

@DriftDatabase(
  tables: [
    Tasks,
    TaskLogs,
    ShopState,
    Tasks,
    TaskLogs,
    ShopState,
    VendorState,
    VendorDailyStats,
  ],
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 5;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    // Preserve EXACT same DB location and filename as your current FFI setup:
    // <app-documents-dir>/hygia.sqlite
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, 'hygia.sqlite');

    // SqfliteQueryExecutor uses sqflite (platform sqlite), no FFI libs.
    return SqfliteQueryExecutor(
      path: dbPath,
      singleInstance: true,
      // logStatements: true, // uncomment if you want SQL logs
    );
  });
}
