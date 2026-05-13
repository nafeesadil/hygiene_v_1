import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hygiene_v_1/generated/l10n/app_localizations.dart';

import '../features/home/home.dart';
import '../features/profile/profile.dart';
import '../features/tasks/presentation/pages/tasks.dart';
import '../features/qr/qr.dart';

class VendorShell extends StatefulWidget {
  const VendorShell({super.key});

  @override
  State<VendorShell> createState() => _VendorShellState();
}

class _VendorShellState extends State<VendorShell> {
  int _currentIndex = 0;

  final List<Widget> _pages = const <Widget>[
    HomePage(),
    TasksPage(),
    QrPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: theme.scaffoldBackgroundColor.withValues(alpha: 0.3),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            color: theme.scaffoldBackgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: GNav(
                selectedIndex: _currentIndex,
                onTabChange: (index) {
                  setState(() => _currentIndex = index);
                },
                gap: 8,
                rippleColor: const Color(0xACA1BC98),
                backgroundColor: theme.scaffoldBackgroundColor,
                color: theme.textTheme.bodyMedium?.color,
                activeColor: theme.textTheme.bodyLarge?.color,
                iconSize: 24,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                duration: const Duration(milliseconds: 250),
                tabBackgroundColor: colorScheme.secondary.withValues(
                  alpha: 0.60,
                ),
                tabs: [
                  GButton(icon: Icons.home_outlined, text: l10n.home),
                  GButton(icon: Icons.task_outlined, text: l10n.tasks),
                  GButton(icon: Icons.qr_code_outlined, text: l10n.qr),
                  GButton(
                    icon: Icons.person_outline_outlined,
                    text: l10n.profile,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
