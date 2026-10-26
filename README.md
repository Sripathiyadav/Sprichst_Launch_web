# Sprichst launch site

The Sprichst launch page ("Learn German by speaking it"), built in Flutter for web, Android, iOS and macOS. This repository is the public website only. The app's source lives in a separate project.

## Live addresses

| What | Address |
|---|---|
| Launch website (main) | https://sprichstweb.web.app |
| Same website, Firebase default domain | https://sprichstweb.firebaseapp.com |
| Public legal pages (privacy policy URL for the stores) | https://sprichstweb.web.app/legal/ |
| Web app (Sprichst in the browser) | https://sprichst-74bed.web.app |
| Source code (this repo) | https://github.com/Sripathiyadav/Sprichst_Launch_web |
| Main app repository | https://github.com/Sripathiyadav/Sprichst |
| Developer portfolio | https://sripathiyadavportfolio.netlify.app |

Firebase projects:
- `sprichstweb`: hosts this website (set in `.firebaserc`).
- `sprichst-74bed`: hosts the web app.

## Contact

- Email: sripathiyadav66@gmail.com
- Telephone and WhatsApp: +49 155 65800258 (WhatsApp username: @sripathi_yadav)
- Instagram: https://www.instagram.com/sri.in.germany/
- LinkedIn: https://www.linkedin.com/in/sripathi-yadav/
- GitHub: https://github.com/Sripathiyadav
- Issues and feedback: https://github.com/Sripathiyadav/Sprichst/issues

Provider details (required for Germany) are in the Impressum at https://sprichstweb.web.app/legal/impressum.

## Status

- Website: live.
- Web app: live at https://sprichst-74bed.web.app.
- Android: closed testing on Google Play. Testers are added by request; DM with the Gmail address used for Google Play.
- iOS and macOS: coming soon.

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

## Deploy

The website is hosted on Firebase Hosting (project `sprichstweb`), serving `build/web`.

```sh
flutter build web --release
firebase deploy --only hosting --project sprichstweb
```

`firebase.json` sets `no-cache` on every file so visitors always get the latest build. Cache revalidation is handled by ETags, so unchanged files are not re-downloaded.

## Assets

- Brand mark: `assets/brand/mark.svg`. Icons for the web, iOS, macOS and Android are rendered from it.
- Link-preview image: `web/og-image.png` (1200×630), used by LinkedIn, WhatsApp and X.
- Social post images: `social/`.

## Layout

- `lib/src/landing_page.dart`: page shell, sticky nav, language menu, footer
- `lib/src/sections/`: hero and content sections
- `lib/src/legal.dart`: legal document dialog and a small Markdown renderer
- `lib/src/theme.dart`: palette (light/dark) and type helpers
- `lib/src/widgets.dart`: shared widgets, links and the scroll-reveal animation
- `web/legal/`: static legal pages served at `/legal/`
- `assets/`: Figtree fonts (OFL), app screenshots, Lottie animations, legal texts, brand mark
