// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Estonian (`et`).
class AppLocalizationsEt extends AppLocalizations {
  AppLocalizationsEt([String locale = 'et']) : super(locale);

  @override
  String get languageName => 'Eesti';

  @override
  String get appTitle => 'Sprichst — Õpi saksa keelt rääkides';

  @override
  String get stripNoTracking => 'Ei analüütikat, ei jälgimist, ei reklaame.';

  @override
  String get stripLevels => 'Pre-A1 kuni B2 · Goethe ja TestDaF rajad';

  @override
  String get stripPlatforms => 'Android · iOS · Web · macOS';

  @override
  String get navWhy => 'Miks Sprichst';

  @override
  String get navFeatures => 'Funktsioonid';

  @override
  String get navAi => 'AI-treener';

  @override
  String get navPrivacy => 'Privaatsus';

  @override
  String get navMaker => 'Minust';

  @override
  String get navFaq => 'KKK';

  @override
  String get navDownload => 'Laadi alla';

  @override
  String get navMenu => 'Menüü';

  @override
  String get themeToggle => 'Vaheta hele või tume';

  @override
  String get languageLabel => 'Keel';

  @override
  String get heroPill => '48 õppetundi · 308 sõna · üks selge järgmine samm';

  @override
  String get heroTitle => 'Õpi saksa keelt *rääkides*.';

  @override
  String get heroLede =>
      'Lühikesed tunnid esimestest sõnadest kuni B2-ni, AI-treener, kes selgitab, miks, ja harjutused, mis tulevad tagasi just siis, kui neid vajad.';

  @override
  String get ctaGet => 'Hangi Sprichst';

  @override
  String get ctaHow => 'Vaata, kuidas see töötab';

  @override
  String get floatStreakTitle => 'Päeva järjest';

  @override
  String get floatStreakSub => 'Jätka homme';

  @override
  String get floatCorrectSub => 'Õige · viisakas viis tellida';

  @override
  String get floatWordSub => 'arve · lisatud su kordamistesse';

  @override
  String get floatBadgeTitle => 'Uus märk: Wochenstreak';

  @override
  String get floatBadgeSub => 'Seitse päeva järjest';

  @override
  String get worksLead =>
      'Treener töötab su telefonis. Või kasuta oma võtit teenusest';

  @override
  String get whyEyebrow => 'Miks Sprichst';

  @override
  String get whyTitle =>
      'Kursus, milles on õpetaja. Mitte vestlusrobot, millele on kursus külge poltitud.';

  @override
  String get whyBody =>
      'Sprichst põhineb päris õppekaval ja õppemootoril. Iga vastus otsustab, mis tuleb järgmiseks, nii et rakendus ei pane sind kunagi pikast menüüst valima.';

  @override
  String get whyLearnEyebrow => 'Õpi';

  @override
  String get whyLearnTitle => 'Üks selge järgmine samm';

  @override
  String get whyLearnBody =>
      'Lühikesed tunnid ehitavad üksteisele esimestest sõnadest alates. Avaleht näitab alati, mida edasi teha.';

  @override
  String get whyTalkEyebrow => 'Räägi';

  @override
  String get whyTalkTitle => 'Treener, kes selgitab, miks';

  @override
  String get whyTalkBody =>
      'Kirjuta või räägi AI-treeneriga. See parandab ainult päris vigu, selgitab inglise keeles, miks, ja tõlgib oma järgmise küsimuse.';

  @override
  String get whyRememberEyebrow => 'Mäleta';

  @override
  String get whyRememberTitle => 'Harjutus, mis tuleb tagasi';

  @override
  String get whyRememberBody =>
      'Sõnad ja vead tulevad iga õige vastuse järel veidi hiljem tagasi, nii et õpitu jääb meelde.';

  @override
  String get statLessons => 'õppetundi Pre-A1-st B2-ni';

  @override
  String get statWords => 'sõna näitelausetega';

  @override
  String get statDialogues => 'dialoogi kuulamiseks ja läbimänguks';

  @override
  String get statGames => 'mängu der, die, das ja muu jaoks';

  @override
  String get featEyebrow => 'Kõik rakenduses';

  @override
  String get featTitle => 'Esimesest Hallost TestDaF-i esseeni.';

  @override
  String get featBody =>
      'Kõik see on juba rakenduses. Tunnid, kordamised ja salvestatud sõnad töötavad võrguühenduseta.';

