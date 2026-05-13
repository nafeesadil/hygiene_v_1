import 'package:drift/drift.dart';
import 'package:hygiene_v_1/core/local_db/drift_db.dart';

class SyncQueueRepository {
  final AppDb _db;

  SyncQueueRepository(this._db);

  Future<void> enqueue({
    required String entityType,
    required String entityId,
    required String operation,
    required String payloadJson,
  }) async {
    final nowMs = DateTime.now().millisecondsSinceEpoch;

    await _db
        .into(_db.syncQueue)
        .insert(
          SyncQueueCompanion.insert(
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payloadJson: payloadJson,
            createdAtMs: nowMs,
          ),
        );
  }

  Future<List<SyncQueueData>> getPending({int limit = 25}) {
    return (_db.select(_db.syncQueue)
          ..orderBy([(t) => OrderingTerm.asc(t.createdAtMs)])
          ..limit(limit))
        .get();
  }

  Future<void> deleteItem(int id) async {
    await (_db.delete(_db.syncQueue)..where((t) => t.id.equals(id))).go();
  }

  Future<void> markFailed(int id, Object error) async {
    final row = await (_db.select(
      _db.syncQueue,
    )..where((t) => t.id.equals(id))).getSingleOrNull();

    await (_db.update(_db.syncQueue)..where((t) => t.id.equals(id))).write(
      SyncQueueCompanion(
        retryCount: Value((row?.retryCount ?? 0) + 1),
        lastError: Value(error.toString()),
      ),
    );
  }
}
