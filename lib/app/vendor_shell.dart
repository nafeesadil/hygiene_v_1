import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../features/home/home.dart';
import '../features/profile/profile.dart';
import '../features/tasks/tasks.dart';
import '../features/qr/qr.dart';

class VendorShell extends StatefulWidget {
  const VendorShell({super.key});

  @override
  State<VendorShell> createState() => _VendorShellState();
}

class _VendorShellState extends State<VendorShell> {
  int _currentIndex = 0;

  // If your page widgets are NOT const-constructible, remove the const keyword here.
  static const List<Widget> _pages = <Widget>[
    HomePage(),
    TasksPage(),
    QrPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: GNav(
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() => _currentIndex = index);
            },
            gap: 8,
            backgroundColor: Colors.black,
            activeColor: const Color.fromARGB(255, 157, 236, 170),
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            duration: const Duration(milliseconds: 300),
            tabBackgroundColor: Colors.grey,
            color: Colors.white,
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.task, text: 'Tasks'),
              GButton(icon: Icons.qr_code, text: 'QR'),
              GButton(icon: Icons.person, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
