import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../l10n/app_localizations.dart';
import 'legal.dart';
import 'sections/content.dart';
import 'sections/hero.dart';
import 'settings.dart';
import 'theme.dart';
import 'widgets.dart';

enum Anchor { top, why, features, screens, how, ai, privacy, maker, download, faq }

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  static const _navHeight = 76.0;
  final _scroll = ScrollController();
  final _keys = {for (final a in Anchor.values) a: GlobalKey()};

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _goTo(Anchor anchor) {
    if (anchor == Anchor.top) {
      _animate(0);
      return;
    }
    final ro = _keys[anchor]!.currentContext?.findRenderObject();
    if (ro == null) return;
    // The nav sits above the scroll view, so no offset for it is needed.
    final reveal = RenderAbstractViewport.of(ro).getOffsetToReveal(ro, 0).offset;
    _animate(reveal.clamp(0, _scroll.position.maxScrollExtent));
  }

  void _animate(double offset) {
    if (MediaQuery.disableAnimationsOf(context)) {
      _scroll.jumpTo(offset);
    } else {
      _scroll.animateTo(offset, duration: const Duration(milliseconds: 600), curve: Curves.easeInOutCubic);
    }
  }

  Widget _anchor(Anchor a, Widget child) => KeyedSubtree(key: _keys[a], child: child);

  /// Scroll offset at which the hero's bottom edge reaches the top of the
  /// viewport. The background rings stop moving there.
  double _heroEnd() {
    final ro = _keys[Anchor.top]!.currentContext?.findRenderObject();
    if (ro is! RenderBox || !ro.hasSize) return double.infinity;
    return RenderAbstractViewport.of(ro).getOffsetToReveal(ro, 0).offset + ro.size.height;
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Scaffold(
      // The rings paint behind everything, edge to edge including the safe-area insets.
      body: CustomPaint(
        painter: _RipplePainter(
          scroll: _scroll,
          stopAt: _heroEnd,
          color: p.lineStrong,
          still: MediaQuery.disableAnimationsOf(context),
        ),
        child: SafeArea(
          child: Column(children: [
            ListenableBuilder(
              listenable: _scroll,
              builder: (context, _) => SizedBox(
                height: _navHeight,
                child: _NavBar(onNavigate: _goTo, raised: _scroll.hasClients && _scroll.offset > 0),
              ),
            ),
            Expanded(
              child: Scrollbar(
                controller: _scroll,
                child: SingleChildScrollView(
                  controller: _scroll,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                    const _Strip(),
                    _anchor(Anchor.top, HeroSection(onDownload: () => _goTo(Anchor.download), onHow: () => _goTo(Anchor.how))),
                    const Reveal(child: ProvidersStrip()),
                    _anchor(Anchor.why, const Reveal(child: WhySection())),
                    _anchor(Anchor.features, const Reveal(child: FeaturesSection())),
                    _anchor(Anchor.screens, const Reveal(child: ScreensSection())),
                    _anchor(Anchor.how, const Reveal(child: JourneySection())),
                    _anchor(Anchor.ai, const Reveal(child: AiSection())),
                    _anchor(Anchor.privacy, const Reveal(child: PrivacySection())),
                    _anchor(Anchor.maker, const Reveal(child: MakerSection())),
                    _anchor(Anchor.download, const Reveal(child: DownloadSection())),
                    _anchor(Anchor.faq, const Reveal(child: FaqSection())),
                    const Reveal(child: LegalSection()),
                    Reveal(child: _Footer(onNavigate: _goTo)),
                  ]),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

/// Concentric ellipses behind the page, driven by scrolling through the hero.
/// Each ring is born small at the centre of the screen and grows as the page
/// scrolls; the largest fade out as they reach the corners while new ones
/// appear in the middle. Past the hero the rings hold still and fade to a
/// faint watermark, so they don't cut through text set on the page
/// background. Scrolling back up runs the cycle in reverse.
class _RipplePainter extends CustomPainter {
  _RipplePainter({required this.scroll, required this.stopAt, required this.color, required this.still}) : super(repaint: scroll);
  final ScrollController scroll;

  /// Scroll offset after which the rings stop moving.
  final double Function() stopAt;
  final Color color;

  /// Reduced motion: rings stay put while scrolling.
  final bool still;

  static const _rings = 5;

  /// Pixels of scrolling that move every ring out by one ring spacing.
  static const _scrollPerRing = 260.0;

  /// Ring strength in the hero, and once the page has scrolled past it.
  static const _heroAlpha = 0.45;
  static const _restAlpha = 0.12;

  /// Pixels of scrolling past the hero over which the rings fade down.
  static const _fadeDistance = 320.0;

  @override
  void paint(Canvas canvas, Size size) {
    final scrolled = scroll.hasClients ? scroll.offset : 0.0;
    final end = stopAt();
    final offset = still ? 0.0 : math.min(scrolled, end);
    final phase = offset / _scrollPerRing;
    // 0 in the hero, 1 once the page is a fade distance past it.
    final past = ((scrolled - end) / _fadeDistance).clamp(0.0, 1.0);
    final strength = _heroAlpha + (_restAlpha - _heroAlpha) * past;
    final centre = size.center(Offset.zero);
    // The outermost ring passes through the screen corners, so its shape
    // follows the screen's proportions.
    final maxRx = size.width / math.sqrt2;
    final maxRy = size.height / math.sqrt2;
    final stroke = Paint()..style = PaintingStyle.stroke;
    for (var i = 0; i < _rings; i++) {
      // 0 = just born at the centre, 1 = gone past the corners.
      final t = ((i + phase) / _rings) % 1.0;
      final fadeIn = (t / 0.12).clamp(0.0, 1.0);
      final fadeOut = ((1 - t) / 0.35).clamp(0.0, 1.0);
      final alpha = strength * fadeIn * fadeOut;
      if (alpha <= 0) continue;
      stroke
        ..color = color.withValues(alpha: alpha)
        // Outer rings are thicker in the hero; past it every ring is a hairline.
        ..strokeWidth = 1 + t * (1 - past);
      canvas.drawOval(Rect.fromCenter(center: centre, width: 2 * maxRx * t, height: 2 * maxRy * t), stroke);
    }
  }

  @override
  bool shouldRepaint(_RipplePainter old) => old.scroll != scroll || old.stopAt != stopAt || old.color != color || old.still != still;
}

class _Strip extends StatelessWidget {
  const _Strip();

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final l = AppLocalizations.of(context);
    final narrow = MediaQuery.sizeOf(context).width <= Breakpoints.narrow;
    final style = TextStyle(fontSize: 13, color: p.muted);
    return Container(
      decoration: BoxDecoration(color: p.surface, border: Border(bottom: BorderSide(color: p.line))),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ContentWidth(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 32,
          runSpacing: 8,
          children: [
            Row(mainAxisSize: MainAxisSize.min, children: [
              Container(width: 6, height: 6, decoration: BoxDecoration(color: p.coral, shape: BoxShape.circle)),
              const SizedBox(width: 8),
              Flexible(child: Text(l.stripNoTracking, style: style)),
            ]),
            Text(l.stripLevels, style: style),
            if (!narrow) Text(l.stripPlatforms, style: style),
          ],
        ),
      ),
    );
  }
}

class _NavBar extends StatelessWidget {
  const _NavBar({required this.onNavigate, required this.raised});
  final void Function(Anchor) onNavigate;
  final bool raised;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final l = AppLocalizations.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final links = [
      (Anchor.why, l.navWhy),
      (Anchor.features, l.navFeatures),
      (Anchor.ai, l.navAi),
      (Anchor.privacy, l.navPrivacy),
      (Anchor.maker, l.navMaker),
      (Anchor.faq, l.navFaq),
    ];
    const linkStyle = TextStyle(fontFamily: 'Figtree', fontSize: 15, fontWeight: FontWeight.w500);
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: _navBody(context, p, l, width, links, linkStyle),
      ),
    );
  }

  Widget _navBody(BuildContext context, Palette p, AppLocalizations l, double width, List<(Anchor, String)> links, TextStyle linkStyle) {
    return Container(
      decoration: BoxDecoration(
        color: p.canvas.withValues(alpha: 0.88),
        border: Border(bottom: BorderSide(color: raised ? p.line : Colors.transparent)),
      ),
      child: ContentWidth(
        child: Row(children: [
          BrandLockup(onTap: () => onNavigate(Anchor.top)),
          const SizedBox(width: 24),
          // Show the section links only when every one of them fits; otherwise
          // they move into the menu sheet.
          Expanded(
            child: LayoutBuilder(builder: (context, c) {
              final scale = MediaQuery.textScalerOf(context);
              var needed = 0.0;
              for (final (_, label) in links) {
                final tp = TextPainter(text: TextSpan(text: label, style: linkStyle), textDirection: Directionality.of(context), textScaler: scale)
                  ..layout();
                needed += tp.width + 30;
                tp.dispose();
              }
              if (width <= Breakpoints.wide || needed > c.maxWidth) {
                return Align(alignment: Alignment.centerRight, child: _MenuButton(links: links, onNavigate: onNavigate));
              }
              return Semantics(
                container: true,
                explicitChildNodes: true,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  for (final (anchor, label) in links)
                    TextButton(
                      onPressed: () => onNavigate(anchor),
                      style: TextButton.styleFrom(
                        foregroundColor: p.ink,
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        textStyle: linkStyle,
                      ),
                      child: Text(label),
                    ),
                ]),
              );
            }),
          ),
          const SizedBox(width: 8),
          const LanguageMenu(),
          if (width > Breakpoints.narrow) ...[const SizedBox(width: 8), const _ThemeButton()],
          if (width > Breakpoints.narrow) ...[
            const SizedBox(width: 8),
            PillButton(label: l.navDownload, trailing: '→', small: true, onPressed: () => onNavigate(Anchor.download)),
          ],
        ]),
      ),
    );
  }
}

