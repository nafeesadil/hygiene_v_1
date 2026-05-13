import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hygiene_v_1/generated/l10n/app_localizations.dart';

import 'firebase_options.dart';

import 'package:hygiene_v_1/core/local_db/drift_db.dart';
import 'package:hygiene_v_1/core/settings/app_settings_controller.dart';
import 'package:hygiene_v_1/features/shared/application/notification_service.dart';
import 'package:hygiene_v_1/features/tasks/data/task_repository.dart';
import 'package:hygiene_v_1/theme/app_theme.dart';
import 'package:hygiene_v_1/features/auth/presentation/auth_gate.dart';

late final AppDb appDb;
late final AppSettingsController appSettings;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  appSettings = AppSettingsController();
  await appSettings.load();

  await NotificationService.instance.init();
  await NotificationService.instance.scheduleDailyTips();

  appDb = AppDb();
  await TaskRepository(appDb).ensureSeeded();

  runApp(const HygiaApp());
}

class HygiaApp extends StatelessWidget {
  const HygiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: appSettings,
      builder: (context, _) {
        return MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          debugShowCheckedModeBanner: false,
          locale: appSettings.locale,
          supportedLocales: const [Locale('en'), Locale('de'), Locale('bn')],
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: const AuthGate(),
        );
      },
    );
  }
}
