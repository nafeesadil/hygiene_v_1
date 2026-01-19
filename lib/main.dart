import 'package:flutter/material.dart';
import 'package:hygiene_v_1/app/vendor_shell.dart';

void main() {
  runApp(const HygiaApp());
}

class HygiaApp extends StatelessWidget {
  const HygiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const VendorShell(),
    );
  }
}
