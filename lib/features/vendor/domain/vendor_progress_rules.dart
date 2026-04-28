int vendorLevelFromXp(int totalXp) {
  if (totalXp < 0) return 1;
  return (totalXp ~/ 1000) + 1;
}

int dailyTargetForVendorLevel(int vendorLevel) {
  final safeLevel = vendorLevel < 1 ? 1 : vendorLevel;
  return 300 + ((safeLevel - 1) * 50);
}

bool hitHalfTarget(int earnedXp, int targetXp) {
  if (targetXp <= 0) return false;
  return earnedXp >= (targetXp * 0.5);
}

bool hitFullTarget(int earnedXp, int targetXp) {
  if (targetXp <= 0) return false;
  return earnedXp >= targetXp;
}

double completionRatio(int earnedXp, int targetXp) {
  if (targetXp <= 0) return 0;
  final ratio = earnedXp / targetXp;
  return ratio > 1 ? 1 : ratio;
}
