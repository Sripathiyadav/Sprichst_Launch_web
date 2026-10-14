import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bg.dart';
import 'app_localizations_cs.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_el.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_et.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_ga.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_hr.dart';
import 'app_localizations_hu.dart';
import 'app_localizations_it.dart';
import 'app_localizations_lt.dart';
import 'app_localizations_lv.dart';
import 'app_localizations_mt.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ro.dart';
import 'app_localizations_sk.dart';
import 'app_localizations_sl.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_te.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bg'),
    Locale('cs'),
    Locale('da'),
    Locale('de'),
    Locale('el'),
    Locale('en'),
    Locale('es'),
    Locale('et'),
    Locale('fi'),
    Locale('fr'),
    Locale('ga'),
    Locale('hi'),
    Locale('hr'),
    Locale('hu'),
    Locale('it'),
    Locale('lt'),
    Locale('lv'),
    Locale('mt'),
    Locale('nl'),
    Locale('pl'),
    Locale('pt'),
    Locale('ro'),
    Locale('sk'),
    Locale('sl'),
    Locale('sv'),
    Locale('te'),
  ];

  /// No description provided for @languageName.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageName;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Sprichst — Learn German by speaking it'**
  String get appTitle;

  /// No description provided for @stripNoTracking.
  ///
  /// In en, this message translates to:
  /// **'No analytics, no tracking, no ads.'**
  String get stripNoTracking;

  /// No description provided for @stripLevels.
  ///
  /// In en, this message translates to:
  /// **'Pre-A1 to B2 · Goethe and TestDaF tracks'**
  String get stripLevels;

  /// No description provided for @stripPlatforms.
  ///
  /// In en, this message translates to:
  /// **'Android · iOS · Web · macOS'**
  String get stripPlatforms;

  /// No description provided for @navWhy.
  ///
  /// In en, this message translates to:
  /// **'Why Sprichst'**
  String get navWhy;

  /// No description provided for @navFeatures.
  ///
  /// In en, this message translates to:
  /// **'Features'**
  String get navFeatures;

  /// No description provided for @navAi.
  ///
  /// In en, this message translates to:
  /// **'AI coach'**
  String get navAi;

  /// No description provided for @navPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get navPrivacy;

  /// No description provided for @navMaker.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get navMaker;

  /// No description provided for @navFaq.
  ///
  /// In en, this message translates to:
  /// **'FAQ'**
  String get navFaq;

  /// No description provided for @navDownload.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get navDownload;

  /// No description provided for @navMenu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get navMenu;

  /// No description provided for @themeToggle.
  ///
  /// In en, this message translates to:
  /// **'Switch light or dark'**
  String get themeToggle;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @heroPill.
  ///
  /// In en, this message translates to:
  /// **'48 lessons · 308 words · one clear next step'**
  String get heroPill;

  /// No description provided for @heroTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn German by *speaking* it.'**
  String get heroTitle;

  /// No description provided for @heroLede.
  ///
  /// In en, this message translates to:
  /// **'Short lessons from your first words to B2, an AI coach that explains why, and practice that comes back right when you need it.'**
  String get heroLede;

  /// No description provided for @ctaGet.
  ///
  /// In en, this message translates to:
  /// **'Get Sprichst'**
  String get ctaGet;

  /// No description provided for @ctaHow.
  ///
  /// In en, this message translates to:
  /// **'See how it works'**
  String get ctaHow;

  /// No description provided for @floatStreakTitle.
  ///
  /// In en, this message translates to:
  /// **'Day streak'**
  String get floatStreakTitle;

  /// No description provided for @floatStreakSub.
  ///
  /// In en, this message translates to:
  /// **'Keep it going tomorrow'**
  String get floatStreakSub;

  /// No description provided for @floatCorrectSub.
  ///
  /// In en, this message translates to:
  /// **'Correct · the polite way to order'**
  String get floatCorrectSub;

  /// No description provided for @floatWordSub.
  ///
  /// In en, this message translates to:
  /// **'bill · added to your reviews'**
  String get floatWordSub;

  /// No description provided for @floatBadgeTitle.
  ///
  /// In en, this message translates to:
  /// **'New badge: Wochenstreak'**
  String get floatBadgeTitle;

  /// No description provided for @floatBadgeSub.
  ///
  /// In en, this message translates to:
  /// **'Seven days in a row'**
  String get floatBadgeSub;

  /// No description provided for @worksLead.
  ///
  /// In en, this message translates to:
  /// **'The coach runs on your phone. Or bring your own key from'**
  String get worksLead;

  /// No description provided for @whyEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Why Sprichst'**
  String get whyEyebrow;

  /// No description provided for @whyTitle.
  ///
  /// In en, this message translates to:
  /// **'A course with a teacher in it. Not a chatbot with a course bolted on.'**
  String get whyTitle;

  /// No description provided for @whyBody.
  ///
  /// In en, this message translates to:
  /// **'Sprichst is built around a real curriculum and a learning engine. Every answer you give decides what comes next, so the app never makes you choose from a long menu.'**
  String get whyBody;

  /// No description provided for @whyLearnEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get whyLearnEyebrow;

  /// No description provided for @whyLearnTitle.
  ///
  /// In en, this message translates to:
  /// **'One clear next step'**
  String get whyLearnTitle;

  /// No description provided for @whyLearnBody.
  ///
  /// In en, this message translates to:
  /// **'Short lessons build on each other from your first words up. Home always shows what to do next.'**
  String get whyLearnBody;

  /// No description provided for @whyTalkEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Talk'**
  String get whyTalkEyebrow;

  /// No description provided for @whyTalkTitle.
  ///
  /// In en, this message translates to:
  /// **'A coach that explains why'**
  String get whyTalkTitle;

  /// No description provided for @whyTalkBody.
  ///
  /// In en, this message translates to:
  /// **'Write or speak with the AI coach. It corrects only real mistakes, tells you why in English, and translates its follow-up question.'**
  String get whyTalkBody;

  /// No description provided for @whyRememberEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Remember'**
  String get whyRememberEyebrow;

  /// No description provided for @whyRememberTitle.
  ///
  /// In en, this message translates to:
  /// **'Practice that comes back'**
  String get whyRememberTitle;

  /// No description provided for @whyRememberBody.
  ///
  /// In en, this message translates to:
  /// **'Words and mistakes return a little later each time you get them right, so what you learn stays learned.'**
  String get whyRememberBody;

  /// No description provided for @statLessons.
  ///
  /// In en, this message translates to:
  /// **'lessons from Pre-A1 to B2'**
  String get statLessons;

  /// No description provided for @statWords.
  ///
  /// In en, this message translates to:
  /// **'words with example sentences'**
  String get statWords;

  /// No description provided for @statDialogues.
  ///
  /// In en, this message translates to:
  /// **'dialogues to listen to and act out'**
  String get statDialogues;

  /// No description provided for @statGames.
  ///
  /// In en, this message translates to:
  /// **'games for der, die, das and more'**
  String get statGames;

  /// No description provided for @featEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Everything in the app'**
  String get featEyebrow;

  /// No description provided for @featTitle.
  ///
  /// In en, this message translates to:
  /// **'From your first Hallo to a TestDaF essay.'**
  String get featTitle;

  /// No description provided for @featBody.
  ///
  /// In en, this message translates to:
  /// **'All of this is in the app today. Lessons, reviews and saved words work offline.'**
  String get featBody;

  /// Button under the feature tiles that shows the hidden ones.
  ///
  /// In en, this message translates to:
  /// **'+{count} more'**
  String featMore(int count);

  /// No description provided for @featLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get featLess;

  /// No description provided for @featCurriculumTitle.
  ///
  /// In en, this message translates to:
  /// **'A real curriculum'**
  String get featCurriculumTitle;

  /// No description provided for @featCurriculumBody.
  ///
  /// In en, this message translates to:
  /// **'48 lessons from Pre-A1 to B2 with 308 words and 13 dialogues. Each lesson has an objective, examples and exercises.'**
  String get featCurriculumBody;

  /// No description provided for @featExamsTitle.
  ///
  /// In en, this message translates to:
  /// **'Exam tracks and mock exams'**
  String get featExamsTitle;

  /// No description provided for @featExamsBody.
  ///
  /// In en, this message translates to:
  /// **'Goethe-Zertifikat A1 to B2 and TestDaF: forms, messages, reading, listening, writing and speaking tasks.'**
  String get featExamsBody;

  /// No description provided for @featCoachTitle.
  ///
  /// In en, this message translates to:
  /// **'AI coach'**
  String get featCoachTitle;

  /// No description provided for @featCoachBody.
  ///
  /// In en, this message translates to:
  /// **'Chat in German. The coach corrects only real mistakes, explains why in English, remembers the last few messages and translates its follow-up question.'**
  String get featCoachBody;

  /// No description provided for @featVoiceTitle.
  ///
  /// In en, this message translates to:
  /// **'Voice mode'**
  String get featVoiceTitle;

  /// No description provided for @featVoiceBody.
  ///
  /// In en, this message translates to:
  /// **'Hands-free conversation: it listens, waits until you finish, answers aloud and listens again. Pick the voice you like.'**
  String get featVoiceBody;

  /// No description provided for @featWritingTitle.
  ///
  /// In en, this message translates to:
  /// **'Writing practice'**
  String get featWritingTitle;

  /// No description provided for @featWritingBody.
  ///
  /// In en, this message translates to:
  /// **'Type German sentences with ä ö ü ß keys at hand, with live feedback on speed and accuracy.'**
  String get featWritingBody;

  /// No description provided for @featCardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Flashcards that come back'**
  String get featCardsTitle;

  /// No description provided for @featCardsBody.
  ///
  /// In en, this message translates to:
  /// **'Spaced repetition brings every word and mistake back just before you would forget it. Rate Again, Hard, Good or Easy.'**
  String get featCardsBody;

  /// No description provided for @featGamesTitle.
  ///
  /// In en, this message translates to:
  /// **'Five games'**
  String get featGamesTitle;

  /// No description provided for @featGamesBody.
  ///
  /// In en, this message translates to:
  /// **'Short games for the tricky parts of German, from articles to spelling.'**
  String get featGamesBody;

  /// No description provided for @featPlannerTitle.
  ///
  /// In en, this message translates to:
  /// **'A planner that knows you'**
  String get featPlannerTitle;

  /// No description provided for @featPlannerBody.
  ///
  /// In en, this message translates to:
  /// **'Every answer feeds the planner. It picks the next review, weak-skill drill or lesson from your own accuracy, and retries what you missed.'**
  String get featPlannerBody;

  /// No description provided for @featStreaksTitle.
  ///
  /// In en, this message translates to:
  /// **'Streaks, quests and badges'**
  String get featStreaksTitle;

  /// No description provided for @featStreaksBody.
  ///
  /// In en, this message translates to:
  /// **'Three daily quests, XP, a day streak and badges such as Wochenstreak and Volltreffer. Finishing a level well moves you up.'**
  String get featStreaksBody;

  /// No description provided for @featProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Progress you can read'**
  String get featProgressTitle;

  /// No description provided for @featProgressBody.
  ///
  /// In en, this message translates to:
  /// **'Six skills, a level gauge, minutes per day, badges and how ready you are for your exam.'**
  String get featProgressBody;

  /// No description provided for @featOfflineTitle.
  ///
  /// In en, this message translates to:
  /// **'Works offline'**
  String get featOfflineTitle;

  /// No description provided for @featOfflineBody.
  ///
  /// In en, this message translates to:
  /// **'Lessons, saved words and reviews work without a connection. Download a model and the coach does too.'**
  String get featOfflineBody;

  /// No description provided for @featSyncTitle.
  ///
  /// In en, this message translates to:
  /// **'Your progress everywhere'**
  String get featSyncTitle;

  /// No description provided for @featSyncBody.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google and your progress follows you between phone, tablet, web and Mac.'**
  String get featSyncBody;

  /// No description provided for @featLanguageTitle.
  ///
  /// In en, this message translates to:
  /// **'Explained in your language'**
  String get featLanguageTitle;

  /// No description provided for @featLanguageBody.
  ///
  /// In en, this message translates to:
  /// **'Choose English, Hindi or Telugu to explain German, and a goal: everyday life, travel, work, Goethe-Zertifikat or TestDaF.'**
  String get featLanguageBody;

  /// No description provided for @featA11yTitle.
  ///
  /// In en, this message translates to:
  /// **'Calm, clear, accessible'**
  String get featA11yTitle;

  /// No description provided for @featA11yBody.
  ///
  /// In en, this message translates to:
  /// **'Light and dark themes, one action per screen, text that follows your device size, and motion that stops with Reduce Motion.'**
  String get featA11yBody;

  /// No description provided for @featPrivateTitle.
  ///
  /// In en, this message translates to:
  /// **'Private by design'**
  String get featPrivateTitle;

  /// No description provided for @featPrivateBody.
  ///
  /// In en, this message translates to:
  /// **'No analytics, ads or tracking. AI keys stay on your device. Export or erase everything from inside the app.'**
  String get featPrivateBody;

  /// No description provided for @skillVocabulary.
  ///
  /// In en, this message translates to:
  /// **'Vocabulary'**
  String get skillVocabulary;

  /// No description provided for @skillGrammar.
  ///
  /// In en, this message translates to:
  /// **'Grammar'**
  String get skillGrammar;

  /// No description provided for @skillReading.
  ///
  /// In en, this message translates to:
  /// **'Reading'**
  String get skillReading;

  /// No description provided for @skillListening.
  ///
  /// In en, this message translates to:
  /// **'Listening'**
  String get skillListening;

  /// No description provided for @skillWriting.
  ///
  /// In en, this message translates to:
  /// **'Writing'**
  String get skillWriting;

  /// No description provided for @skillSpeaking.
  ///
  /// In en, this message translates to:
  /// **'Speaking'**
  String get skillSpeaking;

  /// No description provided for @screensEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Screens'**
  String get screensEyebrow;

  /// No description provided for @screensTitle.
  ///
  /// In en, this message translates to:
  /// **'Paper, ink and one action per screen.'**
  String get screensTitle;

  /// No description provided for @screensBody.
  ///
  /// In en, this message translates to:
  /// **'These are rendered from the real app. Switch the page to dark to see the dark screens.'**
  String get screensBody;

  /// No description provided for @screenSignIn.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get screenSignIn;

  /// No description provided for @screenSignInSub.
  ///
  /// In en, this message translates to:
  /// **'Google, no tracking'**
  String get screenSignInSub;

  /// No description provided for @screenWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get screenWelcome;

  /// No description provided for @screenWelcomeSub.
  ///
  /// In en, this message translates to:
  /// **'The animated mark'**
  String get screenWelcomeSub;

  /// No description provided for @screenTour.
  ///
  /// In en, this message translates to:
  /// **'Tour'**
  String get screenTour;

  /// No description provided for @screenTourSub.
  ///
  /// In en, this message translates to:
  /// **'Five short pages'**
  String get screenTourSub;

  /// No description provided for @screenPrivate.
  ///
  /// In en, this message translates to:
  /// **'Private'**
  String get screenPrivate;

  /// No description provided for @screenPrivateSub.
  ///
  /// In en, this message translates to:
  /// **'Your words stay yours'**
  String get screenPrivateSub;

  /// No description provided for @screenGoal.
  ///
  /// In en, this message translates to:
  /// **'Your goal'**
  String get screenGoal;

  /// No description provided for @screenGoalSub.
  ///
  /// In en, this message translates to:
  /// **'Language, level, goal'**
  String get screenGoalSub;

  /// No description provided for @screenHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get screenHome;

  /// No description provided for @screenHomeSub.
  ///
  /// In en, this message translates to:
  /// **'Streak, level gauge, quests'**
  String get screenHomeSub;

  /// No description provided for @screenLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get screenLearn;

  /// No description provided for @screenLearnSub.
  ///
  /// In en, this message translates to:
  /// **'The roadmap, A0 to C1'**
  String get screenLearnSub;

  /// No description provided for @screenPractice.
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get screenPractice;

  /// No description provided for @screenPracticeSub.
  ///
  /// In en, this message translates to:
  /// **'Reviews, cards, games'**
  String get screenPracticeSub;

  /// No description provided for @screenWriting.
  ///
  /// In en, this message translates to:
  /// **'Writing'**
  String get screenWriting;

  /// No description provided for @screenWritingSub.
  ///
  /// In en, this message translates to:
  /// **'Type with ä ö ü ß'**
  String get screenWritingSub;

  /// No description provided for @screenCoach.
  ///
  /// In en, this message translates to:
  /// **'Coach'**
  String get screenCoach;

  /// No description provided for @screenCoachSub.
  ///
  /// In en, this message translates to:
  /// **'Chat or talk'**
  String get screenCoachSub;

  /// No description provided for @screenProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get screenProgress;

  /// No description provided for @screenProgressSub.
  ///
  /// In en, this message translates to:
  /// **'Skills and badges'**
  String get screenProgressSub;

  /// No description provided for @screenAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get screenAccount;

  /// No description provided for @screenAccountSub.
  ///
  /// In en, this message translates to:
  /// **'AI key, voice, privacy'**
  String get screenAccountSub;

  /// No description provided for @howEyebrow.
  ///
  /// In en, this message translates to:
  /// **'How it works'**
  String get howEyebrow;

  /// No description provided for @howTitle.
  ///
  /// In en, this message translates to:
  /// **'From sign-in to your daily step.'**
  String get howTitle;

  /// No description provided for @step1Title.
  ///
  /// In en, this message translates to:
  /// **'Sign in with Google'**
  String get step1Title;

  /// No description provided for @step1Body.
  ///
  /// In en, this message translates to:
  /// **'No password to remember, no tracking.'**
  String get step1Body;

  /// No description provided for @step2Title.
  ///
  /// In en, this message translates to:
  /// **'Take the tour'**
  String get step2Title;

  /// No description provided for @step2Body.
  ///
  /// In en, this message translates to:
  /// **'Five short pages on how Sprichst works. Skip any time.'**
  String get step2Body;

  /// No description provided for @step3Title.
  ///
  /// In en, this message translates to:
  /// **'Answer three questions'**
  String get step3Title;

  /// No description provided for @step3Body.
  ///
  /// In en, this message translates to:
  /// **'Explanation language, your level and what you want German for.'**
  String get step3Body;

  /// No description provided for @step4Title.
  ///
  /// In en, this message translates to:
  /// **'Open Home'**
  String get step4Title;

  /// No description provided for @step4Body.
  ///
  /// In en, this message translates to:
  /// **'Your streak, level gauge, three daily quests and one recommended step.'**
  String get step4Body;

  /// No description provided for @step5Title.
  ///
  /// In en, this message translates to:
  /// **'Learn, review, talk'**
  String get step5Title;

  /// No description provided for @step5Body.
  ///
  /// In en, this message translates to:
  /// **'Lessons, spaced reviews, weak-skill drills, writing or the coach.'**
  String get step5Body;

  /// No description provided for @step6Title.
  ///
  /// In en, this message translates to:
  /// **'Watch it add up'**
  String get step6Title;

  /// No description provided for @step6Body.
  ///
  /// In en, this message translates to:
  /// **'XP, streaks, badges and skills. Finish a level well to move up.'**
  String get step6Body;

  /// No description provided for @aiEyebrow.
  ///
  /// In en, this message translates to:
  /// **'The AI coach'**
  String get aiEyebrow;

  /// No description provided for @aiTitle.
  ///
  /// In en, this message translates to:
  /// **'You choose where the AI runs.'**
  String get aiTitle;

  /// No description provided for @aiBody.
  ///
  /// In en, this message translates to:
  /// **'Sprichst runs no AI server. The coach answers on your phone, offline, or with your own key, straight from the app to the provider you pick. Nothing switches without asking you.'**
  String get aiBody;

  /// No description provided for @aiProviderAny.
  ///
  /// In en, this message translates to:
  /// **'Any OpenAI-compatible server'**
  String get aiProviderAny;

  /// No description provided for @aiOptPhoneTitle.
  ///
  /// In en, this message translates to:
  /// **'This phone only'**
  String get aiOptPhoneTitle;

  /// No description provided for @aiOptPhoneBody.
  ///
  /// In en, this message translates to:
  /// **'Download a model once, on Wi-Fi. Then the coach works offline and nothing you write leaves your phone.'**
  String get aiOptPhoneBody;

  /// No description provided for @aiOptKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'My own AI key'**
  String get aiOptKeyTitle;

  /// No description provided for @aiOptKeyBody.
  ///
  /// In en, this message translates to:
  /// **'Stronger answers from your provider. The key stays in your device\'s secure storage and is never synced.'**
  String get aiOptKeyBody;

  /// No description provided for @aiOptAutoTitle.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get aiOptAutoTitle;

  /// No description provided for @aiOptAutoBody.
  ///
  /// In en, this message translates to:
  /// **'Answers on your phone, and uses your key only for what isn\'t downloaded yet.'**
  String get aiOptAutoBody;

  /// No description provided for @privacyEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Private by design'**
  String get privacyEyebrow;

  /// No description provided for @privacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Your words stay yours.'**
  String get privacyTitle;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'The privacy policy was written to be read, not to hide things. This is the short version.'**
  String get privacyBody;

  /// No description provided for @privacyReadPolicy.
  ///
  /// In en, this message translates to:
  /// **'Read the privacy policy'**
  String get privacyReadPolicy;

  /// No description provided for @privacy1Title.
  ///
  /// In en, this message translates to:
  /// **'No analytics, ads or tracking'**
  String get privacy1Title;

  /// No description provided for @privacy1Body.
  ///
  /// In en, this message translates to:
  /// **'No session replay, no advertising profiles, no third-party cookies.'**
  String get privacy1Body;

  /// No description provided for @privacy2Title.
  ///
  /// In en, this message translates to:
  /// **'Only your learning progress is stored'**
  String get privacy2Title;

  /// No description provided for @privacy2Body.
  ///
  /// In en, this message translates to:
  /// **'It follows you between devices. Nothing else about you is collected on purpose.'**
  String get privacy2Body;

  /// No description provided for @privacy3Title.
  ///
  /// In en, this message translates to:
  /// **'Your voice is never kept'**
  String get privacy3Title;

  /// No description provided for @privacy3Body.
  ///
  /// In en, this message translates to:
  /// **'Recordings are turned into text and thrown away. Nothing is used to train anything.'**
  String get privacy3Body;

  /// No description provided for @privacy4Title.
  ///
  /// In en, this message translates to:
  /// **'Export or erase everything in the app'**
  String get privacy4Title;

  /// No description provided for @privacy4Body.
  ///
  /// In en, this message translates to:
  /// **'Account → Privacy & data. No email needed.'**
  String get privacy4Body;

  /// No description provided for @makerEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Who’s behind it'**
  String get makerEyebrow;

  /// No description provided for @makerQuote.
  ///
  /// In en, this message translates to:
  /// **'I wanted a German app that teaches from a real course, explains my mistakes and doesn’t watch me while I learn. So I built Sprichst.'**
  String get makerQuote;

  /// No description provided for @makerRole.
  ///
  /// In en, this message translates to:
  /// **'Independent developer, maker of Sprichst'**
  String get makerRole;

  /// No description provided for @makerCopyEmail.
  ///
  /// In en, this message translates to:
  /// **'Copy email address'**
  String get makerCopyEmail;

  /// No description provided for @makerCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get makerCopied;

  /// No description provided for @makerReport.
  ///
  /// In en, this message translates to:
  /// **'Report a bug or share an idea'**
  String get makerReport;

  /// No description provided for @dlEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get dlEyebrow;

  /// No description provided for @dlTitle.
  ///
  /// In en, this message translates to:
  /// **'Start with your first lesson today.'**
  String get dlTitle;

  /// No description provided for @dlBody.
  ///
  /// In en, this message translates to:
  /// **'Sprichst is launching on Android, iOS, the web and macOS.'**
  String get dlBody;

  /// No description provided for @dlSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming soon'**
  String get dlSoon;

  /// No description provided for @dlAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available now'**
  String get dlAvailable;

  /// No description provided for @dlAndroidBody.
  ///
  /// In en, this message translates to:
  /// **'Google Play. Android phones and tablets.'**
  String get dlAndroidBody;

  /// No description provided for @dlIosTitle.
  ///
  /// In en, this message translates to:
  /// **'iPhone and iPad'**
  String get dlIosTitle;

  /// No description provided for @dlIosBody.
  ///
  /// In en, this message translates to:
  /// **'App Store. iPhone and iPad.'**
  String get dlIosBody;

  /// No description provided for @dlWebTitle.
  ///
  /// In en, this message translates to:
  /// **'Web'**
  String get dlWebTitle;

  /// No description provided for @dlWebBody.
  ///
  /// In en, this message translates to:
  /// **'In any browser. The coach needs your own AI key here.'**
  String get dlWebBody;

  /// No description provided for @dlWebButton.
  ///
  /// In en, this message translates to:
  /// **'Open the web app'**
  String get dlWebButton;

  /// No description provided for @dlMacBody.
  ///
  /// In en, this message translates to:
  /// **'On Mac, with the same account and progress.'**
  String get dlMacBody;

  /// No description provided for @sourceTitle.
  ///
  /// In en, this message translates to:
  /// **'Curious how it’s built?'**
  String get sourceTitle;

  /// No description provided for @sourceBody.
  ///
  /// In en, this message translates to:
  /// **'Flutter, Firebase and on-device AI, with about 540 tests.'**
  String get sourceBody;

  /// No description provided for @sourceButton.
  ///
  /// In en, this message translates to:
  /// **'View the code on GitHub'**
  String get sourceButton;

  /// No description provided for @faqEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Questions'**
  String get faqEyebrow;

  /// No description provided for @faqTitle.
  ///
  /// In en, this message translates to:
  /// **'Good to know'**
  String get faqTitle;

  /// No description provided for @faq1Q.
  ///
  /// In en, this message translates to:
  /// **'Do I need an AI key?'**
  String get faq1Q;

  /// No description provided for @faq1A.
  ///
  /// In en, this message translates to:
  /// **'No. On a phone, download a model once in Account → AI & voice and the coach works offline. A key from Groq, Gemini, OpenAI or another provider gives stronger answers; free tiers exist at Groq, Gemini and OpenRouter. In a web browser the on-device models can’t run, so the web version needs your key for the coach.'**
  String get faq1A;

  /// No description provided for @faq2Q.
  ///
  /// In en, this message translates to:
  /// **'Which levels and exams does it cover?'**
  String get faq2Q;

  /// No description provided for @faq2A.
  ///
  /// In en, this message translates to:
  /// **'48 lessons from Pre-A1 to B2, with exam tracks for Goethe-Zertifikat A1, A2, B1 and B2 and for TestDaF, plus mock exams.'**
  String get faq2A;

  /// No description provided for @faq3Q.
  ///
  /// In en, this message translates to:
  /// **'Does it work offline?'**
  String get faq3Q;

  /// No description provided for @faq3A.
  ///
  /// In en, this message translates to:
  /// **'Lessons, saved words, reviews and your progress work offline. The coach works offline too when you use a model on your phone. Your own AI key and syncing need the internet.'**
  String get faq3A;

  /// No description provided for @faq4Q.
  ///
  /// In en, this message translates to:
  /// **'What language explains German?'**
  String get faq4Q;

  /// No description provided for @faq4A.
  ///
  /// In en, this message translates to:
  /// **'You choose during onboarding: English, Hindi or Telugu, or Other.'**
  String get faq4A;

  /// No description provided for @faq5Q.
  ///
  /// In en, this message translates to:
  /// **'Are my conversations used to train AI?'**
  String get faq5Q;

  /// No description provided for @faq5A.
  ///
  /// In en, this message translates to:
  /// **'Not by Sprichst. On your phone they stay on your phone. With your own key, your messages go to the provider you chose under your own agreement with them. Sprichst never receives them.'**
  String get faq5A;

  /// No description provided for @faq6Q.
  ///
  /// In en, this message translates to:
  /// **'Can I delete my data?'**
  String get faq6Q;

  /// No description provided for @faq6A.
  ///
  /// In en, this message translates to:
  /// **'Yes. Export everything as JSON or erase your account in Account → Privacy & data.'**
  String get faq6A;

  /// No description provided for @faq7Q.
  ///
  /// In en, this message translates to:
  /// **'Is it accessible?'**
  String get faq7Q;

  /// No description provided for @faq7A.
  ///
  /// In en, this message translates to:
  /// **'Light and dark themes checked for WCAG AA contrast, 48-pixel touch targets, text that follows your device’s text size, and animations that stop when Reduce Motion is on.'**
  String get faq7A;

  /// No description provided for @legalEyebrow.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get legalEyebrow;

  /// No description provided for @legalTitle.
  ///
  /// In en, this message translates to:
  /// **'Policies and notices'**
  String get legalTitle;

  /// No description provided for @legalBody.
  ///
  /// In en, this message translates to:
  /// **'The full text of every document, the same ones bundled in the app.'**
  String get legalBody;

  /// No description provided for @legalPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get legalPrivacy;

  /// No description provided for @legalPrivacySub.
  ///
  /// In en, this message translates to:
  /// **'What we handle, why, and your rights'**
  String get legalPrivacySub;

  /// No description provided for @legalTerms.
  ///
  /// In en, this message translates to:
  /// **'Terms of service'**
  String get legalTerms;

  /// No description provided for @legalTermsSub.
  ///
  /// In en, this message translates to:
  /// **'The agreement for using Sprichst'**
  String get legalTermsSub;

  /// No description provided for @legalRights.
  ///
  /// In en, this message translates to:
  /// **'Your rights'**
  String get legalRights;

  /// No description provided for @legalRightsSub.
  ///
  /// In en, this message translates to:
  /// **'Access, export, erase, by region'**
  String get legalRightsSub;

  /// No description provided for @legalCookies.
  ///
  /// In en, this message translates to:
  /// **'Cookies and storage'**
  String get legalCookies;

  /// No description provided for @legalCookiesSub.
  ///
  /// In en, this message translates to:
  /// **'Only what the app needs'**
  String get legalCookiesSub;

  /// No description provided for @legalAi.
  ///
  /// In en, this message translates to:
  /// **'AI transparency'**
  String get legalAi;

  /// No description provided for @legalAiSub.
  ///
  /// In en, this message translates to:
  /// **'How the coach works, EU AI Act'**
  String get legalAiSub;

  /// No description provided for @legalDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get legalDisclaimer;

  /// No description provided for @legalDisclaimerSub.
  ///
  /// In en, this message translates to:
  /// **'A learning aid, not a guarantee'**
  String get legalDisclaimerSub;

  /// No description provided for @legalA11y.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get legalA11y;

  /// No description provided for @legalA11ySub.
  ///
  /// In en, this message translates to:
  /// **'WCAG 2.2 AA goal and what’s in place'**
  String get legalA11ySub;

  /// No description provided for @legalSecurity.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get legalSecurity;

  /// No description provided for @legalSecuritySub.
  ///
  /// In en, this message translates to:
  /// **'How your data is protected'**
  String get legalSecuritySub;

  /// No description provided for @legalCopyright.
  ///
  /// In en, this message translates to:
  /// **'Copyright and takedown'**
  String get legalCopyright;

  /// No description provided for @legalCopyrightSub.
  ///
  /// In en, this message translates to:
  /// **'DMCA and DSA notices'**
  String get legalCopyrightSub;

  /// No description provided for @legalThirdParty.
  ///
  /// In en, this message translates to:
  /// **'Third-party notices'**
  String get legalThirdParty;

  /// No description provided for @legalThirdPartySub.
  ///
  /// In en, this message translates to:
  /// **'Open-source licences'**
  String get legalThirdPartySub;

  /// No description provided for @legalImpressum.
  ///
  /// In en, this message translates to:
  /// **'Impressum'**
  String get legalImpressum;

  /// No description provided for @legalImpressumSub.
  ///
  /// In en, this message translates to:
  /// **'Provider information (DDG § 5)'**
  String get legalImpressumSub;

  /// No description provided for @legalEnglishOnly.
  ///
  /// In en, this message translates to:
  /// **'This document is published in English, the binding version.'**
  String get legalEnglishOnly;

  /// No description provided for @legalLoadError.
  ///
  /// In en, this message translates to:
  /// **'This document couldn’t be loaded. Try again in a moment.'**
  String get legalLoadError;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @footerTagline.
  ///
  /// In en, this message translates to:
  /// **'Learn German by speaking it. No analytics, no tracking, no ads.'**
  String get footerTagline;

  /// No description provided for @footerProduct.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get footerProduct;

  /// No description provided for @footerAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get footerAbout;

  /// No description provided for @footerLegal.
  ///
  /// In en, this message translates to:
  /// **'Legal'**
  String get footerLegal;

  /// No description provided for @footerScreens.
  ///
  /// In en, this message translates to:
  /// **'Screens'**
  String get footerScreens;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Sripathi · Sprichst'**
  String get footerCopyright;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'bg',
    'cs',
    'da',
    'de',
    'el',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'ga',
    'hi',
    'hr',
    'hu',
    'it',
    'lt',
    'lv',
    'mt',
    'nl',
    'pl',
    'pt',
    'ro',
    'sk',
    'sl',
    'sv',
    'te',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bg':
      return AppLocalizationsBg();
    case 'cs':
      return AppLocalizationsCs();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'el':
      return AppLocalizationsEl();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'et':
      return AppLocalizationsEt();
    case 'fi':
      return AppLocalizationsFi();
    case 'fr':
      return AppLocalizationsFr();
    case 'ga':
      return AppLocalizationsGa();
    case 'hi':
      return AppLocalizationsHi();
    case 'hr':
      return AppLocalizationsHr();
    case 'hu':
      return AppLocalizationsHu();
    case 'it':
      return AppLocalizationsIt();
    case 'lt':
      return AppLocalizationsLt();
    case 'lv':
      return AppLocalizationsLv();
    case 'mt':
      return AppLocalizationsMt();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'pt':
      return AppLocalizationsPt();
    case 'ro':
      return AppLocalizationsRo();
    case 'sk':
      return AppLocalizationsSk();
    case 'sl':
      return AppLocalizationsSl();
    case 'sv':
      return AppLocalizationsSv();
    case 'te':
      return AppLocalizationsTe();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
