import 'dart:async';

import 'package:drift/drift.dart' show InsertMode, Value;
import 'package:flutter/material.dart';
import 'package:hygiene_v_1/core/local_db/drift_db.dart'
    show ShopStateCompanion, LocalVendorProfile;
import 'package:hygiene_v_1/features/home/widgets/customer_reviews_card.dart';
import 'package:hygiene_v_1/features/home/widgets/shop_score.dart';
import 'package:hygiene_v_1/features/home/widgets/streak_status_card.dart';
import 'package:hygiene_v_1/features/sync/application/cloud_sync_service.dart';
import 'package:hygiene_v_1/features/tasks/data/task_repository.dart';
import 'package:hygiene_v_1/features/vendor/data/local_vendor_profile_repository.dart';
import 'package:hygiene_v_1/features/vendor/data/vendor_repository.dart';
import 'package:hygiene_v_1/features/vendor/domain/vendor_models.dart';
import 'package:hygiene_v_1/main.dart' show appDb;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TaskRepository _taskRepo = TaskRepository(appDb);
  final VendorRepository _vendorRepo = VendorRepository(appDb);
  final LocalVendorProfileRepository _localVendorProfileRepo =
      LocalVendorProfileRepository(appDb);
  late final CloudSyncService _cloudSyncService = CloudSyncService(appDb);

  bool _isOpen = false;
  DateTime? _openedAt;
  Timer? _ticker;
  VendorDashboard? _dashboard;
  LocalVendorProfile? _localVendorProfile;
  int _activeTaskCount = 0;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _loadAll() async {
    await _loadShopState();
    await _loadDashboard();
    await _loadActiveTasks();

    // Pull latest customer rating/review summary from Firebase
    // and save it into the local vendor profile cache.
    await _cloudSyncService.pullRatingSummaryForLocalVendor();

    // Reload local profile after sync so the CustomerReviewsCard updates.
    await _loadLocalVendorProfile();
  }

  Future<void> _loadDashboard() async {
    final dashboard = await _vendorRepo.getDashboard();
    if (!mounted) return;

    setState(() {
      _dashboard = dashboard;
    });
  }

  Future<void> _loadActiveTasks() async {
    final tasks = await _taskRepo.getActiveTasks();
    if (!mounted) return;

    setState(() {
      _activeTaskCount = tasks.length;
    });
  }

  Future<void> _loadLocalVendorProfile() async {
    final profile = await _localVendorProfileRepo.getLocalProfile();
    if (!mounted) return;

    setState(() {
      _localVendorProfile = profile;
    });
  }

  Future<void> _loadShopState() async {
    await appDb
        .into(appDb.shopState)
        .insert(
          ShopStateCompanion.insert(id: const Value(0)),
          mode: InsertMode.insertOrIgnore,
        );

    final row = await (appDb.select(
      appDb.shopState,
    )..where((s) => s.id.equals(0))).getSingle();

    final openedAt = row.openedAtMs == 0
        ? null
        : DateTime.fromMillisecondsSinceEpoch(row.openedAtMs);

    if (!mounted) return;

    setState(() {
      _isOpen = row.isOpen;
      _openedAt = openedAt;
    });

    _startOrStopTicker();
  }

  void _startOrStopTicker() {
    _ticker?.cancel();

    if (_isOpen && _openedAt != null) {
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    }
  }

  Future<void> _toggleShop() async {
    final next = !_isOpen;

    await _taskRepo.setShopOpen(next);
    await _loadAll();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(next ? 'Shop is open' : 'Shop is closed')),
    );
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours;
    final minutes = d.inMinutes.remainder(60);
    final seconds = d.inSeconds.remainder(60);

    String two(int n) => n.toString().padLeft(2, '0');
    return '${two(hours)}:${two(minutes)}:${two(seconds)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final dashboard = _dashboard;
    final openFor = (_isOpen && _openedAt != null)
        ? DateTime.now().difference(_openedAt!)
        : Duration.zero;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _toggleShop,
        backgroundColor: _isOpen ? Colors.green : Colors.red,
        icon: Icon(_isOpen ? Icons.store : Icons.store_outlined),
        label: Text(_isOpen ? 'Close Shop' : 'Open Shop'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadAll,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            children: [
              Row(
                children: [
                  Text(
                    'My Home',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    _isOpen ? Icons.circle : Icons.circle_outlined,
                    size: 14,
                    color: _isOpen ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _isOpen ? 'Open' : 'Closed',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              if (dashboard == null)
                _LoadingHomeCard(theme: theme)
              else ...[
                _DashboardCard(
                  isOpen: _isOpen,
                  openFor: openFor,
                  activeTaskCount: _activeTaskCount,
                  dashboard: dashboard,
                  formatDuration: _formatDuration,
                ),

                const SizedBox(height: 16),

                StreakStatusCard(
                  currentStreak: dashboard.currentStreak,
                  bestStreak: dashboard.bestStreak,
                  todayXp: dashboard.todayXp,
                  todayTarget: dashboard.todayTarget,
                ),

                const SizedBox(height: 16),

                CustomerReviewsCard(
                  rating: _localVendorProfile?.averageRating ?? 0.0,
                  reviewCount: _localVendorProfile?.reviewCount ?? 0,
                  reviewerName: 'Latest customer',
                  comment:
                      _localVendorProfile?.lastReviewComment ??
                      'Customer reviews will appear here after customers scan your QR code and leave feedback.',
                  timeLabel: (_localVendorProfile?.reviewCount ?? 0) > 0
                      ? 'Latest review'
                      : 'No reviews yet',
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingHomeCard extends StatelessWidget {
  final ThemeData theme;

  const _LoadingHomeCard({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.18)),
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _DashboardCard extends StatelessWidget {
  final bool isOpen;
  final Duration openFor;
  final int activeTaskCount;
  final VendorDashboard dashboard;
  final String Function(Duration duration) formatDuration;

  const _DashboardCard({
    required this.isOpen,
    required this.openFor,
    required this.activeTaskCount,
    required this.dashboard,
    required this.formatDuration,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 6),
            color: Colors.black.withValues(alpha: 0.06),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isOpen ? 'Welcome back 👋' : 'Welcome 👋',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            isOpen
                ? 'Your hygiene progress is being tracked while the shop is open.'
                : 'Open your shop to begin tracking today’s hygiene progress.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 18),
          HygieneScoreSummary(
            vendorScore: dashboard.vendorScore,
            vendorLevel: dashboard.vendorLevel,
            totalXp: dashboard.totalXp,
            todayXp: dashboard.todayXp,
            todayTarget: dashboard.todayTarget,
            currentStreak: dashboard.currentStreak,
            bestStreak: dashboard.bestStreak,
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _MetricTile(
                icon: Icons.task_alt_rounded,
                title: 'Active Tasks',
                value: '$activeTaskCount',
              ),
              _MetricTile(
                icon: Icons.flag_rounded,
                title: 'Today Target',
                value: '${dashboard.todayTarget} XP',
              ),
              _MetricTile(
                icon: Icons.insights_rounded,
                title: 'Consistency',
                value:
                    '${dashboard.breakdown.consistencyScore.toStringAsFixed(0)}%',
              ),
              _MetricTile(
                icon: Icons.auto_graph_rounded,
                title: 'Performance',
                value:
                    '${dashboard.breakdown.performanceScore.toStringAsFixed(0)}%',
              ),
            ],
          ),
          const SizedBox(height: 18),
          Text(
            'Open for',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.textTheme.bodyMedium?.color?.withValues(alpha: 0.70),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            isOpen ? formatDuration(openFor) : '00:00:00',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _MetricTile({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: 155,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.10),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
