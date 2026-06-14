import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hygiene_v_1/features/qr/domain/vendor_qr_data.dart';
import 'package:hygiene_v_1/features/vendor/data/local_vendor_profile_repository.dart';
import 'package:hygiene_v_1/main.dart' show appDb;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygiene_v_1/features/vendor/domain/vendor_profile_model.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  late final LocalVendorProfileRepository _localVendorRepo =
      LocalVendorProfileRepository(appDb);

  late Future<VendorQrData?> _qrFuture;

  @override
  void initState() {
    super.initState();
    _qrFuture = _loadQrData();
  }

  Future<VendorQrData?> _loadQrData() async {
    final localProfile = await _localVendorRepo.getLocalProfile();

    if (localProfile != null) {
      final vendorName = localProfile.shopName.trim().isNotEmpty
          ? localProfile.shopName.trim()
          : localProfile.vendorName.trim();

      return VendorQrData.fromVendorProfile(
        vendorId: localProfile.vendorId,
        vendorName: vendorName.isEmpty ? 'Registered Vendor' : vendorName,
        savedReviewUrl: localProfile.reviewUrl,
      );
    }

    // Local profile is missing after sign out/sign in.
    // Restore it from Firebase using the current signed-in user.
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return null;
    }

    final vendorDoc = await FirebaseFirestore.instance
        .collection('vendors')
        .doc(user.uid)
        .get();

    if (!vendorDoc.exists || vendorDoc.data() == null) {
      return null;
    }

    final data = vendorDoc.data()!;
    final reviewUrl = VendorQrData.buildReviewUrl(user.uid);

    final restoredProfile = VendorProfileModel(
      vendorId: user.uid,
      ownerUid: data['ownerUid'] as String? ?? user.uid,
      vendorName: data['vendorName'] as String? ?? '',
      shopName: data['shopName'] as String? ?? '',
      foodCategory: data['foodCategory'] as String? ?? '',
      description: data['description'] as String? ?? '',
      phoneNumber: data['phoneNumber'] as String? ?? '',
      locationText: data['locationText'] as String? ?? '',
      city: data['city'] as String? ?? '',
      country: data['country'] as String? ?? 'Bangladesh',
      preferredLanguage: data['preferredLanguage'] as String? ?? 'en',
      profileImageUrl: data['profileImageUrl'] as String?,
      reviewUrl: reviewUrl,
    );

    await _localVendorRepo.saveProfile(restoredProfile);

    await FirebaseFirestore.instance.collection('vendors').doc(user.uid).set({
      'reviewUrl': reviewUrl,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    }, SetOptions(merge: true));

    await FirebaseFirestore.instance.collection('vendor_qr').doc(user.uid).set({
      'vendorId': user.uid,
      'reviewUrl': reviewUrl,
      'qrPayload': reviewUrl,
      'isEnabled': true,
      'updatedAt': DateTime.now().millisecondsSinceEpoch,
    }, SetOptions(merge: true));

    final vendorName = restoredProfile.shopName.trim().isNotEmpty
        ? restoredProfile.shopName.trim()
        : restoredProfile.vendorName.trim();

    return VendorQrData.fromVendorProfile(
      vendorId: restoredProfile.vendorId,
      vendorName: vendorName.isEmpty ? 'Registered Vendor' : vendorName,
      savedReviewUrl: restoredProfile.reviewUrl,
    );
  }

  Future<void> _refreshQr() async {
    setState(() {
      _qrFuture = _loadQrData();
    });

    await _qrFuture;
  }

  Future<void> _copyUrl(String reviewUrl) async {
    await Clipboard.setData(ClipboardData(text: reviewUrl));

    if (!mounted) return;

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Review link copied')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<VendorQrData?>(
          future: _qrFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting &&
                snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return _QrErrorView(
                message: 'Could not load vendor QR data.',
                onRetry: _refreshQr,
              );
            }

            final qrData = snapshot.data;

            if (qrData == null) {
              return _NoVendorQrView(onRefresh: _refreshQr);
            }

            return RefreshIndicator(
              onRefresh: _refreshQr,
              child: ListView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.menu_rounded),
                      ),
                      const Spacer(),
                      Text(
                        'Hygia',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.notifications_rounded),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _QrHeroCard(qrData: qrData),
                  const SizedBox(height: 24),
                  _QrLinkCard(
                    reviewUrl: qrData.reviewUrl,
                    vendorId: qrData.vendorId,
                    onCopy: () => _copyUrl(qrData.reviewUrl),
                  ),
                  const SizedBox(height: 24),
                  const Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          title: 'Review Flow',
                          value: 'Active',
                          icon: Icons.qr_code_scanner_rounded,
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: _StatCard(
                          title: 'Customer Form',
                          value: 'Web',
                          icon: Icons.rate_review_rounded,
                          warm: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _HowItWorksCard(reviewUrl: qrData.reviewUrl),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _QrHeroCard extends StatelessWidget {
  final VendorQrData qrData;

  const _QrHeroCard({required this.qrData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 26),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withValues(alpha: 0.55),
          ],
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 18,
            offset: const Offset(0, 10),
            color: Colors.black.withValues(alpha: 0.12),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.22),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'MERCHANT TRUST PASS',
              style: theme.textTheme.labelMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.6,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(28),
              boxShadow: [
                BoxShadow(
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                  color: Colors.black.withValues(alpha: 0.10),
                ),
              ],
            ),
            child: QrImageView(
              data: qrData.reviewUrl,
              version: QrVersions.auto,
              size: 190,
              backgroundColor: Colors.white,
              errorCorrectionLevel: QrErrorCorrectLevel.H,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Scan to Rate Me',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Customers can scan this code to leave a hygiene rating and feedback.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.82),
              fontWeight: FontWeight.w600,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            qrData.vendorName,
            textAlign: TextAlign.center,
            style: theme.textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _QrLinkCard extends StatelessWidget {
  final String reviewUrl;
  final String vendorId;
  final VoidCallback onCopy;

  const _QrLinkCard({
    required this.reviewUrl,
    required this.vendorId,
    required this.onCopy,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vendor Review Link',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Vendor ID: $vendorId',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.70),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            reviewUrl,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onCopy,
              icon: const Icon(Icons.copy_rounded),
              label: const Text('Copy Review Link'),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool warm;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    this.warm = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = warm ? Colors.deepOrange : theme.colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: color.withValues(alpha: 0.14)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 5),
            color: color.withValues(alpha: 0.16),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color),
          const SizedBox(height: 10),
          Text(
            title.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.65),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _HowItWorksCard extends StatelessWidget {
  final String reviewUrl;

  const _HowItWorksCard({required this.reviewUrl});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How this works',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 12),
          const _InfoLine(
            icon: Icons.qr_code_scanner_rounded,
            text: 'Customer scans the QR code.',
          ),
          const _InfoLine(
            icon: Icons.public_rounded,
            text: 'A public review form opens in the browser.',
          ),
          const _InfoLine(
            icon: Icons.rate_review_rounded,
            text: 'Customer leaves a rating and short feedback.',
          ),
          const _InfoLine(
            icon: Icons.insights_rounded,
            text: 'The review updates this vendor’s rating summary.',
          ),
          const SizedBox(height: 12),
          Text(
            reviewUrl,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoLine({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NoVendorQrView extends StatelessWidget {
  final Future<void> Function() onRefresh;

  const _NoVendorQrView({required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 120),
          Icon(
            Icons.qr_code_2_rounded,
            size: 80,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(height: 20),
          Text(
            'No vendor QR code yet',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Register or sign in as a vendor first. After registration, Hygia will generate a unique review QR code for this vendor.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.70),
              height: 1.4,
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: onRefresh,
            icon: const Icon(Icons.refresh_rounded),
            label: const Text('Refresh'),
          ),
        ],
      ),
    );
  }
}

class _QrErrorView extends StatelessWidget {
  final String message;
  final Future<void> Function() onRetry;

  const _QrErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.qr_code_2_rounded,
              size: 58,
              color: theme.colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 14),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
