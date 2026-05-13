import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:hygiene_v_1/core/local_db/drift_db.dart';
import 'package:hygiene_v_1/features/sync/data/sync_queue_repository.dart';
import 'package:hygiene_v_1/features/vendor/data/local_vendor_profile_repository.dart';

class CloudSyncService {
  final AppDb _db;
  final FirebaseFirestore _firestore;
  final Connectivity _connectivity;

  late final SyncQueueRepository _queueRepo;
  late final LocalVendorProfileRepository _localVendorRepo;

  CloudSyncService(
    this._db, {
    FirebaseFirestore? firestore,
    Connectivity? connectivity,
  }) : _firestore = firestore ?? FirebaseFirestore.instance,
       _connectivity = connectivity ?? Connectivity() {
    _queueRepo = SyncQueueRepository(_db);
    _localVendorRepo = LocalVendorProfileRepository(_db);
  }

  Future<bool> get hasConnection async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  Future<void> syncPending() async {
    if (!await hasConnection) return;

    final items = await _queueRepo.getPending();

    for (final item in items) {
      try {
        switch (item.operation) {
          case 'update_vendor_profile':
            await _syncVendorProfile(item.entityId, item.payloadJson);
            break;

          case 'sync_rating_summary_cache':
            await _syncRatingSummaryCache(item.entityId);
            break;

          default:
            break;
        }

        await _queueRepo.deleteItem(item.id);
      } catch (e) {
        await _queueRepo.markFailed(item.id, e);
      }
    }
  }

  Future<void> _syncVendorProfile(String vendorId, String payloadJson) async {
    final data = jsonDecode(payloadJson) as Map<String, dynamic>;

    data['updatedAt'] = DateTime.now().millisecondsSinceEpoch;

    await _firestore
        .collection('vendors')
        .doc(vendorId)
        .set(data, SetOptions(merge: true));

    await _localVendorRepo.markSynced(vendorId);
  }

  Future<void> _syncRatingSummaryCache(String vendorId) async {
    final doc = await _firestore
        .collection('vendor_rating_summaries')
        .doc(vendorId)
        .get();

    if (!doc.exists || doc.data() == null) return;

    final data = doc.data()!;

    await _localVendorRepo.updateCachedRatingSummary(
      vendorId: vendorId,
      averageRating: (data['averageRating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (data['reviewCount'] as num?)?.toInt() ?? 0,
      lastReviewComment: data['lastReviewComment'] as String?,
      lastSyncedAtMs: DateTime.now().millisecondsSinceEpoch,
    );
  }

  Future<void> pullRatingSummaryForLocalVendor() async {
    if (!await hasConnection) return;

    final local = await _localVendorRepo.getLocalProfile();
    if (local == null) return;

    await _syncRatingSummaryCache(local.vendorId);
  }
}
