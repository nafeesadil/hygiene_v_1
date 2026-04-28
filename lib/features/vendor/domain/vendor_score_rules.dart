import 'package:hygiene_v_1/features/vendor/domain/vendor_models.dart';

class DailyScoreInput {
  final int earnedXp;
  final int targetXp;
  final bool hitHalfTarget;

  const DailyScoreInput({
    required this.earnedXp,
    required this.targetXp,
    required this.hitHalfTarget,
  });
}

class VendorScoreRules {
  static const int windowDays = 30;

  static double consistencyScore(List<DailyScoreInput> recentDays) {
    if (recentDays.isEmpty) return 0;
    final validDays = recentDays.where((d) => d.hitHalfTarget).length;
    return (validDays / windowDays) * 100;
  }

  static double performanceScore(List<DailyScoreInput> recentDays) {
    if (recentDays.isEmpty) return 0;

    double total = 0;
    for (final day in recentDays) {
      if (day.targetXp <= 0) continue;
      final ratio = day.earnedXp / day.targetXp;
      total += ratio > 1 ? 1 : ratio;
    }

    return (total / windowDays) * 100;
  }

  static double masteryScore(List<int> activeTaskLevels) {
    if (activeTaskLevels.isEmpty) return 0;

    final totalLevels = activeTaskLevels.fold<int>(
      0,
      (sum, level) => sum + level,
    );
    final maxLevels = activeTaskLevels.length * 5;

    if (maxLevels == 0) return 0;
    return (totalLevels / maxLevels) * 100;
  }

  static VendorScoreBreakdown calculate({
    required List<DailyScoreInput> recentDays,
    required List<int> activeTaskLevels,
  }) {
    final consistency = consistencyScore(recentDays);
    final performance = performanceScore(recentDays);
    final mastery = masteryScore(activeTaskLevels);

    final finalScore =
        (0.50 * consistency) + (0.30 * performance) + (0.20 * mastery);

    return VendorScoreBreakdown(
      consistencyScore: consistency,
      performanceScore: performance,
      masteryScore: mastery,
      finalScore: finalScore,
    );
  }
}
