import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../features/tasks/data/drift/tasks_tables.dart';
import '../../features/tasks/data/drift/shop_state_table.dart';

part 'drift_db.g.dart';

@DriftDatabase(tables: [Tasks, TaskLogs, ShopState])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 2;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path, 'hygia.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