  @override
  String featMore(int count) {
    return '+$count veel';
  }

  @override
  String get featLess => 'Näita vähem';

  @override
  String get featCurriculumTitle => 'Päris õppekava';

  @override
  String get featCurriculumBody =>
      '48 õppetundi Pre-A1-st B2-ni, 308 sõna ja 13 dialoogi. Igal tunnil on eesmärk, näited ja harjutused.';

  @override
  String get featExamsTitle => 'Eksamirajad ja proovieksamid';

  @override
  String get featExamsBody =>
      'Goethe-Zertifikat A1 kuni B2 ja TestDaF: vormid, sõnumid, lugemine, kuulamine, kirjutamine ja rääkimine.';

  @override
  String get featCoachTitle => 'AI-treener';

  @override
  String get featCoachBody =>
      'Vestle saksa keeles. Treener parandab ainult päris vigu, selgitab inglise keeles, miks, mäletab viimaseid sõnumeid ja tõlgib oma järgmise küsimuse.';

  @override
  String get featVoiceTitle => 'Hääle režiim';

  @override
  String get featVoiceBody =>
      'Käed-vabad vestlus: see kuulab, ootab, kuni lõpetad, vastab valjult ja kuulab uuesti. Vali meelepärane hääl.';

  @override
  String get featWritingTitle => 'Kirjutamisharjutus';

  @override
  String get featWritingBody =>
      'Kirjuta saksakeelseid lauseid, ä ö ü ß klahvid käepärast, ja saa kohe tagasisidet kiiruse ja täpsuse kohta.';

  @override
  String get featCardsTitle => 'Kaardid, mis tulevad tagasi';

  @override
  String get featCardsBody =>
      'Hajutatud kordamine toob iga sõna ja vea tagasi just enne, kui selle unustaksid. Hinda: Uuesti, Raske, Hea või Lihtne.';

  @override
  String get featGamesTitle => 'Viis mängu';

  @override
  String get featGamesBody =>
      'Lühikesed mängud saksa keele keeruliste osade jaoks, artiklitest õigekirjani.';

  @override
  String get featPlannerTitle => 'Planeerija, kes tunneb sind';

  @override
  String get featPlannerBody =>
      'Iga vastus toidab planeerijat. See valib järgmise kordamise, nõrga oskuse harjutuse või tunni sinu enda täpsuse põhjal ja kordab, mis jäi vahele.';

  @override
  String get featStreaksTitle => 'Seeriad, ülesanded ja märgid';

  @override
  String get featStreaksBody =>
      'Kolm igapäevast ülesannet, XP, päevaseeria ja märgid nagu Wochenstreak ja Volltreffer. Taseme hea lõpetamine viib sind edasi.';

  @override
  String get featProgressTitle => 'Loetav edenemine';

  @override
  String get featProgressBody =>
      'Kuus oskust, tasemenäidik, minutid päevas, märgid ja kui valmis oled eksamiks.';

  @override
  String get featOfflineTitle => 'Töötab võrguühenduseta';

  @override
  String get featOfflineBody =>
      'Tunnid, salvestatud sõnad ja kordamised töötavad ühenduseta. Laadi mudel alla ja treener ka.';

  @override
  String get featSyncTitle => 'Su edenemine kõikjal';

  @override
  String get featSyncBody =>
      'Logi sisse Google’iga ja su edenemine liigub kaasa telefoni, tahvli, veebi ja Maci vahel.';

  @override
  String get featLanguageTitle => 'Selgitatud sinu keeles';

  @override
  String get featLanguageBody =>
      'Vali saksa keele selgitamiseks inglise, hindi või telugu keel ning eesmärk: igapäevaelu, reisimine, töö, Goethe-Zertifikat või TestDaF.';

  @override
  String get featA11yTitle => 'Rahulik, selge, ligipääsetav';

  @override
  String get featA11yBody =>
      'Hele ja tume teema, üks tegevus ekraanil, seadme suurust järgiv tekst ja animatsioonid, mis peatuvad valikuga Vähenda liikumist.';

  @override
  String get featPrivateTitle => 'Privaatne algusest peale';

  @override
  String get featPrivateBody =>
      'Ei analüütikat, reklaame ega jälgimist. AI-võtmed jäävad su seadmesse. Ekspordi või kustuta kõik rakenduse seest.';

  @override
  String get skillVocabulary => 'Sõnavara';

  @override
  String get skillGrammar => 'Grammatika';

