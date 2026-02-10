import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:hygiene_v_1/main.dart' show appDb;
import 'package:hygiene_v_1/features/tasks/data/task_repository.dart';
import 'package:hygiene_v_1/features/tasks/domain/built_in_tasks.dart';
import 'package:hygiene_v_1/features/tasks/domain/task_definition.dart';

// If you kept task_cards in widgets:
import 'package:hygiene_v_1/features/tasks/presentation/widgets/task_cards.dart';

// Adjust this import to wherever you created the file:
import 'package:hygiene_v_1/features/tasks/presentation/pages/task_detail_page.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  final _controller = PageController();
  final TaskRepository _repo = TaskRepository(appDb);

  int _pageIndex = 0;
  Set<String> _activeKeys = {};

  @override
  void initState() {
    super.initState();
    _refreshActive();
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
    await _refreshActive(); // reflects activation changes after returning
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<TaskDefinition> listTasks = switch (_pageIndex) {
      0 => builtInTasks.where((t) => _activeKeys.contains(t.id)).toList(),
      1 => builtInTasks,
      _ => const <TaskDefinition>[],
    };

    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 20,
              ),
              child: Row(
                children: const [
                  Text(
                    'My ',
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  Text('Tasks', style: TextStyle(fontSize: 28)),
                ],
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 200,
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _pageIndex = i),
                scrollDirection: Axis.horizontal,
                children: const [
                  TaskCard(), // Activated tasks
                  TaskCard(), // All tasks
                  TaskCard(), // Create new task (later)
                ],
              ),
            ),

            const SizedBox(height: 25),

            SmoothPageIndicator(
              controller: _controller,
              count: 3,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.grey,
                dotColor: Colors.black26,
                dotHeight: 8,
                dotWidth: 8,
              ),
            ),

            const SizedBox(height: 18),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _pageIndex == 2
                    ? const _CreateTaskPlaceholder()
                    : ListView.separated(
                        itemCount: listTasks.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final task = listTasks[index];
                          final isActive = _activeKeys.contains(task.id);

                          // Activated page (page 0): show richer tile with progress later
                          if (_pageIndex == 0) {
                            return _ActivatedSimpleTile(
                              task: task,
                              onTap: () => _openDetail(task),
                              onLongPressDone: () async {
                                // For now: allow done logging here
                                // (we will add 10-min gap next)
                                await _repo.addDone(task.id);
                                if (!mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('${task.name}: +1')),
                                );
                                setState(() {});
                              },
                            );
                          }

                          // All tasks page (page 1): simple list tile
                          return ListTile(
                            leading: Icon(task.icon),
                            title: Text(task.name),
                            subtitle: Text(
                              task.shortDescription,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            trailing: Icon(
                              isActive
                                  ? Icons.check_circle_rounded
                                  : Icons.arrow_forward_ios_rounded,
                              size: 18,
                            ),
                            onTap: () => _openDetail(task),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivatedSimpleTile extends StatelessWidget {
  final TaskDefinition task;
  final VoidCallback onTap;
  final VoidCallback onLongPressDone;

  const _ActivatedSimpleTile({
    required this.task,
    required this.onTap,
    required this.onLongPressDone,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPressDone,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: theme.dividerColor.withValues(alpha: 0.18)),
        ),
        child: Row(
          children: [
            Icon(task.icon, size: 32, color: theme.colorScheme.primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                task.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const Icon(Icons.check_circle_outline_rounded),
          ],
        ),
      ),
    );
  }
}

class _CreateTaskPlaceholder extends StatelessWidget {
  const _CreateTaskPlaceholder();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        ListTile(
          leading: Icon(Icons.add_circle_outline),
          title: Text('Create new task (coming soon)'),
          subtitle: Text('You will be able to make your own hygiene tasks.'),
        ),
      ],
    );
  }
}
