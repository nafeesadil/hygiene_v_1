import 'dart:async';
import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hygiene_v_1/features/tasks/domain/built_in_tasks.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  final Map<String, Timer> _cooldownTimers = {};

  static const String _generalChannelId = 'hygia_general';
  static const String _generalChannelName = 'Hygia General';

  static const String _taskChannelId = 'hygia_tasks';
  static const String _taskChannelName = 'Task Reminders';

  static const String _progressChannelId = 'hygia_progress';
  static const String _progressChannelName = 'Progress Updates';

  static const String _tipsChannelId = 'hygia_tips';
  static const String _tipsChannelName = 'Hygiene Tips';

  Future<void> init() async {
    tz_data.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Berlin'));

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _plugin.initialize(settings: initSettings);

    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    await android?.requestNotificationsPermission();
  }

  int _stableId(String key, int base) {
    final hash = key.codeUnits.fold<int>(0, (prev, e) => prev + e * 31);
    return base + hash.abs() % 100000;
  }

  NotificationDetails _details({
    required String channelId,
    required String channelName,
    required Importance importance,
    required Priority priority,
  }) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        importance: importance,
        priority: priority,
      ),
    );
  }

  Future<void> showGeneral({
    required String title,
    required String body,
  }) async {
    await _plugin.show(
      id: Random().nextInt(999999),
      title: title,
      body: body,
      notificationDetails: _details(
        channelId: _generalChannelId,
        channelName: _generalChannelName,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
    );
  }

  Future<void> scheduleCooldownReady({
    required String taskKey,
    required String taskName,
    required Duration cooldown,
  }) async {
    if (cooldown <= Duration.zero) return;

    _cooldownTimers[taskKey]?.cancel();

    _cooldownTimers[taskKey] = Timer(cooldown, () async {
      await showGeneral(
        title: '$taskName is ready again',
        body: 'You can now log this hygiene task again.',
      );

      _cooldownTimers.remove(taskKey);
    });
  }

  Future<void> cancelCooldownReady(String taskKey) async {
    _cooldownTimers[taskKey]?.cancel();
    _cooldownTimers.remove(taskKey);

    await _plugin.cancel(id: _stableId(taskKey, 100000));
  }

  Future<void> cancelAllTaskCooldownNotifications() async {
    for (final timer in _cooldownTimers.values) {
      timer.cancel();
    }

    _cooldownTimers.clear();

    for (final task in builtInTasks) {
      await _plugin.cancel(id: _stableId(task.id, 100000));
    }
  }

  Future<void> showNearTaskLevelUp({
    required String taskKey,
    required String taskName,
    required int remaining,
  }) async {
    await _plugin.show(
      id: _stableId(taskKey, 200000),
      title: 'Almost there!',
      body: remaining <= 1
          ? '$taskName is close to leveling up. Just 1 more completion.'
          : '$taskName is close to leveling up. $remaining more completions to go.',
      notificationDetails: _details(
        channelId: _taskChannelId,
        channelName: _taskChannelName,
        importance: Importance.high,
        priority: Priority.high,
      ),
      payload: 'near-level:$taskKey',
    );
  }

  Future<void> showDailyProgressMilestone({
    required int percent,
    required int todayXp,
    required int targetXp,
  }) async {
    final title = switch (percent) {
      30 => 'Good start!',
      70 => 'Strong progress!',
      100 => 'Daily target complete!',
      _ => 'Progress update',
    };

    final body = switch (percent) {
      30 => 'You reached 30% of today’s hygiene target.',
      70 => 'You reached 70%. Keep going, you are close.',
      100 => 'Great work! You completed today’s hygiene XP target.',
      _ => 'You have $todayXp / $targetXp XP today.',
    };

    await _plugin.show(
      id: 300000 + percent,
      title: title,
      body: body,
      notificationDetails: _details(
        channelId: _progressChannelId,
        channelName: _progressChannelName,
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
      ),
      payload: 'daily-progress:$percent',
    );
  }

  Future<void> scheduleDailyTips() async {
    await _plugin.cancel(id: 400010);
    await _plugin.cancel(id: 400016);

    await _scheduleDailyTip(
      id: 400010,
      hour: 10,
      minute: 0,
      title: 'Hygiene tip',
      body: 'Clean hands before food handling reduce contamination risk.',
    );

    await _scheduleDailyTip(
      id: 400016,
      hour: 16,
      minute: 0,
      title: 'Small habit, big impact',
      body:
          'Keeping utensils clean helps protect customers and your reputation.',
    );
  }

  Future<void> _scheduleDailyTip({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    await _plugin.zonedSchedule(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduled,
      notificationDetails: _details(
        channelId: _tipsChannelId,
        channelName: _tipsChannelName,
        importance: Importance.low,
        priority: Priority.low,
      ),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: 'daily-tip',
    );
  }
}
