import 'package:flutter/material.dart';
import 'package:hygiene_v_1/features/auth/data/auth_repository.dart';
import 'package:hygiene_v_1/features/auth/presentation/pages/vendor_registration_page.dart';
import 'package:hygiene_v_1/features/vendor/data/local_vendor_profile_repository.dart';
import 'package:hygiene_v_1/main.dart' show appDb;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _authRepo = AuthRepository();
  final _localVendorRepo = LocalVendorProfileRepository(appDb);
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  bool _loading = false;
  bool _hidePassword = true;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();
    setState(() => _loading = true);

    try {
      await _authRepo.signInWithEmail(
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
      );

      final vendorProfile = await _authRepo.getCurrentVendorProfile();

      if (vendorProfile != null) {
        await _localVendorRepo.saveProfile(vendorProfile);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Login failed: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _openRegistration() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const VendorRegistrationPage()),
    );
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
              padding: const EdgeInsets.fromLTRB(22, 28, 22, 24),
              children: [
                const SizedBox(height: 22),
                const _HygiaLogo(size: 76),
                const SizedBox(height: 18),
                Text(
                  'Hygia',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.primary,
                    letterSpacing: -1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.72),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 34),
                _AuthCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _SectionLabel(label: 'Email Address'),
                      const SizedBox(height: 8),
                      _AuthTextField(
                        controller: _emailCtrl,
                        hintText: 'vendor@hygia.com',
                        keyboardType: TextInputType.emailAddress,
                        icon: Icons.email_outlined,
                      ),
                      const SizedBox(height: 18),
                      Row(
                        children: [
                          const _SectionLabel(label: 'Password'),
                          const Spacer(),
                          TextButton(
                            onPressed: _loading ? null : () {},
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: Text(
                              'Forgot Password?',
                              style: theme.textTheme.labelLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      _AuthTextField(
                        controller: _passwordCtrl,
                        hintText: 'Password',
                        obscureText: _hidePassword,
                        icon: Icons.lock_outline_rounded,
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
                      ),
                      const SizedBox(height: 24),
                      _PrimaryAuthButton(
                        label: _loading ? 'Signing in...' : 'Sign In',
                        icon: Icons.arrow_forward_rounded,
                        onPressed: _loading ? null : _login,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  'New to Hygia Vendor?',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.75),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 14),
                _SecondaryAuthButton(
                  label: 'Create Vendor Account',
                  onPressed: _loading ? null : _openRegistration,
                ),
                const SizedBox(height: 36),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 8,
                  children: [
                    _FooterLink(label: 'Help Center', onTap: () {}),
                    _FooterLink(label: 'Privacy Policy', onTap: () {}),
                    _FooterLink(label: 'Terms of Service', onTap: () {}),
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
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.55,
                ),
              ),
            ),
            Positioned(
              top: 120,
              right: -90,
              child: _BlurCircle(
                size: 180,
                color: theme.colorScheme.secondary.withValues(alpha: 0.14),
              ),
            ),
            Positioned(
              bottom: -100,
              left: -35,
              child: _BlurCircle(
                size: 260,
                color: theme.colorScheme.primaryContainer.withValues(
                  alpha: 0.38,
                ),
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
              blurRadius: 18,
              offset: const Offset(0, 8),
              color: theme.colorScheme.primary.withValues(alpha: 0.18),
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
      padding: const EdgeInsets.all(22),
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

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      label,
      style: theme.textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w900,
        color: theme.colorScheme.onSurface,
      ),
    );
  }
}

class _AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  const _AuthTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: theme.colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 17,
        ),
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

class _SecondaryAuthButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _SecondaryAuthButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: theme.colorScheme.primary,
          side: BorderSide(color: theme.colorScheme.primary, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),
        child: Text(label),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _FooterLink({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface.withValues(alpha: 0.62),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
