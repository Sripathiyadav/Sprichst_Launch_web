import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Flutter ships no Material, Cupertino or Widgets strings for some languages
/// the site supports (Maltese). For those, system strings such as tooltips
/// and dialog labels fall back to English; the page copy is still translated.
const englishFallbackDelegates = <LocalizationsDelegate<dynamic>>[
  _Fallback<MaterialLocalizations>(GlobalMaterialLocalizations.delegate),
  _Fallback<CupertinoLocalizations>(GlobalCupertinoLocalizations.delegate),
  _Fallback<WidgetsLocalizations>(GlobalWidgetsLocalizations.delegate),
];

class _Fallback<T> extends LocalizationsDelegate<T> {
  const _Fallback(this.global);
  final LocalizationsDelegate<T> global;

  @override
  bool isSupported(Locale locale) => !global.isSupported(locale);

  @override
  Future<T> load(Locale locale) => global.load(const Locale('en'));

  @override
  bool shouldReload(_Fallback<T> old) => false;
}
