import 'package:flutter/foundation.dart';
import 'package:hygiene_v_1/features/shared/application/notification_service.dart';
import 'package:hygiene_v_1/features/tasks/data/task_repository.dart';
import 'package:hygiene_v_1/features/tasks/domain/built_in_tasks.dart';
import 'package:hygiene_v_1/features/tasks/domain/task_rules.dart';
import 'package:hygiene_v_1/features/vendor/data/vendor_repository.dart';
import 'package:hygiene_v_1/features/vendor/domain/vendor_models.dart';

class TaskProgressResult {
  final MarkDoneResult taskResult;
  final VendorDashboard dashboard;

  const TaskProgressResult({required this.taskResult, required this.dashboard});
}

class TaskProgressService {
  final TaskRepository _taskRepository;
  final VendorRepository _vendorRepository;

  TaskProgressService(this._taskRepository, this._vendorRepository);

  Future<TaskProgressResult> completeTask(String taskKey) async {
    debugPrint('DEBUG: completeTask called for $taskKey');

    final taskResult = await _taskRepository.addDoneGuarded(taskKey);

    debugPrint('DEBUG: task status = ${taskResult.status}');
    debugPrint('DEBUG: earnedXp = ${taskResult.earnedXp}');
    debugPrint(
      'DEBUG: done = ${taskResult.done}, target = ${taskResult.target}',
    );

    if (taskResult.status == MarkDoneStatus.success &&
        taskResult.earnedXp > 0) {
      await _vendorRepository.addEarnedXp(taskResult.earnedXp);

      final task = builtInTasks.firstWhere((t) => t.id == taskKey);
      final shopOpen = await _taskRepository.isShopOpen();

      debugPrint('DEBUG: shopOpen = $shopOpen');

      if (shopOpen) {
        final cooldown = taskCooldownFor(task);

        debugPrint('DEBUG: cooldown for ${task.name} = $cooldown');

        await NotificationService.instance.scheduleCooldownReady(
          taskKey: taskKey,
          taskName: task.name,
          cooldown: cooldown,
        );

        debugPrint('DEBUG: cooldown notification scheduled for ${task.name}');
      }
    }

    final dashboard = await _vendorRepository.getDashboard();

    return TaskProgressResult(taskResult: taskResult, dashboard: dashboard);
  }
}
