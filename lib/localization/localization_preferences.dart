import 'dart:ui';

class LocalizationPreferences {
  static const String path = 'assets/translations';
  static const Locale enLocale = Locale('en');
  static const Locale deLocale = Locale('de');
  static const List<Locale> supportedLocales = [
    enLocale,
    deLocale,
  ];
  static const Locale fallbackLocale = enLocale;

  LocalizationPreferences._();
}
