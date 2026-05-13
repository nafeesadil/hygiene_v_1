import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hygiene_v_1/app/vendor_shell.dart';
import 'package:hygiene_v_1/features/auth/presentation/pages/login_page.dart';
import 'package:hygiene_v_1/features/vendor/data/local_vendor_profile_repository.dart';
import 'package:hygiene_v_1/main.dart' show appDb;

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  bool _checkingLocalProfile = true;
  bool _hasLocalVendorProfile = false;

  @override
  void initState() {
    super.initState();
    _checkLocalProfile();
  }

  Future<void> _checkLocalProfile() async {
    final local = await LocalVendorProfileRepository(appDb).getLocalProfile();

    if (!mounted) return;
    setState(() {
      _hasLocalVendorProfile = local != null;
      _checkingLocalProfile = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingLocalProfile) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_hasLocalVendorProfile) {
      return const VendorShell();
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasData) {
          return const VendorShell();
        }

        return const LoginPage();
      },
    );
  }
}
