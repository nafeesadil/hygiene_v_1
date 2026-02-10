import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    TasksPage(),
    QrPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor, // surface color
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: theme.scaffoldBackgroundColor.withValues(alpha: 0.3),
            ),
          ],
        ),
        child: SafeArea(
          child: Container(
            color: theme.scaffoldBackgroundColor, // surface color
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
                color: theme.textTheme.bodyMedium?.color, // inactive icon/text
                activeColor:
                    theme.textTheme.bodyLarge?.color, // active icon/text
                iconSize: 24,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                duration: const Duration(milliseconds: 250),
                tabBackgroundColor: colorScheme.secondary.withValues(
                  alpha: 0.60,
                ),
                // subtle highlight
                tabs: const [
                  GButton(icon: Icons.home_outlined, text: 'Home'),
                  GButton(icon: Icons.task_outlined, text: 'Tasks'),
                  GButton(icon: Icons.qr_code_outlined, text: 'QR'),
                  GButton(icon: Icons.person_outline_outlined, text: 'Profile'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
