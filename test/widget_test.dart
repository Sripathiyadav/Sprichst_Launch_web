import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprichst_launch/l10n/app_localizations.dart';
import 'package:sprichst_launch/main.dart';
import 'package:sprichst_launch/src/legal.dart';
import 'package:sprichst_launch/src/sections/content.dart';
import 'package:sprichst_launch/src/settings.dart';
import 'package:sprichst_launch/src/widgets.dart';

Future<SiteSettings> _settings() async {
  SharedPreferences.setMockInitialValues({});
  return SiteSettings.load();
}

Future<void> _pump(WidgetTester tester, SiteSettings settings, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(SprichstSite(settings: settings));
  await tester.pumpAndSettle();
}

Future<void> _loadFonts() async {
  final loader = FontLoader('Figtree');
  for (final w in ['Light', 'Regular', 'Medium', 'SemiBold']) {
    loader.addFont(File('assets/fonts/Figtree-$w.ttf').readAsBytes().then((b) => ByteData.view(b.buffer)));
  }
  await loader.load();
}

void main() {
  setUpAll(_loadFonts);

  test('every language has every string', () {
    Set<String> keys(File f) =>
        (jsonDecode(f.readAsStringSync()) as Map<String, dynamic>).keys.where((k) => !k.startsWith('@')).toSet();
    final en = keys(File('lib/l10n/app_en.arb'));
    final files = Directory('lib/l10n').listSync().whereType<File>().where((f) => f.path.endsWith('.arb'));
    expect(files.length, AppLocalizations.supportedLocales.length);
    for (final f in files) {
      expect(en.difference(keys(f)), isEmpty, reason: 'missing in ${f.path}');
    }
  });

  test('all 24 official EU languages are supported', () {
    const eu = ['bg', 'hr', 'cs', 'da', 'nl', 'en', 'et', 'fi', 'fr', 'de', 'el', 'hu', 'ga', 'it', 'lv', 'lt', 'mt', 'pl', 'pt', 'ro', 'sk', 'sl', 'es', 'sv'];
    final codes = AppLocalizations.supportedLocales.map((l) => l.languageCode).toSet();
    expect(codes.containsAll(eu), isTrue, reason: 'missing ${eu.toSet().difference(codes)}');
  });

  test('hero titles mark exactly one emphasised phrase', () {
    for (final locale in AppLocalizations.supportedLocales) {
      expect('*'.allMatches(lookupAppLocalizations(locale).heroTitle).length, 2, reason: locale.languageCode);
    }
  });

  for (final size in const [Size(1440, 900), Size(820, 1180), Size(390, 844)]) {
    for (final locale in AppLocalizations.supportedLocales) {
      testWidgets('renders ${locale.languageCode} at ${size.width.toInt()}px without overflow', (tester) async {
        final settings = await _settings();
        settings.setLocale(locale);
        await _pump(tester, settings, size);
        final l = lookupAppLocalizations(locale);
        expect(find.text(l.heroLede), findsOneWidget);
        // Layout errors are reported by the framework and fail the test.
      });
    }
  }

  testWidgets('language menu switches the page language', (tester) async {
    final settings = await _settings();
    settings.setLocale(const Locale('en'));
    await _pump(tester, settings, const Size(1440, 900));

    await tester.tap(find.byTooltip('Language'));
    await tester.pumpAndSettle();
    // 26 languages: the last entry is below the fold and must scroll into view.
    await tester.ensureVisible(find.text('తెలుగు').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('తెలుగు').last);
    await tester.pumpAndSettle();

    expect(settings.locale, const Locale('te'));
    expect(find.text(lookupAppLocalizations(const Locale('te')).heroLede), findsOneWidget);
  });

  testWidgets('Maltese falls back to English system strings', (tester) async {
    final settings = await _settings();
    settings.setLocale(const Locale('mt'));
    await _pump(tester, settings, const Size(1440, 900));
    expect(find.text(lookupAppLocalizations(const Locale('mt')).heroLede), findsOneWidget);
    expect(MaterialLocalizations.of(tester.element(find.byType(Scaffold))).closeButtonTooltip, 'Close');
  });

  testWidgets('Greek labels uppercase without accents', (tester) async {
    final settings = await _settings();
    settings.setLocale(const Locale('el'));
    await _pump(tester, settings, const Size(1440, 900));
    expect(find.text('ΓΙΑΤΙ SPRICHST'), findsOneWidget);
  });

  testWidgets('theme toggle switches to dark', (tester) async {
    final settings = await _settings();
    settings.setLocale(const Locale('en'));
    await _pump(tester, settings, const Size(1440, 900));
    await tester.tap(find.byTooltip('Switch light or dark'));
    await tester.pumpAndSettle();
    expect(settings.themeMode, ThemeMode.dark);
  });

  testWidgets('legal documents open from the legal section', (tester) async {
    final settings = await _settings();
    settings.setLocale(const Locale('de'));
    await _pump(tester, settings, const Size(1440, 900));
    final finder = find.text('Barrierefreiheit');
    await tester.scrollUntilVisible(finder, 300, scrollable: find.byType(Scrollable).first);
    // Bring it clear of the nav bar before tapping.
    await tester.drag(find.byType(Scrollable).first, const Offset(0, -250));
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
    expect(find.text('Accessibility Statement'), findsOneWidget);
    expect(find.text(lookupAppLocalizations(const Locale('de')).legalEnglishOnly), findsOneWidget);
  });

  testWidgets('cards slide in one by one when scrolled to', (tester) async {
    final settings = await _settings();
    settings.setLocale(const Locale('en'));
    await _pump(tester, settings, const Size(1440, 900));
    double opacity(Finder reveal) =>
        tester.widget<FadeTransition>(find.descendant(of: reveal, matching: find.byType(FadeTransition)).first).opacity.value;
    final cards = find.descendant(of: find.byType(LegalSection), matching: find.byType(Reveal));
    expect(cards, findsNWidgets(LegalDoc.all.length));
    expect(opacity(cards.last), 0, reason: 'hidden until it scrolls into view');

    final position = tester.state<ScrollableState>(find.byType(Scrollable).first).position;
    position.jumpTo(position.maxScrollExtent);
    await tester.pump();
    // Step real frames so each card starts on the frame its turn comes up.
    for (var i = 0; i < 25; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }
    // A cascade: each card is at or behind the one before it, and they're not all at the same point.
    final values = [for (var i = 0; i < LegalDoc.all.length; i++) opacity(cards.at(i))];
    for (var i = 1; i < values.length; i++) {
      expect(values[i], lessThanOrEqualTo(values[i - 1]), reason: 'card $i ahead of card ${i - 1}: $values');
    }
    expect(values.first, greaterThan(values.last), reason: '$values');

    await tester.pumpAndSettle();
    for (var i = 0; i < LegalDoc.all.length; i++) {
      expect(opacity(cards.at(i)), 1);
    }
    expect(opacity(find.byType(Reveal).last), 1, reason: 'footer');
  });

  testWidgets('feature tiles show a few and hide the rest behind a button', (tester) async {
    final settings = await _settings();
    settings.setLocale(const Locale('en'));
    await _pump(tester, settings, const Size(1440, 900));
    final l = lookupAppLocalizations(const Locale('en'));
    final more = find.text(l.featMore(12));
    final scrollable = find.byType(Scrollable).first;
    expect(find.text(l.featCurriculumTitle), findsOneWidget);
    expect(find.text(l.featVoiceTitle), findsNothing, reason: 'one row of three on wide screens');

    await tester.scrollUntilVisible(more, 300, scrollable: scrollable);
    await tester.tap(more);
    await tester.pumpAndSettle();
    expect(find.text(l.featPrivateTitle), findsOneWidget);

    final less = find.text(l.featLess);
    await tester.scrollUntilVisible(less, 300, scrollable: scrollable);
    await tester.tap(less);
    await tester.pumpAndSettle();
    expect(find.text(l.featVoiceTitle), findsNothing);
    expect(more, findsOneWidget);
  });

  testWidgets('why animations loop on screen and pause off screen', (tester) async {
    final settings = await _settings();
    settings.setLocale(const Locale('en'));
    await _pump(tester, settings, const Size(1440, 900));
    final lottie = find.byType(Lottie).first;
    Animation<double> controller() => tester.widget<Lottie>(lottie).controller!;
    // Lottie decodes its file outside the fake clock.
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 200)));
    await tester.pump();
    final position = tester.state<ScrollableState>(find.byType(Scrollable).first).position;

    final card = tester.getTopLeft(lottie).dy - tester.getTopLeft(find.byType(Scrollable).first).dy;
    position.jumpTo(card - 100);
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 16));
    expect(controller().isAnimating, isTrue, reason: 'plays once on screen');
    final loop = (controller() as AnimationController).duration!;
    for (var t = Duration.zero; t < loop * 1.5; t += const Duration(milliseconds: 100)) {
      await tester.pump(const Duration(milliseconds: 100));
    }
    expect(controller().isAnimating, isTrue, reason: 'still running after a full cycle');

    position.jumpTo(position.maxScrollExtent);
    await tester.pump();
    expect(controller().isAnimating, isFalse, reason: 'paused off screen');
    await tester.pumpAndSettle();
  });
}
