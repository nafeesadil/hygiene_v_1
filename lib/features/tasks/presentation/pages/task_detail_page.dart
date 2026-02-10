import 'package:flutter/material.dart';
import 'package:hygiene_v_1/features/tasks/domain/task_definition.dart';
import 'package:hygiene_v_1/features/tasks/data/task_repository.dart';
import 'package:hygiene_v_1/main.dart' show appDb;

class TaskDetailPage extends StatefulWidget {
  final TaskDefinition task;

  const TaskDetailPage({super.key, required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final TaskRepository _repo = TaskRepository(appDb);

  bool _isActive = false;
  int _level = 1; // 1..5
  int _todayCount = 0;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final active = await _repo.isActive(widget.task.id);
    final level = await _repo.getLevel(widget.task.id);
    final todayCount = await _repo.getTodayCount(widget.task.id);

    if (!mounted) return;
    setState(() {
      _isActive = active;
      _level = level.clamp(1, 5).toInt();
      _todayCount = todayCount;
    });
  }

  Future<void> _toggleActive() async {
    await _repo.setActive(widget.task.id, !_isActive);
    await _load();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isActive ? 'Task activated' : 'Task deactivated'),
      ),
    );
  }

  Future<void> _markDone() async {
    // Later: enforce 10-minute gap per task (we’ll add that next).
    await _repo.addDone(widget.task.id);
    await _load();

    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('${widget.task.name}: +1')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final rule = widget.task.levels[_level - 1];
    final target = rule.timesPerDayTarget;
    final progress = target <= 0 ? 0.0 : (_todayCount / target).clamp(0.0, 1.0);

    return Scaffold(
      appBar: AppBar(title: Text(widget.task.name)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Lottie/media placeholder (we’ll plug Lottie later)
              Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: theme.dividerColor.withValues(alpha: 0.20),
                  ),
                ),
                child: Center(
                  child: Icon(
                    widget.task.icon,
                    size: 72,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              Text(
                widget.task.shortDescription,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 14),

              // Level + stars
              Row(
                children: [
                  _Stars(level: _level),
                  const SizedBox(width: 10),
                  Text(
                    'Level $_level / 5',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Minimal info row (icon-first)
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  _InfoPill(icon: Icons.repeat_rounded, text: '$target/day'),
                  _InfoPill(
                    icon: Icons.workspace_premium_rounded,
                    text: '+${rule.valuePoints} pts',
                  ),
                  if (_level >= 3)
                    _InfoPill(
                      icon: Icons.local_fire_department_rounded,
                      text: '${rule.streakDaysRequired}d streak',
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Today progress
              Text(
                'Today',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(999),
                child: LinearProgressIndicator(value: progress, minHeight: 12),
              ),
              const SizedBox(height: 8),
              Text(
                '$_todayCount / $target done',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),

              const Spacer(),

              // Activate button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _toggleActive,
                  icon: Icon(
                    _isActive
                        ? Icons.pause_circle_filled
                        : Icons.play_circle_fill,
                  ),
                  label: Text(_isActive ? 'Deactivate' : 'Activate'),
                ),
              ),

              const SizedBox(height: 10),

              // Done button (only if active)
              if (_isActive)
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: _markDone,
                    icon: const Icon(Icons.check_circle_rounded),
                    label: const Text('Mark Done'),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Stars extends StatelessWidget {
  final int level;
  const _Stars({required this.level});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = (i + 1) <= level;
        return Icon(
          filled ? Icons.star_rounded : Icons.star_border_rounded,
          size: 22,
          color: filled
              ? theme.colorScheme.primary
              : theme.dividerColor.withValues(alpha: 0.7),
        );
      }),
    );
  }
}

class _InfoPill extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoPill({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.18),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: theme.colorScheme.primary),
          const SizedBox(width: 6),
          Text(
            text,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w900,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
