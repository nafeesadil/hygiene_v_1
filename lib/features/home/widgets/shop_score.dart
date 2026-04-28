import 'package:flutter/material.dart';
import 'package:hygiene_v_1/features/home/widgets/active_task_progress.dart';

class HygieneScoreSummary extends StatelessWidget {
  final double vendorScore;
  final int vendorLevel;
  final int totalXp;
  final int todayXp;
  final int todayTarget;
  final int currentStreak;
  final int bestStreak;
  final VoidCallback? onTap;

  const HygieneScoreSummary({
    super.key,
    required this.vendorScore,
    required this.vendorLevel,
    required this.totalXp,
    required this.todayXp,
    required this.todayTarget,
    required this.currentStreak,
    required this.bestStreak,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final todayPercent = todayTarget <= 0 ? 0 : (todayXp / todayTarget) * 100;
    final safeTodayPercent = todayPercent.clamp(0, 100).toDouble();
    final safeVendorScore = vendorScore.clamp(0, 100).toDouble();

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OverallProgressGauge(
            percent: safeTodayPercent,
            centerLabel: '$todayXp\n/ $todayTarget XP',
            bottomLabel: 'Today',
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Vendor Score',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      color: theme.colorScheme.primary,
                      size: 34,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      safeVendorScore.toStringAsFixed(1),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _ScoreBadge(percent: safeVendorScore),
                const SizedBox(height: 14),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoChip(
                      icon: Icons.workspace_premium_rounded,
                      label: 'Level $vendorLevel',
                    ),
                    _InfoChip(icon: Icons.bolt_rounded, label: '$totalXp XP'),
                    _InfoChip(
                      icon: Icons.local_fire_department_rounded,
                      label: '$currentStreak d streak',
                    ),
                    _InfoChip(
                      icon: Icons.emoji_events_rounded,
                      label: 'Best $bestStreak d',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.14),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _ScoreBadge extends StatelessWidget {
  final double percent;
  const _ScoreBadge({required this.percent});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = percent.clamp(0, 100).toDouble();

    IconData icon;
    String label;
    Color bg;
    Color fg;

    if (p >= 75) {
      icon = Icons.sentiment_very_satisfied_rounded;
      label = 'Strong hygiene';
      bg = Colors.green.shade500.withValues(alpha: 0.12);
      fg = Colors.green.shade700;
    } else if (p >= 50) {
      icon = Icons.sentiment_satisfied_rounded;
      label = 'Improving';
      bg = Colors.amber.shade500.withValues(alpha: 0.14);
      fg = Colors.amber.shade800;
    } else {
      icon = Icons.sentiment_dissatisfied_rounded;
      label = 'Needs attention';
      bg = Colors.red.shade500.withValues(alpha: 0.12);
      fg = Colors.red.shade700;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: fg.withValues(alpha: 0.25)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: fg),
          const SizedBox(width: 6),
          Text(
            label,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }
}
