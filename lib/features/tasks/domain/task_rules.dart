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

Duration taskCooldownFor(TaskDefinition def) {
  final minutes = def.minGapMinutes ?? 0;
  return Duration(minutes: minutes);
}

int taskXpForCompletion(TaskDefinition def, int level) {
  return taskValuePointsForLevel(def, level);
}
