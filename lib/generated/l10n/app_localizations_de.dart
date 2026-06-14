// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appName => 'Hygia';

  @override
  String get home => 'Start';

  @override
  String get tasks => 'Aufgaben';

  @override
  String get qr => 'QR';

  @override
  String get profile => 'Profil';

  @override
  String get vendorProfile => 'Anbieterprofil';

  @override
  String get leadVendor => 'Hauptanbieter';

  @override
  String get hygieneScore => 'Anbieterwert';

  @override
  String get level => 'Level';

  @override
  String get streak => 'Serie';

  @override
  String get days => 'Tage';

  @override
  String get totalXpEarned => 'Gesamte XP';

  @override
  String get viewLedger => 'Verlauf anzeigen';

  @override
  String get storeCheckIn => 'Shop-Check-in';

  @override
  String get customerPreviewQuote => 'Saubere Gewohnheiten schaffen Vertrauen.';

  @override
  String get customerReviews => 'Kundenbewertungen';

  @override
  String get downloadPoster => 'Poster herunterladen';

  @override
  String get shopManagement => 'Shop-Verwaltung';

  @override
  String get languageSettings => 'Spracheinstellungen';

  @override
  String get notifications => 'Benachrichtigungen';

  @override
  String get hygieneTips => 'Hygienetipps';

  @override
  String get newLabel => 'NEU';

  @override
  String get english => 'Englisch';

  @override
  String get german => 'Deutsch';

  @override
  String get bengali => 'Bengalisch';

  @override
  String get selectLanguage => 'Sprache auswählen';

  @override
  String get cancel => 'Abbrechen';

  @override
  String get aboutHygia => 'Über Hygia';

  @override
  String get privacyPolicy => 'Datenschutzrichtlinie';

  @override
  String get appVersion => 'Hygia Anbieter-App v1.0.0';

  @override
  String get vendorName => 'Karims Jhalmuri';

  @override
  String get vendorCategory => 'Jhalmuri & Snacks';

  @override
  String get vendorLead => 'Karim';

  @override
  String get homeTitle => 'Mein Start';

  @override
  String get shopOpen => 'Shop ist geöffnet';

  @override
  String get shopClosed => 'Shop ist geschlossen';

  @override
  String get closeShop => 'Shop schließen';

  @override
  String get openShop => 'Shop öffnen';

  @override
  String get welcomeBack => 'Willkommen zurück 👋';

  @override
  String get welcome => 'Willkommen 👋';

  @override
  String get welcomeOpenSubtitle =>
      'Dein Hygienefortschritt wird verfolgt, solange der Shop geöffnet ist.';

  @override
  String get welcomeClosedSubtitle =>
      'Öffne deinen Shop, um den heutigen Hygienefortschritt zu starten.';

  @override
  String get activeTasks => 'Aktive Aufgaben';

  @override
  String get todayTarget => 'Tagesziel';

  @override
  String get consistency => 'Konstanz';

  @override
  String get performance => 'Leistung';

  @override
  String get openFor => 'Geöffnet seit';

  @override
  String get latestCustomer => 'Letzter Kunde';

  @override
  String get latestReview => 'Letzte Bewertung';

  @override
  String get noReviewsYet => 'Noch keine Bewertungen';

  @override
  String get noCustomerReviewMessage =>
      'Kundenbewertungen erscheinen hier, nachdem Kunden deinen QR-Code gescannt und Feedback gegeben haben.';

  @override
  String get today => 'Heute';

  @override
  String get vendorScore => 'Anbieterwert';

  @override
  String vendorLevelLabel(int level) {
    return 'Anbieter-Level $level';
  }

  @override
  String xpNeededToReachLevel(int xp, int level) {
    return 'Noch $xp XP bis Level $level.';
  }

  @override
  String get strongHygiene => 'Starke Hygiene';

  @override
  String get improving => 'Verbessert sich';

  @override
  String get needsAttention => 'Mehr Hygiene nötig';

  @override
  String workingStreak(int days) {
    return '$days-Tage-Arbeitsserie';
  }

  @override
  String streakProtectedToday(int bestStreak) {
    return 'Serie heute geschützt. Beste Serie: $bestStreak Tage.';
  }

  @override
  String earnMoreXpToProtectStreak(int xp) {
    return 'Sammle heute noch $xp XP, um deine Serie zu schützen.';
  }

  @override
  String reviewsCount(int count) {
    return '$count Bewertungen';
  }

  @override
  String get merchantTrustPass => 'HÄNDLER-VERTRAUENSPASS';

  @override
  String get scanToRateMe => 'Scannen und bewerten';

  @override
  String get scanToRateDescription =>
      'Kunden können diesen Code scannen, um eine Hygienebewertung und Feedback abzugeben.';

  @override
  String get vendorReviewLink => 'Bewertungslink des Anbieters';

  @override
  String vendorIdLabel(String vendorId) {
    return 'Anbieter-ID: $vendorId';
  }

  @override
  String get copyReviewLink => 'Bewertungslink kopieren';

  @override
  String get reviewLinkCopied => 'Bewertungslink kopiert';

  @override
  String get reviewFlow => 'Bewertungsablauf';

  @override
  String get active => 'Aktiv';

  @override
  String get customerForm => 'Kundenformular';

  @override
  String get web => 'Web';

  @override
  String get howThisWorks => 'So funktioniert es';

  @override
  String get customerScansQr => 'Der Kunde scannt den QR-Code.';

  @override
  String get publicReviewFormOpens =>
      'Ein öffentliches Bewertungsformular öffnet sich im Browser.';

  @override
  String get customerLeavesRating =>
      'Der Kunde gibt eine Bewertung und kurzes Feedback ab.';

  @override
  String get reviewUpdatesSummary =>
      'Die Bewertung aktualisiert die Zusammenfassung dieses Anbieters.';

  @override
  String get noVendorQrCodeYet => 'Noch kein Anbieter-QR-Code';

  @override
  String get noVendorQrCodeDescription =>
      'Registrieren Sie sich oder melden Sie sich zuerst als Anbieter an. Nach der Registrierung erstellt Hygia einen eindeutigen Bewertungs-QR-Code für diesen Anbieter.';

  @override
  String get refresh => 'Aktualisieren';

  @override
  String get couldNotLoadVendorQrData =>
      'Anbieter-QR-Daten konnten nicht geladen werden.';

  @override
  String get tryAgain => 'Erneut versuchen';
}
