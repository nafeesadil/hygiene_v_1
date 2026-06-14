// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Bengali Bangla (`bn`).
class AppLocalizationsBn extends AppLocalizations {
  AppLocalizationsBn([String locale = 'bn']) : super(locale);

  @override
  String get appName => 'হাইজিয়া';

  @override
  String get home => 'হোম';

  @override
  String get tasks => 'কাজ';

  @override
  String get qr => 'কিউআর';

  @override
  String get profile => 'প্রোফাইল';

  @override
  String get vendorProfile => 'বিক্রেতার প্রোফাইল';

  @override
  String get leadVendor => 'প্রধান বিক্রেতা';

  @override
  String get hygieneScore => 'বিক্রেতার স্কোর';

  @override
  String get level => 'লেভেল';

  @override
  String get streak => 'স্ট্রিক';

  @override
  String get days => 'দিন';

  @override
  String get totalXpEarned => 'মোট XP অর্জন';

  @override
  String get viewLedger => 'হিসাব দেখুন';

  @override
  String get storeCheckIn => 'দোকান চেক-ইন';

  @override
  String get customerPreviewQuote =>
      'পরিষ্কার অভ্যাস গ্রাহকের বিশ্বাস তৈরি করে।';

  @override
  String get customerReviews => 'গ্রাহক রিভিউ';

  @override
  String get downloadPoster => 'পোস্টার ডাউনলোড করুন';

  @override
  String get shopManagement => 'দোকান ব্যবস্থাপনা';

  @override
  String get languageSettings => 'ভাষা সেটিংস';

  @override
  String get notifications => 'নোটিফিকেশন';

  @override
  String get hygieneTips => 'স্বাস্থ্যবিধি টিপস';

  @override
  String get newLabel => 'নতুন';

  @override
  String get english => 'ইংরেজি';

  @override
  String get german => 'জার্মান';

  @override
  String get bengali => 'বাংলা';

  @override
  String get selectLanguage => 'ভাষা নির্বাচন করুন';

  @override
  String get cancel => 'বাতিল';

  @override
  String get aboutHygia => 'হাইজিয়া সম্পর্কে';

  @override
  String get privacyPolicy => 'গোপনীয়তা ও ডাটা নীতি';

  @override
  String get appVersion => 'হাইজিয়া বিক্রেতা অ্যাপ v1.0.0';

  @override
  String get vendorName => 'করিমের ঝালমুড়ি';

  @override
  String get vendorCategory => 'ঝালমুড়ি ও স্ন্যাকস';

  @override
  String get vendorLead => 'করিম';

  @override
  String get homeTitle => 'আমার হোম';

  @override
  String get shopOpen => 'দোকান খোলা হয়েছে';

  @override
  String get shopClosed => 'দোকান বন্ধ হয়েছে';

  @override
  String get closeShop => 'দোকান বন্ধ করুন';

  @override
  String get openShop => 'দোকান খুলুন';

  @override
  String get welcomeBack => 'আবার স্বাগতম 👋';

  @override
  String get welcome => 'স্বাগতম 👋';

  @override
  String get welcomeOpenSubtitle =>
      'দোকান খোলা থাকলে আপনার স্বাস্থ্যবিধির অগ্রগতি ট্র্যাক করা হবে।';

  @override
  String get welcomeClosedSubtitle =>
      'আজকের স্বাস্থ্যবিধির অগ্রগতি শুরু করতে দোকান খুলুন।';

  @override
  String get activeTasks => 'সক্রিয় কাজ';

  @override
  String get todayTarget => 'আজকের লক্ষ্য';

  @override
  String get consistency => 'নিয়মিততা';

  @override
  String get performance => 'পারফরম্যান্স';

  @override
  String get openFor => 'খোলা আছে';

  @override
  String get latestCustomer => 'সর্বশেষ গ্রাহক';

  @override
  String get latestReview => 'সর্বশেষ রিভিউ';

  @override
  String get noReviewsYet => 'এখনও কোনো রিভিউ নেই';

  @override
  String get noCustomerReviewMessage =>
      'গ্রাহকরা আপনার QR কোড স্ক্যান করে মতামত দিলে রিভিউ এখানে দেখা যাবে।';

  @override
  String get today => 'আজ';

  @override
  String get vendorScore => 'বিক্রেতার স্কোর';

  @override
  String vendorLevelLabel(int level) {
    return 'বিক্রেতার লেভেল $level';
  }

  @override
  String xpNeededToReachLevel(int xp, int level) {
    return 'লেভেল $level-এ পৌঁছাতে আরও $xp XP প্রয়োজন।';
  }

  @override
  String get strongHygiene => 'ভালো স্বাস্থ্যবিধি';

  @override
  String get improving => 'উন্নতি হচ্ছে';

  @override
  String get needsAttention => 'মনোযোগ প্রয়োজন';

  @override
  String workingStreak(int days) {
    return '$days দিনের কাজের স্ট্রিক';
  }

  @override
  String streakProtectedToday(int bestStreak) {
    return 'আজ স্ট্রিক সুরক্ষিত। সেরা: $bestStreak দিন।';
  }

  @override
  String earnMoreXpToProtectStreak(int xp) {
    return 'স্ট্রিক সুরক্ষিত রাখতে আজ আরও $xp XP অর্জন করুন।';
  }

  @override
  String reviewsCount(int count) {
    return '$countটি রিভিউ';
  }
}
