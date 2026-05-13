import 'package:flutter/material.dart';
import 'package:hygiene_v_1/features/auth/data/auth_repository.dart';
import 'package:hygiene_v_1/features/vendor/data/local_vendor_profile_repository.dart';
import 'package:hygiene_v_1/features/vendor/domain/vendor_profile_model.dart';
import 'package:hygiene_v_1/main.dart' show appDb, appSettings;

class VendorRegistrationPage extends StatefulWidget {
  const VendorRegistrationPage({super.key});

  @override
  State<VendorRegistrationPage> createState() => _VendorRegistrationPageState();
}

class _VendorRegistrationPageState extends State<VendorRegistrationPage> {
  final _authRepo = AuthRepository();
  final _localVendorRepo = LocalVendorProfileRepository(appDb);

  final _fullNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _shopNameCtrl = TextEditingController();
  final _foodCategoryCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();

  bool _loading = false;

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _shopNameCtrl.dispose();
    _foodCategoryCtrl.dispose();
    _locationCtrl.dispose();
    _cityCtrl.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() => _loading = true);

    try {
      late VendorProfileModel createdVendorProfile;

      final credential = await _authRepo.registerVendor(
        email: _emailCtrl.text,
        password: _passwordCtrl.text,
        fullName: _fullNameCtrl.text,
        phoneNumber: _phoneCtrl.text,
        preferredLanguage: appSettings.localeCode,
        createVendorProfile: (uid) {
          final reviewUrl = 'https://hygia.app/review?vendorId=$uid';

          createdVendorProfile = VendorProfileModel(
            vendorId: uid,
            ownerUid: uid,
            vendorName: _fullNameCtrl.text.trim(),
            shopName: _shopNameCtrl.text.trim(),
            foodCategory: _foodCategoryCtrl.text.trim(),
            description: '',
            phoneNumber: _phoneCtrl.text.trim(),
            locationText: _locationCtrl.text.trim(),
            city: _cityCtrl.text.trim(),
            country: 'Bangladesh',
            preferredLanguage: appSettings.localeCode,
            profileImageUrl: null,
            reviewUrl: reviewUrl,
          );

          return createdVendorProfile;
        },
      );

      if (credential.user == null) {
        throw Exception('Registration failed. No user returned.');
      }

      await _localVendorRepo.saveProfile(createdVendorProfile);

      if (!mounted) return;
      Navigator.popUntil(context, (route) => route.isFirst);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Registration failed: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Vendor Registration')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(22),
          children: [
            Text(
              'Create your vendor account',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20),
            _field(_fullNameCtrl, 'Full name'),
            _field(_emailCtrl, 'Email'),
            _field(_phoneCtrl, 'Phone number'),
            _field(_passwordCtrl, 'Password', obscure: true),
            const SizedBox(height: 18),
            Text(
              'Shop information',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 12),
            _field(_shopNameCtrl, 'Shop/stall name'),
            _field(_foodCategoryCtrl, 'Food category'),
            _field(_locationCtrl, 'Location/area'),
            _field(_cityCtrl, 'City'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _loading ? null : _register,
              child: Text(_loading ? 'Creating account...' : 'Create Account'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool obscure = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(labelText: label),
      ),
    );
  }
}
