import 'package:flutter/material.dart';
import 'package:hygiene_v_1/generated/l10n/app_localizations.dart';

class StreakStatusCard extends StatelessWidget {
  final int currentStreak;
  final int bestStreak;
  final int todayXp;
  final int todayTarget;

  const StreakStatusCard({
    super.key,
    required this.currentStreak,
    required this.bestStreak,
    required this.todayXp,
    required this.todayTarget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    final halfTarget = (todayTarget * 0.5).ceil();
    final remaining = (halfTarget - todayXp).clamp(0, halfTarget);
    final safeToday = todayXp >= halfTarget;

    final bgColor = safeToday
        ? Colors.green.withValues(alpha: 0.10)
        : Colors.orange.withValues(alpha: 0.10);

    final borderColor = safeToday
        ? Colors.green.withValues(alpha: 0.25)
        : Colors.orange.withValues(alpha: 0.25);

    final iconColor = safeToday
        ? Colors.green.shade700
        : Colors.orange.shade800;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(Icons.local_fire_department_rounded, size: 34, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.workingStreak(currentStreak),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  safeToday
                      ? l10n.streakProtectedToday(bestStreak)
                      : l10n.earnMoreXpToProtectStreak(remaining),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
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
