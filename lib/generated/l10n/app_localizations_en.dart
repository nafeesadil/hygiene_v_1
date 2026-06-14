// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Hygia';

  @override
  String get home => 'Home';

  @override
  String get tasks => 'Tasks';

  @override
  String get qr => 'QR';

  @override
  String get profile => 'Profile';

  @override
  String get vendorProfile => 'Vendor Profile';

  @override
  String get leadVendor => 'Lead Vendor';

  @override
  String get hygieneScore => 'Vendor Score';

  @override
  String get level => 'Level';

  @override
  String get streak => 'Streak';

  @override
  String get days => 'days';

  @override
  String get totalXpEarned => 'Total XP Earned';

  @override
  String get viewLedger => 'View Ledger';

  @override
  String get storeCheckIn => 'Store Check-in';

  @override
  String get customerPreviewQuote => 'Clean habits build customer trust.';

  @override
  String get customerReviews => 'Customer Reviews';

  @override
  String get downloadPoster => 'Download Poster';

  @override
  String get shopManagement => 'Shop Management';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get notifications => 'Notifications';

  @override
  String get hygieneTips => 'Hygiene Tips';

  @override
  String get newLabel => 'NEW';

  @override
  String get english => 'English';

  @override
  String get german => 'German';

  @override
  String get bengali => 'Bengali';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get cancel => 'Cancel';

  @override
  String get aboutHygia => 'About Hygia';

  @override
  String get privacyPolicy => 'Privacy & Data Policy';

  @override
  String get appVersion => 'Hygia Vendor App v1.0.0';

  @override
  String get vendorName => 'Karim\'s Jhalmuri';

  @override
  String get vendorCategory => 'Jhalmuri & Snacks';

  @override
  String get vendorLead => 'Karim';

  @override
  String get homeTitle => 'My Home';

  @override
  String get shopOpen => 'Shop is open';

  @override
  String get shopClosed => 'Shop is closed';

  @override
  String get closeShop => 'Close Shop';

  @override
  String get openShop => 'Open Shop';

  @override
  String get welcomeBack => 'Welcome back 👋';

  @override
  String get welcome => 'Welcome 👋';

  @override
  String get welcomeOpenSubtitle =>
      'Your hygiene progress is being tracked while the shop is open.';

  @override
  String get welcomeClosedSubtitle =>
      'Open your shop to begin tracking today’s hygiene progress.';

  @override
  String get activeTasks => 'Active Tasks';

  @override
  String get todayTarget => 'Today Target';

  @override
  String get consistency => 'Consistency';

  @override
  String get performance => 'Performance';

  @override
  String get openFor => 'Open for';

  @override
  String get latestCustomer => 'Latest customer';

  @override
  String get latestReview => 'Latest review';

  @override
  String get noReviewsYet => 'No reviews yet';

  @override
  String get noCustomerReviewMessage =>
      'Customer reviews will appear here after customers scan your QR code and leave feedback.';

  @override
  String get today => 'Today';

  @override
  String get vendorScore => 'Vendor Score';

  @override
  String vendorLevelLabel(int level) {
    return 'Vendor Level $level';
  }

  @override
  String xpNeededToReachLevel(int xp, int level) {
    return '$xp XP needed to reach Level $level.';
  }

  @override
  String get strongHygiene => 'Strong hygiene';

  @override
  String get improving => 'Improving';

  @override
  String get needsAttention => 'Needs attention';

  @override
  String workingStreak(int days) {
    return '$days-day working streak';
  }

  @override
  String streakProtectedToday(int bestStreak) {
    return 'Streak protected today. Best: $bestStreak days.';
  }

  @override
  String earnMoreXpToProtectStreak(int xp) {
    return 'Earn $xp more XP today to protect your streak.';
  }

  @override
  String reviewsCount(int count) {
    return '$count reviews';
  }
}