  @override
  String get skillReading => 'Lugemine';

  @override
  String get skillListening => 'Kuulamine';

  @override
  String get skillWriting => 'Kirjutamine';

  @override
  String get skillSpeaking => 'Rääkimine';

  @override
  String get screensEyebrow => 'Ekraanid';

  @override
  String get screensTitle => 'Paber, tint ja üks tegevus ekraanil.';

  @override
  String get screensBody =>
      'Need on päris rakendusest. Lülita leht tumedaks, et näha tumedaid ekraane.';

  @override
  String get screenSignIn => 'Sisselogimine';

  @override
  String get screenSignInSub => 'Google, ilma jälgimiseta';

  @override
  String get screenWelcome => 'Tere tulemast';

  @override
  String get screenWelcomeSub => 'Animeeritud logo';

  @override
  String get screenTour => 'Tutvustus';

  @override
  String get screenTourSub => 'Viis lühikest lehte';

  @override
  String get screenPrivate => 'Privaatne';

  @override
  String get screenPrivateSub => 'Su sõnad jäävad sinule';

  @override
  String get screenGoal => 'Sinu eesmärk';

  @override
  String get screenGoalSub => 'Keel, tase, eesmärk';

  @override
  String get screenHome => 'Avaleht';

  @override
  String get screenHomeSub => 'Seeria, tasemenäidik, ülesanded';

  @override
  String get screenLearn => 'Õpi';

  @override
  String get screenLearnSub => 'Teekaart, A0 kuni C1';

  @override
  String get screenPractice => 'Harjuta';

  @override
  String get screenPracticeSub => 'Kordamised, kaardid, mängud';

  @override
  String get screenWriting => 'Kirjutamine';

  @override
  String get screenWritingSub => 'Kirjuta ä ö ü ß-ga';

  @override
  String get screenCoach => 'Treener';

  @override
  String get screenCoachSub => 'Kirjuta või räägi';

  @override
  String get screenProgress => 'Edenemine';

  @override
  String get screenProgressSub => 'Oskused ja märgid';

  @override
  String get screenAccount => 'Konto';

  @override
  String get screenAccountSub => 'AI-võti, hääl, privaatsus';

  @override
  String get howEyebrow => 'Kuidas see töötab';

  @override
  String get howTitle => 'Sisselogimisest igapäevase sammuni.';

  @override
  String get step1Title => 'Logi sisse Google’iga';

  @override
  String get step1Body => 'Pole parooli, mida meelde jätta, pole jälgimist.';

  @override
  String get step2Title => 'Vaata tutvustust';

  @override
  String get step2Body =>
      'Viis lühikest lehte sellest, kuidas Sprichst töötab. Jäta vahele millal tahes.';

  @override
  String get step3Title => 'Vasta kolmele küsimusele';

  @override
  String get step3Body =>
      'Selgituskeel, su tase ja milleks sa saksa keelt vajad.';

  @override
  String get step4Title => 'Ava avaleht';

  @override
  String get step4Body =>
      'Su seeria, tasemenäidik, kolm igapäevast ülesannet ja üks soovitatud samm.';

  @override
  String get step5Title => 'Õpi, korda, räägi';

  @override
  String get step5Body =>
      'Tunnid, hajutatud kordamised, nõrkade oskuste harjutused, kirjutamine või treener.';

  @override
  String get step6Title => 'Vaata, kuidas see koguneb';

  @override
  String get step6Body =>
      'XP, seeriad, märgid ja oskused. Lõpeta tase hästi, et edasi liikuda.';

  @override
  String get aiEyebrow => 'AI-treener';

  @override
  String get aiTitle => 'Sina valid, kus AI töötab.';

  @override
  String get aiBody =>
      'Sprichstil pole AI-serverit. Treener vastab su telefonis ühenduseta või sinu võtmega otse rakendusest valitud teenusepakkujale. Midagi ei muutu ilma sinult küsimata.';

  @override
  String get aiProviderAny => 'Iga OpenAI-ühilduv server';

  @override
  String get aiOptPhoneTitle => 'Ainult see telefon';

  @override
  String get aiOptPhoneBody =>
      'Laadi mudel üks kord Wi-Fi kaudu alla. Seejärel töötab treener ühenduseta ja miski, mida kirjutad, ei lahku telefonist.';

  @override
  String get aiOptKeyTitle => 'Minu oma AI-võti';

