import 'package:flutter/material.dart';

/// ----------------------------
/// ENUMS (NEW)
/// ----------------------------

enum TaskCategory {
  personalHygiene,
  foodHandling,
  waterSafety,
  equipmentCare,
  storage,
  environment,
  waste,
}

enum TaskKind {
  repeatable, // e.g. handwash, clean utensils
  checklist, // once per day (multi-step)
  timed, // e.g. every X hours
  endOfDay, // e.g. leftovers, waste
}

/// ----------------------------
/// TASK LEVEL (UNCHANGED)
/// ----------------------------

class TaskLevel {
  final int level; // 1..5
  final int timesPerDayTarget;
  final int valuePoints;
  final int streakDaysRequired;

  const TaskLevel({
    required this.level,
    required this.timesPerDayTarget,
    required this.valuePoints,
    required this.streakDaysRequired,
  });
}

/// ----------------------------
/// TASK DEFINITION (UPDATED)
/// ----------------------------

class TaskDefinition {
  final String id;
  final String name;
  final String shortDescription;
  final IconData icon;

  /// NEW: category for grouping + scoring
  final TaskCategory category;

  /// NEW: defines behavior type
  final TaskKind kind;

  /// Placeholder for future media (gif/lottie/image)
  final String? mediaAsset;

  final List<TaskLevel> levels; // must be 5

  /// ----------------------------
  /// OPTIONAL GAMEPLAY FIELDS (NEW)
  /// ----------------------------

  /// Minimum gap between actions (in minutes)
  /// Example: handwash = 10 min
  final int? minGapMinutes;

  /// Max times user can earn points per day
  /// Prevents XP farming
  final int? dailyCap;

  /// Only active when shop is open
  final bool requiresShopOpen;

  /// Whether task is mandatory for score calculation
  /// (important for vendor score later)
  final bool isCritical;

  const TaskDefinition({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.icon,

    required this.category,
    required this.kind,

    this.mediaAsset,
    required this.levels,

    this.minGapMinutes,
    this.dailyCap,
    this.requiresShopOpen = true,
    this.isCritical = false,
  });
}
