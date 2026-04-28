import 'package:drift/drift.dart';
import 'package:hygiene_v_1/core/local_db/drift_db.dart';
import 'package:hygiene_v_1/features/vendor/domain/vendor_models.dart';
import 'package:hygiene_v_1/features/vendor/domain/vendor_progress_rules.dart';
import 'package:hygiene_v_1/features/vendor/domain/vendor_score_rules.dart';

class VendorRepository {
  final AppDb _db;

  VendorRepository(this._db);

  String _dateKey(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  Future<void> markShopOpenedToday() async {
    await ensureSeeded();

    final now = DateTime.now();
    final todayKey = _dateKey(now);

    final state = await getStateRow();
    final todayTarget = dailyTargetForVendorLevel(state.vendorLevel);

    final daily = await _ensureDailyRow(
      dateKey: todayKey,
      targetXp: todayTarget,
    );

    await (_db.update(
      _db.vendorDailyStats,
    )..where((t) => t.dateKey.equals(todayKey))).write(
      VendorDailyStatsCompanion(
        shopOpened: const Value(true),
        updatedAtMs: Value(now.millisecondsSinceEpoch),
        targetXp: Value(daily.targetXp),
      ),
    );
  }

  Future<void> ensureSeeded() async {
    final row = await (_db.select(
      _db.vendorState,
    )..where((t) => t.id.equals(0))).getSingleOrNull();

    if (row != null) return;

    await _db
        .into(_db.vendorState)
        .insert(
          VendorStateCompanion.insert(
            id: const Value(0),
            updatedAtMs: Value(DateTime.now().millisecondsSinceEpoch),
          ),
        );
  }

  Future<VendorStateData> getStateRow() async {
    await ensureSeeded();
    final row = await (_db.select(
      _db.vendorState,
    )..where((t) => t.id.equals(0))).getSingleOrNull();

    if (row == null) {
      throw StateError('VendorState row not found after seeding.');
    }
    return row;
  }

  Future<VendorDailyStat?> getDailyRow(String dateKey) async {
    return (_db.select(
      _db.vendorDailyStats,
    )..where((t) => t.dateKey.equals(dateKey))).getSingleOrNull();
  }

  Future<VendorDailyStat> _ensureDailyRow({
    required String dateKey,
    required int targetXp,
  }) async {
    final existing = await getDailyRow(dateKey);
    if (existing != null) return existing;

    final nowMs = DateTime.now().millisecondsSinceEpoch;

    await _db
        .into(_db.vendorDailyStats)
        .insert(
          VendorDailyStatsCompanion.insert(
            dateKey: dateKey,
            targetXp: Value(targetXp),
            createdAtMs: Value(nowMs),
            updatedAtMs: Value(nowMs),
          ),
        );

    final created = await getDailyRow(dateKey);
    if (created == null) {
      throw StateError('Failed to create VendorDailyStats row for $dateKey');
    }
    return created;
  }

  Future<void> addEarnedXp(int earnedXp) async {
    if (earnedXp <= 0) return;

    await ensureSeeded();

    final now = DateTime.now();
    final todayKey = _dateKey(now);

    await _db.transaction(() async {
      final state = await getStateRow();
      final todayTarget = dailyTargetForVendorLevel(state.vendorLevel);

      final daily = await _ensureDailyRow(
        dateKey: todayKey,
        targetXp: todayTarget,
      );

      final newDailyXp = daily.earnedXp + earnedXp;
      final halfHit = hitHalfTarget(newDailyXp, daily.targetXp);
      final fullHit = hitFullTarget(newDailyXp, daily.targetXp);

      await (_db.update(
        _db.vendorDailyStats,
      )..where((t) => t.dateKey.equals(todayKey))).write(
        VendorDailyStatsCompanion(
          earnedXp: Value(newDailyXp),
          hitHalfTargetFlag: Value(halfHit),
          hitFullTargetFlag: Value(fullHit),
          updatedAtMs: Value(now.millisecondsSinceEpoch),
        ),
      );

      final newTotalXp = state.totalXp + earnedXp;
      final newLevel = vendorLevelFromXp(newTotalXp);

      await (_db.update(_db.vendorState)..where((t) => t.id.equals(0))).write(
        VendorStateCompanion(
          totalXp: Value(newTotalXp),
          vendorLevel: Value(newLevel),
          updatedAtMs: Value(now.millisecondsSinceEpoch),
        ),
      );
    });

    await recomputeVendorScore();
    await refreshBestStreak();
  }

  Future<List<VendorDailyStat>> getRecentDailyRows({int days = 30}) async {
    final now = DateTime.now();
    final keys = <String>[];

    for (int i = 0; i < days; i++) {
      final dt = now.subtract(Duration(days: i));
      keys.add(_dateKey(dt));
    }

    final rows = await (_db.select(
      _db.vendorDailyStats,
    )..where((t) => t.dateKey.isIn(keys))).get();

    rows.sort((a, b) => a.dateKey.compareTo(b.dateKey));
    return rows;
  }

  Future<int> getCurrentStreak() async {
    final now = DateTime.now();
    int streak = 0;

    for (int i = 0; i < 365; i++) {
      final day = now.subtract(Duration(days: i));
      final key = _dateKey(day);
      final row = await getDailyRow(key);

      // Closed/non-working days pause the streak.
      if (row == null || !row.shopOpened) {
        continue;
      }

      // Working day + reached 50% target = streak continues.
      if (row.hitHalfTargetFlag) {
        streak++;
        continue;
      }

      // Working day + failed 50% target = streak breaks.
      break;
    }

    return streak;
  }

  Future<void> refreshBestStreak() async {
    final current = await getCurrentStreak();
    final state = await getStateRow();

    if (current <= state.bestStreak) return;

    await (_db.update(_db.vendorState)..where((t) => t.id.equals(0))).write(
      VendorStateCompanion(bestStreak: Value(current)),
    );
  }

  Future<VendorScoreBreakdown> recomputeVendorScore() async {
    await ensureSeeded();

    final recent = await getRecentDailyRows(days: 30);

    final inputs = recent
        .map(
          (row) => DailyScoreInput(
            earnedXp: row.earnedXp,
            targetXp: row.targetXp,
            hitHalfTarget: row.hitHalfTargetFlag,
          ),
        )
        .toList();

    final activeTasks = await (_db.select(
      _db.tasks,
    )..where((t) => t.isActive.equals(true))).get();

    final breakdown = VendorScoreRules.calculate(
      recentDays: inputs,
      activeTaskLevels: activeTasks.map((e) => e.level).toList(),
    );

    await (_db.update(_db.vendorState)..where((t) => t.id.equals(0))).write(
      VendorStateCompanion(
        vendorScore: Value(breakdown.finalScore),
        updatedAtMs: Value(DateTime.now().millisecondsSinceEpoch),
      ),
    );

    return breakdown;
  }

  Future<VendorDashboard> getDashboard() async {
    await ensureSeeded();

    final state = await getStateRow();
    final todayKey = _dateKey(DateTime.now());
    final todayRow = await getDailyRow(todayKey);

    final breakdown = await recomputeVendorScore();
    final currentStreak = await getCurrentStreak();

    return VendorDashboard(
      totalXp: state.totalXp,
      vendorLevel: state.vendorLevel,
      todayXp: todayRow?.earnedXp ?? 0,
      todayTarget:
          todayRow?.targetXp ?? dailyTargetForVendorLevel(state.vendorLevel),
      currentStreak: currentStreak,
      bestStreak: state.bestStreak,
      vendorScore: breakdown.finalScore,
      breakdown: breakdown,
    );
  }
}
