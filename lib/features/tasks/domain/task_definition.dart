import 'package:flutter/material.dart';

class TaskLevel {
  final int level; // 1..5
  final int timesPerDayTarget;
  final int valuePoints; // your "$" concept (better: points)
  final int streakDaysRequired; // for level 3+ later

  const TaskLevel({
    required this.level,
    required this.timesPerDayTarget,
    required this.valuePoints,
    required this.streakDaysRequired,
  });
}

class TaskDefinition {
  final String id;
  final String name;
  final String shortDescription;
  final IconData icon;

  /// Placeholder for future media:
  /// could be an asset path (gif/image) or lottie asset
  final String? mediaAsset;

  final List<TaskLevel> levels; // must be 5

  const TaskDefinition({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.icon,
    this.mediaAsset,
    required this.levels,
  });
}
