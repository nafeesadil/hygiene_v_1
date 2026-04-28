import 'package:flutter/material.dart';
import 'package:hygiene_v_1/core/widgets/hygia_dialogue.dart';
import 'package:hygiene_v_1/features/shared/application/task_progress_service.dart';
import 'package:hygiene_v_1/features/tasks/data/task_repository.dart';
import 'package:hygiene_v_1/features/tasks/domain/task_definition.dart';
import 'package:hygiene_v_1/features/vendor/data/vendor_repository.dart';
import 'package:hygiene_v_1/main.dart' show appDb;

class TaskCompletionPage extends StatefulWidget {
  final TaskDefinition task;

  const TaskCompletionPage({super.key, required this.task});

  @override
  State<TaskCompletionPage> createState() => _TaskCompletionPageState();
}

class _TaskCompletionPageState extends State<TaskCompletionPage> {
  late final TaskRepository _taskRepo = TaskRepository(appDb);
  late final VendorRepository _vendorRepo = VendorRepository(appDb);
  late final TaskProgressService _service = TaskProgressService(
    _taskRepo,
    _vendorRepo,
  );

  bool _saving = false;

  Future<void> _markDone() async {
    if (_saving) return;

    setState(() => _saving = true);

    final result = await _service.completeTask(widget.task.id);
    final res = result.taskResult;

    if (!mounted) return;

    setState(() => _saving = false);

    final (title, description) = switch (res.status) {
      MarkDoneStatus.success => (
        'Great work! 🎉',
        '+${res.earnedXp} XP added. You are building better hygiene habits step by step.',
      ),
      MarkDoneStatus.shopClosed => (
        'Shop Closed',
        'Open your shop first before logging this task.',
      ),
      MarkDoneStatus.cooldown => (
        'Wait a Moment',
        'This task was logged recently. Try again after the cooldown ends.',
      ),
      MarkDoneStatus.alreadyComplete => (
        'Completed for Today',
        'You have already reached today’s limit for this task.',
      ),
      MarkDoneStatus.notActive => (
        'Task Inactive',
        'Activate this task first from the task details page.',
      ),
    };

    await showDialog(
      context: context,
      builder: (_) => HygiaDialog(
        title: title,
        description: description,
        primaryText: 'OK',
      ),
    );

    if (!mounted) return;

    if (res.status == MarkDoneStatus.success) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final task = widget.task;

    return Scaffold(
      appBar: AppBar(title: const Text('Complete Task')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: theme.dividerColor.withValues(alpha: 0.18),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 42,
                    backgroundColor: theme.colorScheme.primary.withValues(
                      alpha: 0.12,
                    ),
                    child: Icon(
                      task.icon,
                      size: 42,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    task.name,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    task.shortDescription,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'You are about to log this hygiene task. Every valid completion adds XP to today’s progress and supports your vendor score.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.textTheme.bodyMedium?.color?.withValues(
                        alpha: 0.75,
                      ),
                    ),
                  ),
                  const SizedBox(height: 26),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _saving ? null : _markDone,
                      icon: _saving
                          ? const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.check_circle_rounded),
                      label: Text(_saving ? 'Saving...' : 'Mark as Done'),
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: _saving ? null : () => Navigator.pop(context),
                    child: const Text('Not now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
