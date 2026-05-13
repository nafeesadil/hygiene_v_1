import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hygiene_v_1/core/widgets/hygia_dialogue.dart';
import 'package:hygiene_v_1/features/shared/application/task_progress_service.dart';
import 'package:hygiene_v_1/features/tasks/data/task_repository.dart';
import 'package:hygiene_v_1/features/tasks/domain/built_in_tasks.dart';
import 'package:hygiene_v_1/features/tasks/domain/task_definition.dart';
import 'package:hygiene_v_1/features/tasks/presentation/pages/task_detail_page.dart';
import 'package:hygiene_v_1/features/vendor/data/vendor_repository.dart';
import 'package:hygiene_v_1/features/vendor/domain/vendor_models.dart';
import 'package:hygiene_v_1/main.dart' show appDb;

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  Map<String, Duration> _cooldowns = {};
  int _dashboardTick = 0;
  final TaskRepository _repo = TaskRepository(appDb);
  final VendorRepository _vendorRepo = VendorRepository(appDb);
  late final TaskProgressService _progressService = TaskProgressService(
    _repo,
    _vendorRepo,
  );

  int _tabIndex = 0;
  Set<String> _activeKeys = {};
  VendorDashboard? _dashboard;
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _loadAll();

    _ticker = Timer.periodic(const Duration(seconds: 1), (_) async {
      if (!mounted) return;

      await _loadCooldowns();

      _dashboardTick++;
      if (_dashboardTick % 5 == 0) {
        await _loadDashboardOnly();
      }
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _loadCooldowns() async {
    final next = <String, Duration>{};

    for (final taskKey in _activeKeys) {
      next[taskKey] = await _repo.getCooldownRemaining(taskKey);
    }

    if (!mounted) return;

    setState(() {
      _cooldowns = next;
    });
  }

  Future<void> _loadAll() async {
    await _refreshActive();
    await _loadCooldowns();
    await _loadDashboardOnly();
  }

  Future<void> _loadDashboardOnly() async {
    final dashboard = await _vendorRepo.getDashboard();
    if (!mounted) return;
    setState(() {
      _dashboard = dashboard;
    });
  }

  Future<void> _refreshActive() async {
    final active = await _repo.getActiveTasks();
    if (!mounted) return;
    setState(() {
      _activeKeys = active.map((e) => e.taskKey).toSet();
    });
  }

  Future<void> _openDetail(TaskDefinition task) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => TaskDetailPage(task: task)),
    );
    await _loadAll();
  }

  Future<void> _showCompletionPrompt(TaskDefinition task) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Complete this task?'),
        content: Text(
          'You are about to log "${task.name}". Great hygiene habits are built one small action at a time.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.pop(dialogContext, true),
            icon: const Icon(Icons.check_circle_rounded),
            label: const Text('Mark as Done'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await _quickMarkDone(task);
    await _loadAll();
  }

  String _formatCooldown(Duration d) {
    final totalSeconds = d.inSeconds;
    if (totalSeconds <= 0) return 'Ready';

    final minutes = totalSeconds ~/ 60;
    final seconds = totalSeconds % 60;

    final mm = minutes.toString().padLeft(2, '0');
    final ss = seconds.toString().padLeft(2, '0');

    return '$mm:$ss';
  }

  Future<void> _quickMarkDone(TaskDefinition task) async {
    final result = await _progressService.completeTask(task.id);
    final res = result.taskResult;

    if (!mounted) return;

    final (title, description) = switch (res.status) {
      MarkDoneStatus.success =>
        res.leveledUp
            ? (
                'Level Up! 🎉',
                '${task.name}: +${res.earnedXp} XP and task level increased.',
              )
            : ('Task Logged', '${task.name}: +${res.earnedXp} XP added.'),
      MarkDoneStatus.shopClosed => (
        'Shop Closed',
        'Open your shop first to log tasks.',
      ),
      MarkDoneStatus.cooldown => (
        'Wait a Moment',
        'Please wait ${_formatCooldown(res.waitRemaining ?? Duration.zero)} before logging this task again.',
      ),
      MarkDoneStatus.alreadyComplete => (
        'Complete for Today',
        'You have already logged this ${res.target} times today.',
      ),
      MarkDoneStatus.notActive => (
        'Task Inactive',
        'Please activate this task first.',
      ),
    };

    setState(() {
      _dashboard = result.dashboard;
    });

    showDialog(
      context: context,
      builder: (_) => HygiaDialog(
        title: title,
        description: description,
        primaryText: 'OK',
      ),
    );
  }

  String _resetInLabel() {
    final now = DateTime.now();
    final nextMidnight = DateTime(now.year, now.month, now.day + 1);
    final diff = nextMidnight.difference(now);
    final h = diff.inHours;
    final m = diff.inMinutes.remainder(60);
    if (h <= 0) return 'RESET SOON';
    return 'RESET IN ${h}H${m > 0 ? ' ${m}M' : ''}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dashboard = _dashboard;

    final tasks = _tabIndex == 0
        ? builtInTasks.where((t) => _activeKeys.contains(t.id)).toList()
        : builtInTasks;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadAll,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                child: Row(
                  children: [
                    Text(
                      'Hygiene Tasks',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: theme.colorScheme.primary.withValues(
                        alpha: 0.15,
                      ),
                      child: Icon(
                        Icons.person,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: dashboard == null
                    ? const _LoadingCard()
                    : _VendorProgressCard(dashboard: dashboard),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: _SegmentedTabs(
                  leftText: 'Daily Tasks',
                  rightText: 'All Tasks',
                  index: _tabIndex,
                  onChanged: (i) => setState(() => _tabIndex = i),
                ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  children: [
                    Text(
                      _tabIndex == 0 ? 'Active Checklist' : 'All Tasks',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.refresh_rounded,
                          size: 18,
                          color: theme.textTheme.bodySmall?.color?.withValues(
                            alpha: 0.70,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _resetInLabel(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            color: theme.textTheme.bodySmall?.color?.withValues(
                              alpha: 0.70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(18, 0, 18, 30),
                  itemCount: _tabIndex == 0 ? tasks.length + 1 : tasks.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    if (_tabIndex == 0 && index == tasks.length) {
                      return _SuggestCard(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => const HygiaDialog(
                              title: 'Coming Soon',
                              description:
                                  'You will be able to suggest new hygiene tasks here.',
                              primaryText: 'OK',
                            ),
                          );
                        },
                      );
                    }

                    final task = tasks[index];

                    return FutureBuilder<int>(
                      future: _repo.getTodayCount(task.id),
                      builder: (context, snap) {
                        final done = snap.data ?? 0;

                        return FutureBuilder<int>(
                          future: _repo.getLevel(task.id),
                          builder: (context, levelSnap) {
                            final level = (levelSnap.data ?? 1).clamp(1, 5);
                            final rule = task.levels[level - 1];
                            final target = rule.timesPerDayTarget;
                            final subtitle = '$done / $target today';
                            final baseRightText =
                                'L$level • +${rule.valuePoints} XP';

                            if (_tabIndex == 0) {
                              final remaining =
                                  _cooldowns[task.id] ?? Duration.zero;
                              final isCoolingDown = remaining > Duration.zero;

                              final rightText = isCoolingDown
                                  ? 'Wait ${_formatCooldown(remaining)}'
                                  : baseRightText;

                              return _DailyTaskTile(
                                task: task,
                                subtitle: subtitle,
                                rightText: rightText,
                                isCoolingDown: isCoolingDown,
                                onTap: () => _showCompletionPrompt(task),
                                onLongPressDone: () =>
                                    _showCompletionPrompt(task),
                              );
                            }

                            final isActive = _activeKeys.contains(task.id);
                            return _AllTaskTile(
                              task: task,
                              active: isActive,
                              subtitle: subtitle,
                              rightText: baseRightText,
                              onTap: () => _openDetail(task),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).cardColor,
      ),
      child: const Center(child: CircularProgressIndicator()),
    );
  }
}

class _VendorProgressCard extends StatelessWidget {
  final VendorDashboard dashboard;

  const _VendorProgressCard({required this.dashboard});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = dashboard.todayTarget <= 0
        ? 0.0
        : (dashboard.todayXp / dashboard.todayTarget).clamp(0.0, 1.0);

    final streakSafe = dashboard.todayXp >= (dashboard.todayTarget * 0.5);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 5),
            color: Colors.black.withValues(alpha: 0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.12,
                ),
                child: Icon(
                  Icons.workspace_premium_rounded,
                  color: theme.colorScheme.primary,
                  size: 22,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Today’s Progress',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Text(
                'Score ${dashboard.vendorScore.toStringAsFixed(0)}',
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '${dashboard.todayXp} / ${dashboard.todayTarget} XP',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(value: progress, minHeight: 11),
          ),
          const SizedBox(height: 10),
          Text(
            streakSafe
                ? 'Streak protected today. Keep going to complete the full target.'
                : 'Reach 50% of today’s target to protect your streak.',
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: streakSafe
                  ? Colors.green.shade700
                  : Colors.orange.shade800,
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBadge extends StatelessWidget {
  final IconData icon;
  final String text;

  const _TopBadge({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
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

class _MiniMetric extends StatelessWidget {
  final String title;
  final String value;

  const _MiniMetric({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 140,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.labelMedium),
          const SizedBox(height: 4),
          Text(
            value,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  final String leftText;
  final String rightText;
  final int index;
  final ValueChanged<int> onChanged;

  const _SegmentedTabs({
    required this.leftText,
    required this.rightText,
    required this.index,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.12),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SegButton(
              text: leftText,
              selected: index == 0,
              onTap: () => onChanged(0),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _SegButton(
              text: rightText,
              selected: index == 1,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _SegButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onTap;

  const _SegButton({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? theme.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          text,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w900,
            color: selected ? Colors.white : theme.colorScheme.primary,
          ),
        ),
      ),
    );
  }
}

class _DailyTaskTile extends StatelessWidget {
  final TaskDefinition task;
  final String subtitle;
  final String rightText;
  final bool isCoolingDown;
  final VoidCallback onTap;
  final VoidCallback onLongPressDone;

  const _DailyTaskTile({
    required this.task,
    required this.subtitle,
    required this.rightText,
    required this.isCoolingDown,
    required this.onTap,
    required this.onLongPressDone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final rightColor = isCoolingDown
        ? Colors.orange.shade800
        : theme.colorScheme.primary;

    final iconColor = isCoolingDown
        ? Colors.orange.shade800
        : theme.colorScheme.primary;

    final iconBg = isCoolingDown
        ? Colors.orange.withValues(alpha: 0.12)
        : theme.colorScheme.primary.withValues(alpha: 0.12);

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        onLongPress: onLongPressDone,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  isCoolingDown ? Icons.timer_rounded : task.icon,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    rightText,
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: rightColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: theme.textTheme.bodySmall?.color?.withValues(
                      alpha: 0.7,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AllTaskTile extends StatelessWidget {
  final TaskDefinition task;
  final bool active;
  final String subtitle;
  final String rightText;
  final VoidCallback onTap;

  const _AllTaskTile({
    required this.task,
    required this.active,
    required this.subtitle,
    required this.rightText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(task.icon, color: theme.colorScheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            task.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        if (active)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.withValues(alpha: 0.10),
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              'Active',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(subtitle),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                rightText,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestCard extends StatelessWidget {
  final VoidCallback onTap;

  const _SuggestCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: theme.colorScheme.primary.withValues(alpha: 0.06),
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(
                Icons.add_circle_outline_rounded,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Suggest a new hygiene task',
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
