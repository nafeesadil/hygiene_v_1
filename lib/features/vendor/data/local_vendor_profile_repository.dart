import 'package:drift/drift.dart';
import 'package:hygiene_v_1/core/local_db/drift_db.dart';
import 'package:hygiene_v_1/features/vendor/domain/vendor_profile_model.dart';

class LocalVendorProfileRepository {
  final AppDb _db;

  LocalVendorProfileRepository(this._db);

  Future<LocalVendorProfile?> getLocalProfile() async {
    final rows = await _db.select(_db.localVendorProfiles).get();
    if (rows.isEmpty) return null;
    return rows.first;
  }

  Future<void> saveProfile(
    VendorProfileModel profile, {
    bool isDirty = false,
  }) async {
    final nowMs = DateTime.now().millisecondsSinceEpoch;

    final existing = await (_db.select(
      _db.localVendorProfiles,
    )..where((t) => t.vendorId.equals(profile.vendorId))).getSingleOrNull();

    await _db
        .into(_db.localVendorProfiles)
        .insertOnConflictUpdate(
          LocalVendorProfilesCompanion(
            vendorId: Value(profile.vendorId),
            ownerUid: Value(profile.ownerUid),
            vendorName: Value(profile.vendorName),
            shopName: Value(profile.shopName),
            foodCategory: Value(profile.foodCategory),
            description: Value(profile.description),
            phoneNumber: Value(profile.phoneNumber),
            locationText: Value(profile.locationText),
            city: Value(profile.city),
            country: Value(profile.country),
            preferredLanguage: Value(profile.preferredLanguage),
            profileImageUrl: Value(profile.profileImageUrl),
            reviewUrl: Value(profile.reviewUrl),
            averageRating: Value(existing?.averageRating ?? 0.0),
            reviewCount: Value(existing?.reviewCount ?? 0),
            lastReviewComment: Value(existing?.lastReviewComment),
            createdAtMs: Value(existing?.createdAtMs ?? nowMs),
            updatedAtMs: Value(nowMs),
            lastSyncedAtMs: Value(existing?.lastSyncedAtMs ?? 0),
            isDirty: Value(isDirty),
          ),
        );
  }

  Future<void> updateCachedRatingSummary({
    required String vendorId,
    required double averageRating,
    required int reviewCount,
    String? lastReviewComment,
    int? lastSyncedAtMs,
  }) async {
    await (_db.update(
      _db.localVendorProfiles,
    )..where((t) => t.vendorId.equals(vendorId))).write(
      LocalVendorProfilesCompanion(
        averageRating: Value(averageRating),
        reviewCount: Value(reviewCount),
        lastReviewComment: Value(lastReviewComment),
        lastSyncedAtMs: Value(
          lastSyncedAtMs ?? DateTime.now().millisecondsSinceEpoch,
        ),
      ),
    );
  }

  Future<void> markSynced(String vendorId) async {
    final nowMs = DateTime.now().millisecondsSinceEpoch;

    await (_db.update(
      _db.localVendorProfiles,
    )..where((t) => t.vendorId.equals(vendorId))).write(
      LocalVendorProfilesCompanion(
        isDirty: const Value(false),
        lastSyncedAtMs: Value(nowMs),
      ),
    );
  }

  Future<void> clearLocalProfile() async {
    await _db.delete(_db.localVendorProfiles).go();
  }
}
