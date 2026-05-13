import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygiene_v_1/features/auth/domain/app_user.dart';
import 'package:hygiene_v_1/features/vendor/domain/vendor_profile_model.dart';

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  AuthRepository({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance;

  User? get currentFirebaseUser => _auth.currentUser;

  Stream<User?> authStateChanges() => _auth.authStateChanges();

  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<UserCredential> registerVendor({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String preferredLanguage,
    required VendorProfileModel Function(String uid) createVendorProfile,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    final uid = credential.user!.uid;
    final nowMs = DateTime.now().millisecondsSinceEpoch;

    final appUser = AppUser(
      uid: uid,
      role: AppUserRole.vendor,
      fullName: fullName,
      email: email.trim(),
      phoneNumber: phoneNumber,
      preferredLanguage: preferredLanguage,
      isActive: true,
    );

    final vendor = createVendorProfile(uid);

    final batch = _firestore.batch();

    batch.set(_firestore.collection('users').doc(uid), {
      ...appUser.toMap(),
      'createdAt': nowMs,
    });

    batch.set(_firestore.collection('vendors').doc(uid), {
      ...vendor.toFirestoreMap(),
      'createdAt': nowMs,
    });

    batch.set(_firestore.collection('vendor_qr').doc(uid), {
      'vendorId': uid,
      'reviewUrl': vendor.reviewUrl,
      'qrPayload': vendor.reviewUrl,
      'isEnabled': true,
      'createdAt': nowMs,
      'updatedAt': nowMs,
    });

    batch.set(_firestore.collection('vendor_rating_summaries').doc(uid), {
      'vendorId': uid,
      'averageRating': 0.0,
      'reviewCount': 0,
      'rating1Count': 0,
      'rating2Count': 0,
      'rating3Count': 0,
      'rating4Count': 0,
      'rating5Count': 0,
      'lastReviewComment': null,
      'lastReviewAt': null,
      'updatedAt': nowMs,
    });

    await batch.commit();

    return credential;
  }

  Future<AppUser?> getCurrentAppUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (!doc.exists || doc.data() == null) return null;

    return AppUser.fromMap(doc.data()!);
  }
}
