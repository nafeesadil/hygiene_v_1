class VendorScoreBreakdown {
  final double consistencyScore;
  final double performanceScore;
  final double masteryScore;
  final double finalScore;

  const VendorScoreBreakdown({
    required this.consistencyScore,
    required this.performanceScore,
    required this.masteryScore,
    required this.finalScore,
  });
}

class VendorDashboard {
  final int totalXp;
  final int vendorLevel;
  final int todayXp;
  final int todayTarget;
  final int currentStreak;
  final int bestStreak;
  final double vendorScore;
  final VendorScoreBreakdown breakdown;

  const VendorDashboard({
    required this.totalXp,
    required this.vendorLevel,
    required this.todayXp,
    required this.todayTarget,
    required this.currentStreak,
    required this.bestStreak,
    required this.vendorScore,
    required this.breakdown,
  });
}
