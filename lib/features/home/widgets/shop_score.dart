import 'package:flutter/material.dart';
import 'package:hygiene_v_1/generated/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;

    final todayPercent = todayTarget <= 0 ? 0 : (todayXp / todayTarget) * 100;
    final safeTodayPercent = todayPercent.clamp(0, 100).toDouble();
    final safeVendorScore = vendorScore.clamp(0, 100).toDouble();

    const xpPerLevel = 1000;
    final xpIntoCurrentLevel = totalXp % xpPerLevel;
    final xpToNextLevel = xpPerLevel - xpIntoCurrentLevel;
    final levelProgress = xpIntoCurrentLevel / xpPerLevel;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OverallProgressGauge(
                percent: safeTodayPercent,
                centerLabel: '$todayXp\n/ $todayTarget XP',
                bottomLabel: l10n.today,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.vendorScore,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.verified_rounded,
                          color: theme.colorScheme.primary,
                          size: 34,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          safeVendorScore.toStringAsFixed(0),
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            ' / 100',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                              color: theme.textTheme.bodyMedium?.color
                                  ?.withValues(alpha: 0.65),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    _ScoreBadge(percent: safeVendorScore),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _VendorLevelProgress(
            vendorLevel: vendorLevel,
            xpIntoCurrentLevel: xpIntoCurrentLevel,
            xpPerLevel: xpPerLevel,
            xpToNextLevel: xpToNextLevel,
            progress: levelProgress,
          ),
        ],
      ),
    );
  }
}

class _VendorLevelProgress extends StatelessWidget {
  final int vendorLevel;
  final int xpIntoCurrentLevel;
  final int xpPerLevel;
  final int xpToNextLevel;
  final double progress;

  const _VendorLevelProgress({
    required this.vendorLevel,
    required this.xpIntoCurrentLevel,
    required this.xpPerLevel,
    required this.xpToNextLevel,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final nextLevel = vendorLevel + 1;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.14,
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  l10n.vendorLevelLabel(vendorLevel),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                '$xpIntoCurrentLevel / $xpPerLevel XP',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: progress.clamp(0.0, 1.0),
              minHeight: 10,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.xpNeededToReachLevel(xpToNextLevel, nextLevel),
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.70),
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
    final l10n = AppLocalizations.of(context)!;
    final p = percent.clamp(0, 100).toDouble();

    IconData icon;
    String label;
    Color bg;
    Color fg;

    if (p >= 75) {
      icon = Icons.sentiment_very_satisfied_rounded;
      label = l10n.strongHygiene;
      bg = Colors.green.shade500.withValues(alpha: 0.12);
      fg = Colors.green.shade700;
    } else if (p >= 50) {
      icon = Icons.sentiment_satisfied_rounded;
      label = l10n.improving;
      bg = Colors.amber.shade500.withValues(alpha: 0.14);
      fg = Colors.amber.shade800;
    } else {
      icon = Icons.sentiment_dissatisfied_rounded;
      label = l10n.needsAttention;
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
