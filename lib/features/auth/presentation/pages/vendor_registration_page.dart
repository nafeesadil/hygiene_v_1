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
  bool _hidePassword = true;

  final List<String> _categorySuggestions = const [
    'Tacos',
    'Halal',
    'Vegan',
    'Beverages',
    'Desserts',
  ];

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
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);

    try {
      late VendorProfileModel createdVendorProfile;

      final credential = await _authRepo.registerVendor(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
        fullName: _fullNameCtrl.text.trim(),
        phoneNumber: _phoneCtrl.text.trim(),
        preferredLanguage: appSettings.localeCode,
        createVendorProfile: (uid) {
          final reviewUrl =
              'https://hygia-9f3bd.web.app/review.html?vendorId=$uid';

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

  void _fillCategory(String value) {
    _foodCategoryCtrl.text = value;
    _foodCategoryCtrl.selection = TextSelection.collapsed(offset: value.length);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const _AuthBackgroundDecor(),
            ListView(
              padding: const EdgeInsets.fromLTRB(22, 18, 22, 26),
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: _loading ? null : () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                    const Spacer(),
                    Text(
                      'Sign Up',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 48),
                  ],
                ),
                const SizedBox(height: 10),
                const _HygiaLogo(size: 64),
                const SizedBox(height: 16),
                Text(
                  'Join the Community',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.onSurface,
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Elevate your street food business with professional hygiene standards and sanitary reliability.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.35,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.70),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                _AuthCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FormSectionHeader(
                        icon: Icons.person_outline_rounded,
                        title: 'Personal Details',
                      ),
                      const SizedBox(height: 14),
                      _AuthTextField(
                        controller: _fullNameCtrl,
                        hintText: 'Full Name',
                        icon: Icons.person_outline_rounded,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      _AuthTextField(
                        controller: _emailCtrl,
                        hintText: 'Email Address',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      _AuthTextField(
                        controller: _phoneCtrl,
                        hintText: 'Phone Number',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      _AuthTextField(
                        controller: _passwordCtrl,
                        hintText: 'Password',
                        icon: Icons.lock_outline_rounded,
                        obscureText: _hidePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() => _hidePassword = !_hidePassword);
                          },
                          icon: Icon(
                            _hidePassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 22),
                      Divider(
                        color: theme.dividerColor.withValues(alpha: 0.20),
                      ),
                      const SizedBox(height: 16),
                      _FormSectionHeader(
                        icon: Icons.storefront_rounded,
                        title: 'Business Info',
                      ),
                      const SizedBox(height: 14),
                      _AuthTextField(
                        controller: _shopNameCtrl,
                        hintText: 'Shop/Stall Name',
                        icon: Icons.storefront_outlined,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Food Category',
                        style: theme.textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _AuthTextField(
                        controller: _foodCategoryCtrl,
                        hintText: 'e.g. Tacos, Beverages, Desserts',
                        icon: Icons.search_rounded,
                        textInputAction: TextInputAction.next,
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _categorySuggestions.map((category) {
                          return _CategoryChip(
                            label: category,
                            onTap: () => _fillCategory(category),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Expanded(
                            child: _AuthTextField(
                              controller: _locationCtrl,
                              hintText: 'Area',
                              icon: Icons.location_on_outlined,
                              textInputAction: TextInputAction.next,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _AuthTextField(
                              controller: _cityCtrl,
                              hintText: 'City',
                              icon: Icons.map_outlined,
                              textInputAction: TextInputAction.done,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      _PrimaryAuthButton(
                        label: _loading ? 'Creating account...' : 'Create Account',
                        icon: Icons.arrow_forward_rounded,
                        onPressed: _loading ? null : _register,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.70),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: _loading ? null : () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Sign In',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.verified_user_outlined,
                      size: 16,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.28),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Hygia vendor onboarding',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.38),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthBackgroundDecor extends StatelessWidget {
  const _AuthBackgroundDecor();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
        child: Stack(
          children: [
            Positioned(
              top: -90,
              left: -80,
              child: _BlurCircle(
                size: 210,
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.55),
              ),
            ),
            Positioned(
              top: 110,
              right: -90,
              child: _BlurCircle(
                size: 180,
                color: theme.colorScheme.secondary.withValues(alpha: 0.14),
              ),
            ),
            Positioned(
              bottom: -120,
              left: -50,
              child: _BlurCircle(
                size: 260,
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.32),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BlurCircle extends StatelessWidget {
  final double size;
  final Color color;

  const _BlurCircle({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    );
  }
}

class _HygiaLogo extends StatelessWidget {
  final double size;

  const _HygiaLogo({required this.size});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              offset: const Offset(0, 8),
              color: theme.colorScheme.primary.withValues(alpha: 0.16),
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: size * 0.62,
            height: size * 0.62,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.health_and_safety_rounded,
              color: theme.colorScheme.onPrimary,
              size: size * 0.36,
            ),
          ),
        ),
      ),
    );
  }
}

class _AuthCard extends StatelessWidget {
  final Widget child;

  const _AuthCard({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.08),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 22,
            offset: const Offset(0, 12),
            color: Colors.black.withValues(alpha: 0.08),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _FormSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FormSectionHeader({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        CircleAvatar(
          radius: 17,
          backgroundColor: theme.colorScheme.primaryContainer.withValues(alpha: 0.75),
          child: Icon(icon, color: theme.colorScheme.primary, size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }
}

class _AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? suffixIcon;

  const _AuthTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: theme.colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: theme.colorScheme.primary.withValues(alpha: 0.20),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.8),
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _CategoryChip({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ActionChip(
      onPressed: onTap,
      label: Text(label),
      backgroundColor: theme.colorScheme.primaryContainer.withValues(alpha: 0.85),
      labelStyle: theme.textTheme.labelLarge?.copyWith(
        color: theme.colorScheme.onPrimaryContainer,
        fontWeight: FontWeight.w800,
      ),
      side: BorderSide.none,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
    );
  }
}

class _PrimaryAuthButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  const _PrimaryAuthButton({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: theme.colorScheme.onPrimary,
          textStyle: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w900,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          elevation: 4,
        ),
      ),
    );
  }
}
