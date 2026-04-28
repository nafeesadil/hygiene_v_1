import 'package:hygiene_v_1/features/tasks/domain/task_definition.dart';

int taskTargetForLevel(TaskDefinition def, int level) {
  final idx = (level - 1).clamp(0, def.levels.length - 1);
  return def.levels[idx].timesPerDayTarget;
}

int taskValuePointsForLevel(TaskDefinition def, int level) {
  final idx = (level - 1).clamp(0, def.levels.length - 1);
  return def.levels[idx].valuePoints;
}

int taskEffectiveDailyCap(TaskDefinition def, int level) {
  final target = taskTargetForLevel(def, level);
  final cap = def.dailyCap;
  if (cap == null) return target;
  return cap < target ? target : cap;
}

// Duration taskCooldownFor(TaskDefinition def) {
//   final minutes = def.minGapMinutes ?? 0;
//   return Duration(minutes: minutes);
// }

Duration taskCooldownFor(TaskDefinition def) {
  final minutes = def.minGapMinutes ?? 0;

  // TEMPORARY TEST MODE:
  // Any task that normally has a cooldown will use 10 seconds instead.
  if (minutes > 0) {
    return const Duration(seconds: 10);
  }

  return Duration.zero;
}

int taskXpForCompletion(TaskDefinition def, int level) {
  return taskValuePointsForLevel(def, level);
}
