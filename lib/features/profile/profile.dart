import 'package:flutter/material.dart';
import 'package:hygiene_v_1/generated/l10n/app_localizations.dart';
import 'package:hygiene_v_1/features/vendor/data/vendor_repository.dart';
import 'package:hygiene_v_1/features/vendor/domain/vendor_models.dart';
import 'package:hygiene_v_1/main.dart' show appDb, appSettings;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final VendorRepository _vendorRepo = VendorRepository(appDb);

  VendorDashboard? _dashboard;

  @override
  void initState() {
    super.initState();
    _loadDashboard();
  }

  Future<void> _loadDashboard() async {
    final dashboard = await _vendorRepo.getDashboard();
    if (!mounted) return;
    setState(() => _dashboard = dashboard);
  }

  Future<void> _showLanguageSheet() async {
    final l10n = AppLocalizations.of(context)!;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 6, 18, 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.selectLanguage,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 12),
                _LanguageOption(
                  title: l10n.english,
                  subtitle: 'English (US)',
                  selected: appSettings.localeCode == 'en',
                  onTap: () async {
                    await appSettings.setLocaleCode('en');
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                _LanguageOption(
                  title: l10n.german,
                  subtitle: 'Deutsch',
                  selected: appSettings.localeCode == 'de',
                  onTap: () async {
                    await appSettings.setLocaleCode('de');
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
                _LanguageOption(
                  title: l10n.bengali,
                  subtitle: 'বাংলা',
                  selected: appSettings.localeCode == 'bn',
                  onTap: () async {
                    await appSettings.setLocaleCode('bn');
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final dashboard = _dashboard;

    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _loadDashboard,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 30),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.menu_rounded),
                  ),
                  const Spacer(),
                  Text(
                    l10n.appName,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              _VendorHeader(
                category: l10n.vendorCategory,
                vendorName: l10n.vendorName,
                leadVendor: l10n.vendorLead,
              ),
              const SizedBox(height: 22),
              if (dashboard == null)
                const Center(child: CircularProgressIndicator())
              else ...[
                _ScoreCard(
                  title: l10n.hygieneScore,
                  score: dashboard.vendorScore,
                  todayXp: dashboard.todayXp,
                  todayTarget: dashboard.todayTarget,
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    Expanded(
                      child: _SmallStatCard(
                        title: l10n.level,
                        value: '${dashboard.vendorLevel}',
                        icon: Icons.workspace_premium_rounded,
                        filled: false,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _SmallStatCard(
                        title: l10n.streak,
                        value: '${dashboard.currentStreak} ${l10n.days}',
                        icon: Icons.local_fire_department_rounded,
                        filled: true,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                _XpLedgerCard(
                  title: l10n.totalXpEarned,
                  xp: dashboard.totalXp,
                  buttonText: l10n.viewLedger,
                ),
              ],
              const SizedBox(height: 26),
              _CustomerPreviewCard(
                title: l10n.storeCheckIn,
                quote: l10n.customerPreviewQuote,
                reviews: '4.8 (214 ${l10n.customerReviews})',
                buttonText: l10n.downloadPoster,
              ),
              const SizedBox(height: 30),
              _SectionTitle(title: l10n.shopManagement),
              const SizedBox(height: 12),
              _SettingsPanel(
                children: [
                  _SettingsRow(
                    icon: Icons.language_rounded,
                    title: l10n.languageSettings,
                    value: appSettings.readableLanguageName(context),
                    onTap: _showLanguageSheet,
                  ),
                  _SettingsRow(
                    icon: Icons.notifications_active_outlined,
                    title: l10n.notifications,
                    value: '',
                    onTap: () {},
                  ),
                  _SettingsRow(
                    icon: Icons.lightbulb_outline_rounded,
                    title: l10n.hygieneTips,
                    value: l10n.newLabel,
                    badge: true,
                    onTap: () {},
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Divider(color: theme.dividerColor.withValues(alpha: 0.35)),
              const SizedBox(height: 18),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 24,
                runSpacing: 8,
                children: [
                  TextButton(onPressed: () {}, child: Text(l10n.aboutHygia)),
                  TextButton(onPressed: () {}, child: Text(l10n.privacyPolicy)),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                l10n.appVersion,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.55,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VendorHeader extends StatelessWidget {
  final String category;
  final String vendorName;
  final String leadVendor;

  const _VendorHeader({
    required this.category,
    required this.vendorName,
    required this.leadVendor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: theme.colorScheme.primary.withValues(
                  alpha: 0.16,
                ),
                child: Icon(
                  Icons.storefront_rounded,
                  size: 48,
                  color: theme.colorScheme.primary,
                ),
              ),
              Positioned(
                right: -6,
                bottom: 4,
                child: CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.amber,
                  child: Icon(
                    Icons.verified_rounded,
                    size: 18,
                    color: Colors.orange.shade900,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          category.toUpperCase(),
          style: theme.textTheme.labelLarge?.copyWith(
            color: Colors.red.shade700,
            fontWeight: FontWeight.w900,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          vendorName,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w900,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Lead Vendor: $leadVendor',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.textTheme.titleMedium?.color?.withValues(alpha: 0.75),
          ),
        ),
      ],
    );
  }
}

class _ScoreCard extends StatelessWidget {
  final String title;
  final double score;
  final int todayXp;
  final int todayTarget;

  const _ScoreCard({
    required this.title,
    required this.score,
    required this.todayXp,
    required this.todayTarget,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = todayTarget <= 0
        ? 0.0
        : (todayXp / todayTarget).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.65),
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                title.toUpperCase(),
                style: theme.textTheme.labelMedium?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.health_and_safety_outlined,
                size: 42,
                color: theme.colorScheme.primary.withValues(alpha: 0.15),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                score.clamp(0, 100).toStringAsFixed(0),
                style: theme.textTheme.displaySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 9),
                child: Text(
                  '/ 100',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(value: progress, minHeight: 8),
          ),
        ],
      ),
    );
  }
}

class _SmallStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final bool filled;

  const _SmallStatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.filled,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final bg = filled
        ? theme.colorScheme.primary
        : theme.colorScheme.primary.withValues(alpha: 0.20);

    final fg = filled ? Colors.white : theme.textTheme.bodyLarge?.color;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: fg?.withValues(alpha: 0.82),
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: fg,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Icon(icon, color: filled ? Colors.amber : theme.colorScheme.primary),
        ],
      ),
    );
  }
}

class _XpLedgerCard extends StatelessWidget {
  final String title;
  final int xp;
  final String buttonText;

  const _XpLedgerCard({
    required this.title,
    required this.xp,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 23,
            backgroundColor: Colors.orange.withValues(alpha: 0.28),
            child: Icon(Icons.stars_rounded, color: Colors.deepOrange.shade700),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '$xp XP',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          FilledButton(onPressed: () {}, child: Text(buttonText)),
        ],
      ),
    );
  }
}

