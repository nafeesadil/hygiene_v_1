import 'package:flutter/material.dart';
import 'package:hygiene_v_1/features/qr/domain/vendor_qr_data.dart';
import 'package:hygiene_v_1/features/vendor/data/local_vendor_profile_repository.dart';
import 'package:hygiene_v_1/main.dart' show appDb;
import 'package:qr_flutter/qr_flutter.dart';

class QrPage extends StatefulWidget {
  const QrPage({super.key});

  @override
  State<QrPage> createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  late final LocalVendorProfileRepository _localVendorRepo =
      LocalVendorProfileRepository(appDb);

  late Future<VendorQrData> _qrFuture;

  @override
  void initState() {
    super.initState();
    _qrFuture = _loadQrData();
  }

  Future<VendorQrData> _loadQrData() async {
    final localProfile = await _localVendorRepo.getLocalProfile();

    if (localProfile == null) {
      return VendorQrData.mock();
    }

    return VendorQrData(
      vendorId: localProfile.vendorId,
      vendorName: localProfile.shopName.isNotEmpty
          ? localProfile.shopName
          : localProfile.vendorName,
      reviewUrl: localProfile.reviewUrl,
    );
  }

  Future<void> _refreshQr() async {
    setState(() {
      _qrFuture = _loadQrData();
    });

    await _qrFuture;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder<VendorQrData>(
          future: _qrFuture,
          builder: (context, snapshot) {
            final qrData = snapshot.data;

            if (snapshot.connectionState == ConnectionState.waiting &&
                qrData == null) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return _QrErrorView(
                message: 'Could not load vendor QR data.',
                onRetry: _refreshQr,
              );
            }

            final data = qrData ?? VendorQrData.mock();

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
                  _QrHeroCard(qrData: data),
                  const SizedBox(height: 24),
                  Row(
                    children: const [
                      Expanded(
                        child: _StatCard(
                          title: 'Current Points',
                          value: '2,450',
                          icon: Icons.bolt_rounded,
                        ),
                      ),
                      SizedBox(width: 14),
                      Expanded(
                        child: _StatCard(
                          title: 'Trust Score',
                          value: '98%',
                          icon: Icons.verified_rounded,
                          warm: true,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _HowItWorksCard(reviewUrl: data.reviewUrl),
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
            icon: Icons.rate_review_rounded,
            text: 'Customer leaves a rating and short feedback.',
          ),
          const _InfoLine(
            icon: Icons.insights_rounded,
            text: 'Reviews will later update the public customer rating.',
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
