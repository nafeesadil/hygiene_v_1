import 'package:flutter/material.dart';
import 'package:hygiene_v_1/features/home/widgets/active_task_progress.dart';

/// Home summary block: Overall shop hygiene score (icon-first, low text).
/// Pass a percent (0..100). Later you’ll pass the computed overall score.
class HygieneScoreSummary extends StatelessWidget {
  final double todayPercent; // ring
  final double overallPercent; // score
  // 0..100
  final VoidCallback? onTap; // optional: later navigate to “details”

  const HygieneScoreSummary({
    super.key,
    required this.todayPercent,
    required this.overallPercent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gaugePercent = todayPercent.clamp(0, 100).toDouble();
    final scorePercent = overallPercent.clamp(0, 100).toDouble();
    final scoreText = scorePercent.toStringAsFixed(0);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Gauge (already includes the ring + % + quote)
          OverallProgressGauge(percent: gaugePercent),

          const SizedBox(width: 14),

          // Right-side, icon-first summary
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Shop Score',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 8),
                // Score line (big number + trust icon)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_rounded,
                      color: theme.colorScheme.primary,
                      size: 40,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      scoreText,
                      style: theme.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                        height: 1.0,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                _ScoreBadge(percent: scorePercent),

                const SizedBox(height: 12),

                // Minimal “what matters” icons (keep text short)
              ],
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
      label = 'Good';
      bg = Colors.green.shade500.withValues(alpha: 0.12);
      fg = Colors.green.shade700;
    } else if (p >= 50) {
      icon = Icons.sentiment_satisfied_rounded;
      label = 'OK';
      bg = Colors.amber.shade500.withValues(alpha: 0.14);
      fg = Colors.amber.shade800;
    } else {
      icon = Icons.sentiment_dissatisfied_rounded;
      label = 'Low';
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
