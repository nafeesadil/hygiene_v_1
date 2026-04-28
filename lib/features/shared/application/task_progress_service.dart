import 'package:hygiene_v_1/features/tasks/data/task_repository.dart';
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
    final taskResult = await _taskRepository.addDoneGuarded(taskKey);

    if (taskResult.status == MarkDoneStatus.success &&
        taskResult.earnedXp > 0) {
      await _vendorRepository.addEarnedXp(taskResult.earnedXp);
    }

    final dashboard = await _vendorRepository.getDashboard();

    return TaskProgressResult(taskResult: taskResult, dashboard: dashboard);
  }
}
