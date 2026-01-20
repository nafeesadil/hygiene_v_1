import 'package:flutter/material.dart';
import 'package:hygiene_v_1/app/vendor_shell.dart';
import 'package:hygiene_v_1/theme/app_theme.dart';

void main() {
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
