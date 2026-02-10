import 'package:flutter/material.dart';
import 'task_definition.dart';

const builtInTasks = <TaskDefinition>[
  TaskDefinition(
    id: 'handwash',
    name: 'Wash hands',
    shortDescription: 'Clean hands to protect customers.',
    icon: Icons.wash_rounded,
    mediaAsset: null, // later: 'assets/lottie/handwash.json'
    levels: [
      TaskLevel(
        level: 1,
        timesPerDayTarget: 10,
        valuePoints: 3,
        streakDaysRequired: 0,
      ),
      TaskLevel(
        level: 2,
        timesPerDayTarget: 20,
        valuePoints: 6,
        streakDaysRequired: 0,
      ),
      TaskLevel(
        level: 3,
        timesPerDayTarget: 40,
        valuePoints: 10,
        streakDaysRequired: 7,
      ),
      TaskLevel(
        level: 4,
        timesPerDayTarget: 60,
        valuePoints: 15,
        streakDaysRequired: 14,
      ),
      TaskLevel(
        level: 5,
        timesPerDayTarget: 80,
        valuePoints: 22,
        streakDaysRequired: 30,
      ),
    ],
  ),
  TaskDefinition(
    id: 'clean_surfaces',
    name: 'Clean surfaces',
    shortDescription: 'Keep the workspace clean.',
    icon: Icons.cleaning_services_rounded,
    mediaAsset: null,
    levels: [
      TaskLevel(
        level: 1,
        timesPerDayTarget: 6,
        valuePoints: 3,
        streakDaysRequired: 0,
      ),
      TaskLevel(
        level: 2,
        timesPerDayTarget: 10,
        valuePoints: 6,
        streakDaysRequired: 0,
      ),
      TaskLevel(
        level: 3,
        timesPerDayTarget: 14,
        valuePoints: 10,
        streakDaysRequired: 7,
      ),
      TaskLevel(
        level: 4,
        timesPerDayTarget: 20,
        valuePoints: 15,
        streakDaysRequired: 14,
      ),
      TaskLevel(
        level: 5,
        timesPerDayTarget: 28,
        valuePoints: 22,
        streakDaysRequired: 30,
      ),
    ],
  ),
  // Add the rest later (wash utensils, waste, sanitize, report)…
];