/// Picks the page language. Each option is written in its own language.
class LanguageMenu extends StatelessWidget {
  const LanguageMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final settings = SettingsScope.of(context);
    final current = Localizations.localeOf(context);
    return PopupMenuButton<Locale>(
      tooltip: AppLocalizations.of(context).languageLabel,
      initialValue: current,
      onSelected: settings.setLocale,
      color: p.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: p.line)),
      position: PopupMenuPosition.under,
      itemBuilder: (context) => [
        for (final locale in siteLanguages)
          PopupMenuItem(
            value: locale,
            child: Row(children: [
              SizedBox(
                width: 24,
                child: locale == current ? Icon(Icons.check, size: 18, color: p.accent) : null,
              ),
              const SizedBox(width: 8),
              Text(lookupAppLocalizations(locale).languageName,
                  locale: locale,
                  style: TextStyle(fontWeight: locale == current ? FontWeight.w700 : FontWeight.w500, color: p.ink)),
            ]),
          ),
      ],
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(999), border: Border.all(color: p.lineStrong)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(Icons.translate, size: 18, color: p.ink),
          const SizedBox(width: 6),
          Text(current.languageCode.toUpperCase(), style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: p.ink)),
          Icon(Icons.expand_more, size: 18, color: p.ink),
        ]),
      ),
    );
  }
}

