# Sprichst launch site

The Sprichst launch page ("Learn German by speaking it"), built in Flutter for web, Android, iOS and macOS.

## Languages

26 languages: the 24 official EU languages (Български, Čeština, Dansk, Deutsch, Ελληνικά, English, Español, Eesti, Suomi, Français, Gaeilge, Hrvatski, Magyar, Italiano, Lietuvių, Latviešu, Malti, Nederlands, Polski, Português, Română, Slovenčina, Slovenščina, Svenska) plus हिन्दी and తెలుగు. Strings live in `lib/l10n/app_<code>.arb`; `flutter gen-l10n` (run automatically by `flutter run`/`build`) generates `AppLocalizations`.

- The page opens in the device language when it's supported, otherwise English.
- Viewers can switch with the language menu in the nav; the choice is remembered.
- Links can pin a language with its code, for example `?lang=de`, `?lang=fr`, `?lang=hi`, `?lang=te`.
- To add a language, copy `app_en.arb` to `app_<code>.arb` and translate every key. The test `every language has every string` fails if any key is missing.
- Legal documents (`assets/legal/*.md`) stay in English as the binding version; other languages show a note saying so.

## Run

```sh
flutter run -d chrome          # web
flutter build web --release    # output in build/web
flutter test                   # layout checks at 3 widths × 26 languages, plus interactions
```

## Layout

- `lib/src/landing_page.dart`: page shell, sticky nav, language menu, footer
- `lib/src/sections/`: hero and content sections
- `lib/src/legal.dart`: legal document dialog and a small Markdown renderer
- `lib/src/theme.dart`: palette (light/dark) and type helpers
- `assets/`: Figtree fonts (OFL), app screenshots, Lottie animations, legal texts, brand mark
