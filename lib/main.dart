import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:hygiene_v_1/app/vendor_shell.dart';
import 'package:hygiene_v_1/theme/app_theme.dart';

import 'package:hygiene_v_1/core/local_db/drift_db.dart';
import 'package:hygiene_v_1/features/tasks/data/task_repository.dart';

late final AppDb appDb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  appDb = AppDb();
  await TaskRepository(appDb).ensureSeeded();

  runApp(const HygiaApp());
}

class HygiaApp extends StatelessWidget {
  const HygiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const VendorShell(),
    );
  }
}
