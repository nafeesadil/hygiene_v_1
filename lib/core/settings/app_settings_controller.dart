import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsController extends ChangeNotifier {
  static const String _localeKey = 'selected_locale_code';

  Locale? _locale;

  Locale? get locale => _locale;

  String get localeCode => _locale?.languageCode ?? 'en';

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_localeKey);

    if (code == null || code.isEmpty) {
      _locale = const Locale('en');
    } else {
      _locale = Locale(code);
    }

    notifyListeners();
  }

  Future<void> setLocaleCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_localeKey, code);

    _locale = Locale(code);
    notifyListeners();
  }

  String readableLanguageName(BuildContext context) {
    switch (localeCode) {
      case 'de':
        return 'Deutsch';
      case 'bn':
        return 'বাংলা';
      case 'en':
      default:
        return 'English';
    }
  }
}
