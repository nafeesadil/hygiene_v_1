import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hygiene_v_1/features/home/widgets/shop_score.dart';

// Keep this only if you still want the test write button.
// Remove later.
// import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _todayProgressPercent =
      40; // changes during the day (avg of active tasks today)
  double _overallHygieneScorePercent =
      70; // slower score (e.g., last 14 days / last synced)

  static const _kShopIsOpen = 'shop_is_open';
  static const _kShopOpenedAtMs = 'shop_opened_at_ms';

  bool _isOpen = false;
  DateTime? _openedAt;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _loadShopState();
    _loadTodayProgress();
    _loadOverallHygieneScore();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _loadTodayProgress() async {
    // Phase 1: dummy
    // Later: compute offline from local DB (active tasks compliance avg for TODAY)
    setState(() => _todayProgressPercent = 65);
  }

  Future<void> _loadOverallHygieneScore() async {
    // Phase 1: dummy (or last known from local storage)
    // Later: compute offline rolling score OR load last synced score
    setState(() => _overallHygieneScorePercent = 70);
  }

  Future<void> _loadShopState() async {
    final prefs = await SharedPreferences.getInstance();
    final isOpen = prefs.getBool(_kShopIsOpen) ?? false;
    final openedAtMs = prefs.getInt(_kShopOpenedAtMs);

    DateTime? openedAt;
    if (openedAtMs != null) {
      openedAt = DateTime.fromMillisecondsSinceEpoch(openedAtMs);
    }

    setState(() {
      _isOpen = isOpen;
      _openedAt = openedAt;
    });

    _startOrStopTicker();
  }

  void _startOrStopTicker() {
    _ticker?.cancel();

    if (_isOpen && _openedAt != null) {
      // Update UI every second for the counter.
      _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() {});
      });
    }
  }

  Future<void> _toggleShop() async {
    final prefs = await SharedPreferences.getInstance();

    if (_isOpen) {
      // Close shop
      await prefs.setBool(_kShopIsOpen, false);

      setState(() {
        _isOpen = false;
        // Keep _openedAt for display? Usually no—reset it.
        _openedAt = null;
      });

      _startOrStopTicker();

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Shop is closed')));
    } else {
      // Open shop
      final now = DateTime.now();
      await prefs.setBool(_kShopIsOpen, true);
      await prefs.setInt(_kShopOpenedAtMs, now.millisecondsSinceEpoch);

      setState(() {
        _isOpen = true;
        _openedAt = now;
      });

      _startOrStopTicker();

      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Shop is open')));
    }
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

    final Duration openFor = (_isOpen && _openedAt != null)
        ? DateTime.now().difference(_openedAt!)
        : Duration.zero;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleShop,
        backgroundColor: _isOpen ? Colors.green : Colors.red,
        child: Icon(_isOpen ? Icons.store : Icons.store_outlined),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row
              Row(
                children: [
                  Text(
                    'My ',
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('Home', style: TextStyle(fontSize: 28)),
                  const Spacer(),
                ],
              ),

              const SizedBox(height: 24),

              // Square card
              AspectRatio(
                aspectRatio: 1, // makes it a square
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: theme.cardColor,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(
                      color: theme.dividerColor.withValues(alpha: 0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 12,
                        spreadRadius: 0,
                        offset: const Offset(0, 6),
                        color: Colors.black.withValues(alpha: 0.06),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _isOpen ? 'Welcome back 👋' : 'Welcome 👋',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isOpen
                            ? 'Your shop is currently open.'
                            : 'Tap the button to open your shop.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withValues(
                            alpha: 0.75,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      HygieneScoreSummary(
                        todayPercent: _todayProgressPercent,
                        overallPercent: _overallHygieneScorePercent,
                      ),

                      SizedBox(height: 10),

                      Text(
                        'Open for',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color?.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _isOpen ? _formatDuration(openFor) : '00:00:00',
                        style: theme.textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Icon(
                            _isOpen ? Icons.circle : Icons.circle_outlined,
                            size: 14,
                            color: _isOpen ? Colors.green : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _isOpen ? 'Status: Open' : 'Status: Closed',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
