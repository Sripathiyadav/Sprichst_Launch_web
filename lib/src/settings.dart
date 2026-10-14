import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';

/// Viewer preferences for the site: language and light/dark appearance.
///
/// The language comes from, in order: a `?lang=` query parameter (so a
/// shared link opens in the right language), the viewer's saved choice,
/// then the device locale.
class SiteSettings extends ChangeNotifier {
  SiteSettings._(this._prefs, this._locale, this._themeMode);

  static const _localeKey = 'locale';
  static const _themeKey = 'theme';

  final SharedPreferences? _prefs;
  Locale? _locale;
  ThemeMode _themeMode;

  Locale? get locale => _locale;
  ThemeMode get themeMode => _themeMode;

  static Future<SiteSettings> load() async {
    SharedPreferences? prefs;
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (_) {
      // Storage can be blocked (private windows); the site still works.
    }
    final fromUrl = _supported(Uri.base.queryParameters['lang']);
    final saved = _supported(prefs?.getString(_localeKey));
    final theme = switch (prefs?.getString(_themeKey)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    return SiteSettings._(prefs, fromUrl ?? saved, theme);
  }

  static Locale? _supported(String? code) {
    if (code == null) return null;
    for (final l in AppLocalizations.supportedLocales) {
      if (l.languageCode == code) return l;
    }
    return null;
  }

  void setLocale(Locale locale) {
    _locale = locale;
    _prefs?.setString(_localeKey, locale.languageCode).ignore();
    notifyListeners();
  }

  void setThemeMode(ThemeMode mode) {
    _themeMode = mode;
    _prefs?.setString(_themeKey, mode.name).ignore();
    notifyListeners();
  }

  /// Flips to the opposite of what is on screen right now.
  void toggleTheme(Brightness current) =>
      setThemeMode(current == Brightness.dark ? ThemeMode.light : ThemeMode.dark);
}

/// Makes [SiteSettings] reachable from anywhere below the app.
class SettingsScope extends InheritedNotifier<SiteSettings> {
  const SettingsScope({super.key, required SiteSettings settings, required super.child})
      : super(notifier: settings);

  static SiteSettings of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<SettingsScope>()!.notifier!;
}

/// Languages in the order the language menu lists them: Latin-script names
/// alphabetically, then Greek, Cyrillic, Devanagari and Telugu.
final List<Locale> siteLanguages = () {
  final all = [...AppLocalizations.supportedLocales];
  int script(Locale l) => switch (l.languageCode) { 'el' => 1, 'bg' => 2, 'hi' => 3, 'te' => 4, _ => 0 };
  all.sort((a, b) {
    final byScript = script(a).compareTo(script(b));
    if (byScript != 0) return byScript;
    return _fold(lookupAppLocalizations(a).languageName).compareTo(_fold(lookupAppLocalizations(b).languageName));
  });
  return all;
}();

String _fold(String s) {
  const from = 'ČčŠšŽžÉéÍíÓóÚúÁáĀāĒēĪīŪūÄäÖöÜüÕõĘęĖėĮįŲųŁłŃńŚśŹźŻżŐőŰűĂăÂâÎîȘșȚțŤťĎďŇňĽľĹĺŔŕĆćĐđĦħĠġ';
  const to = 'CcSsZzEeIiOoUuAaAaEeIiUuAaOoUuOoEeEeIiUuLlNnSsZzZzOoUuAaAaIiSsTtTtDdNnLlLlRrCcDdHhGg';
  final b = StringBuffer();
  for (final r in s.runes) {
    final c = String.fromCharCode(r);
    final i = from.indexOf(c);
    b.write(i >= 0 ? to[i] : c);
  }
  return b.toString().toLowerCase();
}