  @override
  String get aiOptKeyBody =>
      'Tugevamad vastused su teenusepakkujalt. Võti jääb seadme turvalisse mällu ja seda ei sünkroonita kunagi.';

  @override
  String get aiOptAutoTitle => 'Automaatne';

  @override
  String get aiOptAutoBody =>
      'Vastab telefonis ja kasutab su võtit ainult selleks, mis pole veel alla laaditud.';

  @override
  String get privacyEyebrow => 'Privaatne algusest peale';

  @override
  String get privacyTitle => 'Su sõnad jäävad sinule.';

  @override
  String get privacyBody =>
      'Privaatsuspoliitika on kirjutatud lugemiseks, mitte asjade peitmiseks. See on lühiversioon.';

  @override
  String get privacyReadPolicy => 'Loe privaatsuspoliitikat';

  @override
  String get privacy1Title => 'Ei analüütikat, reklaame ega jälgimist';

  @override
  String get privacy1Body =>
      'Ei seansi salvestamist, ei reklaamiprofiile, ei kolmanda osapoole küpsiseid.';

  @override
  String get privacy2Title => 'Salvestatakse ainult õppimise edenemine';

  @override
  String get privacy2Body =>
      'See liigub sinuga seadmete vahel. Muud sinu kohta teadlikult ei koguta.';

  @override
  String get privacy3Title => 'Su häält ei säilitata kunagi';

  @override
  String get privacy3Body =>
      'Salvestised muudetakse tekstiks ja visatakse ära. Midagi ei kasutata millegi treenimiseks.';

  @override
  String get privacy4Title => 'Ekspordi või kustuta kõik rakenduses';

  @override
  String get privacy4Body => 'Account → Privacy & data. E-kirja pole vaja.';

  @override
  String get makerEyebrow => 'Kes on selle taga';

  @override
  String get makerQuote =>
      'Tahtsin saksa keele rakendust, mis õpetab päris kursuse põhjal, selgitab mu vigu ega jälgi mind õppimise ajal. Seega ehitasin Sprichsti.';

  @override
  String get makerRole => 'Sõltumatu arendaja, Sprichsti looja';

  @override
  String get makerCopyEmail => 'Kopeeri e-posti aadress';

  @override
  String get makerCopied => 'Kopeeritud';

  @override
  String get makerReport => 'Teata veast või jaga ideed';

  @override
  String get dlEyebrow => 'Laadi alla';

  @override
  String get dlTitle => 'Alusta täna oma esimese tunniga.';

  @override
  String get dlBody =>
      'Sprichst ilmub Androidile, iOS-ile, veebi ja macOS-ile.';

  @override
  String get dlSoon => 'Varsti tulekul';

  @override
  String get dlAvailable => 'Saadaval nüüd';

  @override
  String get dlAndroidBody => 'Google Play. Android-telefonid ja -tahvlid.';

  @override
  String get dlIosTitle => 'iPhone ja iPad';

  @override
  String get dlIosBody => 'App Store. iPhone ja iPad.';

  @override
  String get dlWebTitle => 'Veeb';

  @override
  String get dlWebBody =>
      'Mis tahes brauseris. Siin vajab treener sinu enda AI-võtit.';

  @override
  String get dlWebButton => 'Ava veebirakendus';

  @override
  String get dlMacBody => 'Macis, sama konto ja edenemisega.';

  @override
  String get sourceTitle => 'Huvitab, kuidas see on ehitatud?';

  @override
  String get sourceBody =>
      'Flutter, Firebase ja seadmes töötav AI, umbes 540 testiga.';

  @override
  String get sourceButton => 'Vaata koodi GitHubis';

  @override
  String get faqEyebrow => 'Küsimused';

  @override
  String get faqTitle => 'Hea teada';

  @override
  String get faq1Q => 'Kas mul on vaja AI-võtit?';

  @override
  String get faq1A =>
      'Ei. Laadi telefonis üks kord mudel alla jaotises Account → AI & voice ja treener töötab ühenduseta. Groqi, Gemini, OpenAI või muu teenusepakkuja võti annab tugevamaid vastuseid; Groqil, Geminil ja OpenRouteril on tasuta paketid. Brauseris seadmemudelid ei tööta, seega vajab veebiversioon treeneri jaoks sinu võtit.';

  @override
  String get faq2Q => 'Milliseid tasemeid ja eksameid see katab?';

