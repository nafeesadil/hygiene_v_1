import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hygiene_v_1/features/tasks/data/task_repository.dart';
import 'package:hygiene_v_1/main.dart' show appDb;

class CreateCustomTaskPage extends StatefulWidget {
  const CreateCustomTaskPage({super.key});

  @override
  State<CreateCustomTaskPage> createState() => _CreateCustomTaskPageState();
}

class _CreateCustomTaskPageState extends State<CreateCustomTaskPage> {
  final _formKey = GlobalKey<FormState>();
  final _repo = TaskRepository(appDb);

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _levelControllers = <TextEditingController>[
    TextEditingController(text: '4'),
    TextEditingController(text: '6'),
    TextEditingController(text: '8'),
    TextEditingController(text: '10'),
    TextEditingController(text: '12'),
  ];

  bool _saving = false;

  static const _xpByLevel = [8, 10, 12, 14, 16];

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    for (final controller in _levelControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  List<int>? _readTargets() {
    final values = <int>[];

    for (final controller in _levelControllers) {
      final value = int.tryParse(controller.text.trim());
      if (value == null) return null;
      values.add(value);
    }

    return values;
  }

  String? _validateLevel(int index, String? value) {
    final parsed = int.tryParse((value ?? '').trim());
    if (parsed == null) return 'Required';
    if (parsed < 1) return 'Min 1';

    if (index > 0) {
      final previous = int.tryParse(_levelControllers[index - 1].text.trim());
      if (previous != null && parsed < previous) {
        return 'Must be ≥ L$index';
      }
    }

    return null;
  }

  Future<void> _saveTask() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) return;

    final targets = _readTargets();
    if (targets == null) return;

    setState(() => _saving = true);

    try {
      await _repo.createCustomTaskDefinition(
        name: _nameController.text,
        shortDescription: _descriptionController.text,
        levelTargets: targets,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Custom hygiene task created')),
      );

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Hygiene Task'),
        centerTitle: false,
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(20, 10, 20, 18),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: _saving ? null : () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 2,
              child: FilledButton.icon(
                onPressed: _saving ? null : _saveTask,
                icon: _saving
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.save_rounded),
                label: Text(_saving ? 'Saving...' : 'Save Task'),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
            children: [
              Text(
                'Build a task that fits your stall routine.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withValues(
                    alpha: 0.70,
                  ),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 18),
              _SectionCard(
                title: 'Task Details',
                children: [
                  TextFormField(
                    controller: _nameController,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                      labelText: 'Task name',
                      hintText: 'e.g., Clean cutting board',
                      prefixIcon: Icon(Icons.cleaning_services_rounded),
                    ),
                    validator: (value) {
                      if ((value ?? '').trim().isEmpty) {
                        return 'Enter a task name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 3,
                    textInputAction: TextInputAction.newline,
                    decoration: const InputDecoration(
                      labelText: 'Short description',
                      hintText:
                          'e.g., Wash and sanitize the cutting board after food preparation.',
                      prefixIcon: Icon(Icons.description_outlined),
                    ),
                    validator: (value) {
                      if ((value ?? '').trim().isEmpty) {
                        return 'Enter a short description';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: const [
                      _InfoChip(
                        icon: Icons.build_rounded,
                        label: 'Equipment Care',
                      ),
                      _InfoChip(
                        icon: Icons.repeat_rounded,
                        label: 'Repeatable',
                      ),
                      _InfoChip(
                        icon: Icons.timer_rounded,
                        label: '15 min gap',
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _SectionCard(
                title: 'Daily Frequency by Level',
                subtitle:
                    'Set how many times this task should be completed each day.',
                children: [
                  for (var i = 0; i < 5; i++) ...[
                    _LevelTargetRow(
                      level: i + 1,
                      xp: _xpByLevel[i],
                      controller: _levelControllers[i],
                      validator: (value) => _validateLevel(i, value),
                    ),
                    if (i != 4) const SizedBox(height: 10),
                  ],
                ],
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: Colors.amber.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.info_outline_rounded,
                      color: Colors.amber.shade900,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Higher levels should require the same or more completions than lower levels.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.amber.shade900,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _PreviewCard(
                nameController: _nameController,
                descriptionController: _descriptionController,
                levelController: _levelControllers.first,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> children;

  const _SectionCard({
    required this.title,
    this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: theme.dividerColor.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            offset: const Offset(0, 5),
            color: Colors.black.withValues(alpha: 0.04),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withValues(alpha: 0.65),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

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
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _LevelTargetRow extends StatelessWidget {
  final int level;
  final int xp;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;

  const _LevelTargetRow({
    required this.level,
    required this.xp,
    required this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: theme.colorScheme.primary,
            child: Text(
              'L$level',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                labelText: 'Times per day',
                isDense: true,
              ),
              validator: validator,
            ),
          ),
          const SizedBox(width: 12),
          Text(
            '+$xp XP',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }
}

class _PreviewCard extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController levelController;

  const _PreviewCard({
    required this.nameController,
    required this.descriptionController,
    required this.levelController,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: Listenable.merge([
        nameController,
        descriptionController,
        levelController,
      ]),
      builder: (context, _) {
        final name = nameController.text.trim().isEmpty
            ? 'Clean cutting board'
            : nameController.text.trim();
        final description = descriptionController.text.trim().isEmpty
            ? 'Wash and sanitize the cutting board after food preparation.'
            : descriptionController.text.trim();
        final levelTarget = int.tryParse(levelController.text.trim()) ?? 4;

        return _SectionCard(
          title: 'Task Preview',
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.local_drink_rounded,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _InfoChip(
                  icon: Icons.flag_rounded,
                  label: 'L1 target: $levelTarget/day',
                ),
                const _InfoChip(
                  icon: Icons.stars_rounded,
                  label: '8 XP',
                ),
                const _InfoChip(
                  icon: Icons.priority_high_rounded,
                  label: 'Critical task',
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
