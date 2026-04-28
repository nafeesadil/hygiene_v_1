import 'package:flutter/material.dart';
import 'package:hygiene_v_1/core/widgets/hygia_dialogue.dart';
import 'package:hygiene_v_1/features/tasks/data/task_repository.dart';
import 'package:hygiene_v_1/features/tasks/domain/task_definition.dart';
import 'package:hygiene_v_1/features/vendor/data/vendor_repository.dart';
import 'package:hygiene_v_1/features/vendor/domain/vendor_models.dart';
import 'package:hygiene_v_1/main.dart' show appDb;

class TaskDetailPage extends StatefulWidget {
  final TaskDefinition task;

  const TaskDetailPage({super.key, required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final TaskRepository _repo = TaskRepository(appDb);
  final VendorRepository _vendorRepo = VendorRepository(appDb);

  bool _isActive = false;
  int _level = 1;
  int _todayCount = 0;
  VendorDashboard? _dashboard;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final active = await _repo.isActive(widget.task.id);
    final level = await _repo.getLevel(widget.task.id);
    final todayCount = await _repo.getTodayCount(widget.task.id);
    final dashboard = await _vendorRepo.getDashboard();

    if (!mounted) return;
    setState(() {
      _isActive = active;
      _level = level.clamp(1, 5).toInt();
      _todayCount = todayCount;
      _dashboard = dashboard;
    });
  }

  Future<void> _toggleActive() async {
    await _repo.setActive(widget.task.id, !_isActive);
    await _load();

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => HygiaDialog(
        title: _isActive ? 'Task Activated' : 'Task Deactivated',
        description: _isActive
            ? 'You can now log completions for this task.'
            : 'This task is no longer active.',
        primaryText: 'OK',
      ),
    );
  }

  Future<void> _markDone() async {
    final res = await _repo.tryMarkDone(widget.task.id);

    if (res.status == MarkDoneStatus.success && res.earnedXp > 0) {
      await _vendorRepo.addEarnedXp(res.earnedXp);
    }

    await _load();
    if (!mounted) return;

    final (title, description) = switch (res.status) {
      MarkDoneStatus.success =>
        res.leveledUp
            ? (
                'Level Up! 🎉',
                '${widget.task.name}: +${res.earnedXp} XP and task level increased.',
              )
            : (
                'Task Logged',
                '${widget.task.name}: +${res.earnedXp} XP added to today’s progress.',
              ),
      MarkDoneStatus.shopClosed => (
        'Shop Closed',
        'Open your shop first to log tasks.',
      ),
      MarkDoneStatus.cooldown => () {
        final mins = res.waitRemaining?.inMinutes ?? 0;
        final secs = res.waitRemaining?.inSeconds.remainder(60) ?? 0;
        return (
          'Wait a Moment',
          'Please wait ${mins}m ${secs}s before logging this task again.',
        );
      }(),
      MarkDoneStatus.alreadyComplete => (
        'Complete for Today',
        'You have already logged this task ${res.target} times today.',
      ),
      MarkDoneStatus.notActive => (
        'Task Inactive',
        'Please activate this task first.',
      ),
    };

    showDialog(
      context: context,
      builder: (_) => HygiaDialog(
        title: title,
        description: description,
        primaryText: 'OK',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final rule = widget.task.levels[_level - 1];
    final target = rule.timesPerDayTarget;
    final progress = target <= 0 ? 0.0 : (_todayCount / target).clamp(0.0, 1.0);
    final dashboard = _dashboard;

    return Scaffold(
      appBar: AppBar(title: Text(widget.task.name)),
      body: SafeArea(
        child: dashboard == null
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(16),
                children: [
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
                  Row(
                    children: [
                      _Stars(level: _level),
                      const SizedBox(width: 10),
                      Text(
                        'Task Level $_level / 5',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _InfoPill(
                        icon: Icons.repeat_rounded,
                        text: '$target/day',
                      ),
                      _InfoPill(
                        icon: Icons.bolt_rounded,
                        text: '+${rule.valuePoints} XP',
                      ),
                      _InfoPill(
                        icon: Icons.workspace_premium_rounded,
                        text: 'Vendor Lv ${dashboard.vendorLevel}',
                      ),
                      _InfoPill(
                        icon: Icons.local_fire_department_rounded,
                        text: '${dashboard.currentStreak}d streak',
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Text(
                    'Today',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 12,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$_todayCount / $target completions',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.dividerColor.withValues(alpha: 0.18),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'How this task helps your score',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const _ScoreBullet(
                          icon: Icons.bolt_rounded,
                          text:
                              'Each valid completion adds XP to your daily total and total vendor XP.',
                        ),
                        const _ScoreBullet(
                          icon: Icons.trending_up_rounded,
                          text:
                              'Reaching more of your daily target improves your performance score.',
                        ),
                        const _ScoreBullet(
                          icon: Icons.local_fire_department_rounded,
                          text:
                              'Reaching at least 50% of today’s target keeps your streak alive.',
                        ),
                        const _ScoreBullet(
                          icon: Icons.workspace_premium_rounded,
                          text:
                              'Higher task levels improve mastery, which also supports your vendor score.',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _toggleActive,
                      icon: Icon(
                        _isActive
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_fill,
                      ),
                      label: Text(
                        _isActive ? 'Deactivate Task' : 'Activate Task',
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_isActive)
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _markDone,
                        icon: const Icon(Icons.check_circle_rounded),
                        label: Text('Mark Done (+${rule.valuePoints} XP)'),
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}

class _ScoreBullet extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ScoreBullet({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
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
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 6),
          Text(
            text,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