  @override
  String get faq2A =>
      '48 õppetundi Pre-A1-st B2-ni, eksamirajad Goethe-Zertifikat A1, A2, B1 ja B2 ning TestDaF jaoks, lisaks proovieksamid.';

  @override
  String get faq3Q => 'Kas see töötab ühenduseta?';

  @override
  String get faq3A =>
      'Tunnid, salvestatud sõnad, kordamised ja su edenemine töötavad ühenduseta. Treener samuti, kui kasutad telefonis mudelit. Oma AI-võti ja sünkroonimine vajavad internetti.';

  @override
  String get faq4Q => 'Mis keeles saksa keelt selgitatakse?';

  @override
  String get faq4A => 'Valid alguses: inglise, hindi või telugu, või Muu.';

  @override
  String get faq5Q => 'Kas mu vestlusi kasutatakse AI treenimiseks?';

  @override
  String get faq5A =>
      'Sprichst seda ei tee. Telefonis jäävad need telefoni. Oma võtmega lähevad su sõnumid valitud teenusepakkujale sinu enda lepingu alusel. Sprichst ei saa neid kunagi.';

  @override
  String get faq6Q => 'Kas saan oma andmed kustutada?';

  @override
  String get faq6A =>
      'Jah. Ekspordi kõik JSON-ina või kustuta oma konto jaotises Account → Privacy & data.';

  @override
  String get faq7Q => 'Kas see on ligipääsetav?';

  @override
  String get faq7A =>
      'Hele ja tume teema on kontrollitud WCAG AA kontrasti suhtes, 48-pikslised puutealad, seadme tekstisuurust järgiv tekst ja animatsioonid, mis peatuvad valikuga Vähenda liikumist.';

  @override
  String get legalEyebrow => 'Õigusteave';

  @override
  String get legalTitle => 'Põhimõtted ja teated';

  @override
  String get legalBody => 'Iga dokumendi täistekst, samad, mis rakenduses.';

  @override
  String get legalPrivacy => 'Privaatsuspoliitika';

  @override
  String get legalPrivacySub => 'Mida töötleme, miks ja sinu õigused';

  @override
  String get legalTerms => 'Kasutustingimused';

  @override
  String get legalTermsSub => 'Sprichsti kasutamise leping';

  @override
  String get legalRights => 'Sinu õigused';

  @override
  String get legalRightsSub => 'Juurdepääs, eksport, kustutamine piirkonniti';

  @override
  String get legalCookies => 'Küpsised ja salvestus';

  @override
  String get legalCookiesSub => 'Ainult see, mida rakendus vajab';

  @override
  String get legalAi => 'AI läbipaistvus';

  @override
  String get legalAiSub => 'Kuidas treener töötab, ELi tehisintellekti määrus';

  @override
  String get legalDisclaimer => 'Lahtiütlus';

  @override
  String get legalDisclaimerSub => 'Õppeabi, mitte garantii';

  @override
  String get legalA11y => 'Ligipääsetavus';

  @override
  String get legalA11ySub => 'Eesmärk WCAG 2.2 AA ja mis on juba olemas';

  @override
  String get legalSecurity => 'Turvalisus';

  @override
  String get legalSecuritySub => 'Kuidas su andmeid kaitstakse';

  @override
  String get legalCopyright => 'Autoriõigus ja eemaldamine';

  @override
  String get legalCopyrightSub => 'DMCA ja DSA teated';

  @override
  String get legalThirdParty => 'Kolmandate osapoolte teated';

  @override
  String get legalThirdPartySub => 'Avatud lähtekoodi litsentsid';

  @override
  String get legalImpressum => 'Impressum';

  @override
  String get legalImpressumSub => 'Teenusepakkuja teave (DDG § 5)';

  @override
  String get legalEnglishOnly =>
      'See dokument on avaldatud inglise keeles; siduv on ingliskeelne versioon.';

  @override
  String get legalLoadError =>
      'Dokumenti ei õnnestunud laadida. Proovi hetke pärast uuesti.';

  @override
  String get close => 'Sulge';

  @override
  String get footerTagline =>
      'Õpi saksa keelt rääkides. Ei analüütikat, ei jälgimist, ei reklaame.';

  @override
  String get footerProduct => 'Toode';

  @override
  String get footerAbout => 'Teave';

  @override
  String get footerLegal => 'Õigusteave';

  @override
  String get footerScreens => 'Ekraanid';

  @override
  String get footerCopyright => '© 2026 Sripathi · Sprichst';
}