class _CustomerPreviewCard extends StatelessWidget {
  final String title;
  final String quote;
  final String reviews;
  final String buttonText;

  const _CustomerPreviewCard({
    required this.title,
    required this.quote,
    required this.reviews,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.colorScheme.primary.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.qr_code_rounded),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: theme.cardColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                  color: Colors.black.withValues(alpha: 0.08),
                ),
              ],
            ),
            child: Icon(
              Icons.qr_code_2_rounded,
              size: 92,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 18),
          Text(
            '"$quote"',
            textAlign: TextAlign.center,
            style: theme.textTheme.titleMedium?.copyWith(
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            '★ ★ ★ ★ ★   $reviews',
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: () {}, child: Text(buttonText)),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: Theme.of(context).textTheme.labelLarge?.copyWith(
        fontWeight: FontWeight.w900,
        letterSpacing: 3,
      ),
    );
  }
}

class _SettingsPanel extends StatelessWidget {
  final List<Widget> children;

  const _SettingsPanel({required this.children});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(24),
      child: Column(children: children),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final bool badge;
  final VoidCallback onTap;

  const _SettingsRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
    this.badge = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget trailing;

    if (badge && value.isNotEmpty) {
      trailing = Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          value,
          style: theme.textTheme.labelSmall?.copyWith(
            color: Colors.deepOrange.shade700,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    } else {
      trailing = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value.isNotEmpty)
            Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right_rounded),
        ],
      );
    }

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: theme.colorScheme.primary.withValues(
                alpha: 0.18,
              ),
              child: Icon(icon, size: 20, color: theme.colorScheme.primary),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        backgroundColor: selected
            ? theme.colorScheme.primary
            : theme.colorScheme.primary.withValues(alpha: 0.12),
        child: Icon(
          Icons.language_rounded,
          color: selected ? Colors.white : theme.colorScheme.primary,
        ),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle: Text(subtitle),
      trailing: selected
          ? Icon(Icons.check_circle_rounded, color: theme.colorScheme.primary)
          : null,
    );
  }
}