class _ThemeButton extends StatelessWidget {
  const _ThemeButton();

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final brightness = Theme.of(context).brightness;
    return IconButton(
      tooltip: AppLocalizations.of(context).themeToggle,
      onPressed: () => SettingsScope.of(context).toggleTheme(brightness),
      icon: Icon(brightness == Brightness.dark ? Icons.light_mode_outlined : Icons.contrast, size: 20, color: p.ink),
      style: IconButton.styleFrom(side: BorderSide(color: p.lineStrong), fixedSize: const Size(40, 40), minimumSize: const Size(40, 40)),
    );
  }
}

/// Section links for narrow screens, in a bottom sheet.
class _MenuButton extends StatelessWidget {
  const _MenuButton({required this.links, required this.onNavigate});
  final List<(Anchor, String)> links;
  final void Function(Anchor) onNavigate;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final l = AppLocalizations.of(context);
    final narrow = MediaQuery.sizeOf(context).width <= Breakpoints.narrow;
    return IconButton(
      tooltip: l.navMenu,
      icon: Icon(Icons.menu, color: p.ink),
      style: IconButton.styleFrom(side: BorderSide(color: p.lineStrong), fixedSize: const Size(40, 40), minimumSize: const Size(40, 40)),
      onPressed: () => showModalBottomSheet<void>(
        context: context,
        backgroundColor: p.surface,
        showDragHandle: true,
        builder: (sheet) => SafeArea(
          child: ListView(shrinkWrap: true, padding: const EdgeInsets.only(bottom: 16), children: [
            for (final (anchor, label) in [...links, (Anchor.download, l.navDownload)])
              ListTile(
                title: Text(label, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: p.ink)),
                onTap: () {
                  Navigator.of(sheet).pop();
                  onNavigate(anchor);
                },
              ),
            if (narrow)
              ListTile(
                leading: Icon(Theme.of(context).brightness == Brightness.dark ? Icons.light_mode_outlined : Icons.contrast, color: p.ink),
                title: Text(l.themeToggle, style: TextStyle(fontSize: 17, color: p.ink)),
                onTap: () {
                  SettingsScope.of(context).toggleTheme(Theme.of(context).brightness);
                  Navigator.of(sheet).pop();
                },
              ),
          ]),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer({required this.onNavigate});
  final void Function(Anchor) onNavigate;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final l = AppLocalizations.of(context);
    final twoCol = MediaQuery.sizeOf(context).width <= Breakpoints.medium;

    Widget column(String heading, List<(String, VoidCallback)> items) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.isIndic ? heading : context.upper(heading),
                style: TextStyle(fontSize: 13, letterSpacing: context.isIndic ? 0 : 1, fontWeight: FontWeight.w500, color: p.muted)),
            const SizedBox(height: 12),
            for (final (label, onTap) in items)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(6),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(label, style: TextStyle(fontSize: 15, color: p.ink)),
                  ),
                ),
              ),
          ],
        );

    final brand = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      BrandLockup(onTap: () => onNavigate(Anchor.top)),
      const SizedBox(height: 14),
      ConstrainedBox(constraints: const BoxConstraints(maxWidth: 300), child: Text(l.footerTagline, style: context.body(16, color: p.muted))),
    ]);
    final product = column(l.footerProduct, [
      (l.navFeatures, () => onNavigate(Anchor.features)),
      (l.footerScreens, () => onNavigate(Anchor.screens)),
      (l.navAi, () => onNavigate(Anchor.ai)),
      (l.navDownload, () => onNavigate(Anchor.download)),
    ]);
    final about = column(l.footerAbout, [
      (l.navMaker, () => onNavigate(Anchor.maker)),
      (l.navFaq, () => onNavigate(Anchor.faq)),
      ('GitHub', () => openUrl(repoUrl)),
    ]);
    final legal = column(l.footerLegal, [
      for (final doc in [LegalDoc.privacy, LegalDoc.terms, LegalDoc.cookies, LegalDoc.impressum]) (doc.title(l), () => showLegalDoc(context, doc)),
    ]);

    return Container(
      decoration: BoxDecoration(color: p.surface, border: Border(top: BorderSide(color: p.line))),
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 48),
          child: ContentWidth(
            child: twoCol
                ? EqualGrid(columns: 2, gap: 32, children: [brand, product, about, legal])
                : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(flex: 14, child: brand),
                    const SizedBox(width: 32),
                    Expanded(flex: 10, child: product),
                    const SizedBox(width: 32),
                    Expanded(flex: 10, child: about),
                    const SizedBox(width: 32),
                    Expanded(flex: 10, child: legal),
                  ]),
          ),
        ),
        Container(
          decoration: BoxDecoration(border: Border(top: BorderSide(color: p.line))),
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ContentWidth(
            child: Wrap(
              alignment: WrapAlignment.spaceBetween,
              spacing: 12,
              runSpacing: 12,
              children: [
                Text(l.footerCopyright, style: TextStyle(fontSize: 13.5, color: p.muted)),
                Text('Viel Spaß beim Lernen.', locale: const Locale('de'), style: TextStyle(fontSize: 13.5, color: p.muted)),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
