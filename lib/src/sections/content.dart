import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import '../../l10n/app_localizations.dart';
import '../legal.dart';
import '../theme.dart';
import '../widgets.dart';

const _providers = ['Groq', 'Gemini', 'OpenAI', 'Claude', 'Grok', 'Mistral', 'DeepSeek', 'OpenRouter'];

int _cols(BuildContext context, {required int wide, required int medium}) {
  final w = MediaQuery.sizeOf(context).width;
  if (w <= Breakpoints.narrow) return 1;
  if (w <= Breakpoints.wide) return medium;
  return wide;
}

// ───────────────────────────── providers strip

class ProvidersStrip extends StatelessWidget {
  const ProvidersStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      decoration: BoxDecoration(color: p.surface, border: Border.symmetric(horizontal: BorderSide(color: p.line))),
      padding: const EdgeInsets.symmetric(vertical: 22),
      child: ContentWidth(
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 40,
          runSpacing: 12,
          children: [
            Text(AppLocalizations.of(context).worksLead, textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: p.muted)),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 28,
              runSpacing: 8,
              children: [
                for (final name in _providers)
                  Text(name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: -0.2, color: p.ink.withValues(alpha: 0.72))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ───────────────────────────── why + numbers

class WhySection extends StatelessWidget {
  const WhySection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final oneCol = MediaQuery.sizeOf(context).width <= Breakpoints.medium;
    final cards = [
      _WhyCard(motion: 'tour_lessons', eyebrow: l.whyLearnEyebrow, title: l.whyLearnTitle, body: l.whyLearnBody),
      _WhyCard(motion: 'tour_coach', eyebrow: l.whyTalkEyebrow, title: l.whyTalkTitle, body: l.whyTalkBody),
      _WhyCard(motion: 'tour_review', eyebrow: l.whyRememberEyebrow, title: l.whyRememberTitle, body: l.whyRememberBody),
    ];
    return Section(
      child: ContentWidth(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SectionHead(eyebrow: l.whyEyebrow, title: l.whyTitle, body: l.whyBody),
          if (oneCol)
            for (final c in cards) Padding(padding: const EdgeInsets.only(bottom: 20), child: Reveal(child: c))
          else
            EqualGrid(columns: 3, reveal: true, children: cards),
          SizedBox(height: oneCol ? 0 : 20),
          const _NumbersBand(),
        ]),
      ),
    );
  }
}

class _WhyCard extends StatefulWidget {
  const _WhyCard({required this.motion, required this.eyebrow, required this.title, required this.body});
  final String motion, eyebrow, title, body;

  @override
  State<_WhyCard> createState() => _WhyCardState();
}

/// The animation loops while the card is on screen and pauses while it's
/// scrolled out of view.
class _WhyCardState extends State<_WhyCard> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this);
  ScrollPosition? _position;
  var _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context, axis: Axis.vertical)?.position;
    if (position != _position) {
      _position?.removeListener(_sync);
      _position = position?..addListener(_sync);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
  }

  @override
  void dispose() {
    _position?.removeListener(_sync);
    _controller.dispose();
    super.dispose();
  }

  void _onLoaded(LottieComposition composition) {
    _controller.duration = composition.duration;
    _loaded = true;
    _sync();
  }

  void _sync() {
    if (!mounted || !_loaded) return;
    if (MediaQuery.disableAnimationsOf(context)) {
      // Reduced motion: hold the finished frame.
      _controller.value = 1;
      return;
    }
    if (_onScreen()) {
      if (!_controller.isAnimating) _controller.repeat();
    } else if (_controller.isAnimating) {
      _controller.stop();
    }
  }

  bool _onScreen() {
    final box = context.findRenderObject();
    final viewport = Scrollable.maybeOf(context, axis: Axis.vertical)?.context.findRenderObject();
    if (box is! RenderBox || viewport is! RenderBox || !box.attached || !viewport.attached) return false;
    final top = box.localToGlobal(Offset.zero).dy - viewport.localToGlobal(Offset.zero).dy;
    return top < viewport.size.height && top + box.size.height > 0;
  }

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    return SurfaceCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          height: 180,
          decoration: BoxDecoration(color: p.canvas, borderRadius: BorderRadius.circular(14)),
          alignment: Alignment.center,
          child: ExcludeSemantics(
            child: Lottie.asset(
              'assets/motion/${widget.motion}_${dark ? 'dark' : 'light'}.json',
              key: ValueKey(dark),
              controller: _controller,
              onLoaded: _onLoaded,
              width: 240,
              height: 180,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Eyebrow(widget.eyebrow),
        const SizedBox(height: 12),
        Text(widget.title, style: context.heading(24, height: 1.2)),
        const SizedBox(height: 12),
        Text(widget.body, style: context.body(16, color: p.muted)),
      ]),
    );
  }
}

class _NumbersBand extends StatelessWidget {
  const _NumbersBand();

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final l = AppLocalizations.of(context);
    final cols = MediaQuery.sizeOf(context).width <= Breakpoints.medium ? 2 : 4;
    final stats = [('48', l.statLessons), ('308', l.statWords), ('13', l.statDialogues), ('05', l.statGames)];
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(color: p.panel, borderRadius: BorderRadius.circular(28)),
      child: Stack(children: [
        Positioned(right: -60, top: -60, child: CustomPaint(size: const Size(220, 220), painter: _HatchPainter(p.onPanelMuted))),
        Padding(
          padding: EdgeInsets.all(fluid(context, 28, 4, 48)),
          child: EqualGrid(
            columns: cols,
            gap: 24,
            reveal: true,
            children: [
              for (final (n, label) in stats)
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(n,
                      style: TextStyle(
                        fontSize: fluid(context, 48, 6, 80),
                        fontWeight: FontWeight.w300,
                        letterSpacing: -2,
                        height: 1,
                        color: p.onPanel,
                        fontFeatures: const [FontFeature.tabularFigures()],
                      )),
                  const SizedBox(height: 4),
                  Text(label, style: context.body(15, color: p.onPanelMuted)),
                ]),
            ],
          ),
        ),
      ]),
    );
  }
}

/// Zig-zag hatching clipped to a circle, as in the original band.
class _HatchPainter extends CustomPainter {
  _HatchPainter(this.color);
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.width / 2;
    canvas.save();
    canvas.clipPath(Path()..addOval(Offset.zero & size));
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.7
      ..color = color.withValues(alpha: 0.6);
    final unit = size.width / 100 * 8;
    final h = size.width / 100 * 6;
    for (var y = 0.0; y < size.height + h; y += h) {
      final path = Path()..moveTo(0, y + h * 0.66);
      for (var x = 0.0; x < size.width + unit; x += unit) {
        path
          ..lineTo(x + unit * 0.25, y + h * 0.16)
          ..lineTo(x + unit * 0.5, y + h * 0.66)
          ..lineTo(x + unit * 0.75, y + h * 0.16)
          ..lineTo(x + unit, y + h * 0.66);
      }
      canvas.drawPath(path, paint);
    }
    canvas.restore();
    assert(r > 0);
  }

  @override
  bool shouldRepaint(_HatchPainter old) => old.color != color;
}

// ───────────────────────────── features

class FeaturesSection extends StatefulWidget {
  const FeaturesSection({super.key});

  @override
  State<FeaturesSection> createState() => _FeaturesSectionState();
}

class _FeaturesSectionState extends State<FeaturesSection> {
  final _gridKey = GlobalKey();
  var _expanded = false;

  void _toggle() {
    setState(() => _expanded = !_expanded);
    if (!_expanded) {
      // Collapsing removes everything below the first tiles; if the reader had
      // scrolled down the list, bring them back to the top of the grid.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final grid = _gridKey.currentContext;
        if (grid == null || !grid.mounted) return;
        Scrollable.ensureVisible(
          grid,
          duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
          alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = Palette.of(context);
    final cols = _cols(context, wide: 3, medium: 2);
    final features = <(IconData, String, String, List<String>)>[
      (Icons.menu_book_outlined, l.featCurriculumTitle, l.featCurriculumBody, ['Pre-A1', 'A1', 'A2', 'B1', 'B2']),
      (Icons.assignment_outlined, l.featExamsTitle, l.featExamsBody, ['Goethe', 'TestDaF']),
      (Icons.chat_bubble_outline, l.featCoachTitle, l.featCoachBody, const []),
      (Icons.mic_none, l.featVoiceTitle, l.featVoiceBody, const []),
      (Icons.keyboard_outlined, l.featWritingTitle, l.featWritingBody, const []),
      (Icons.style_outlined, l.featCardsTitle, l.featCardsBody, const []),
      (Icons.sports_esports_outlined, l.featGamesTitle, l.featGamesBody, ['Artikel-Rausch', 'Memory', 'Buchstabensalat', 'Wortle', 'Gespräch']),
      (Icons.route_outlined, l.featPlannerTitle, l.featPlannerBody, const []),
      (Icons.star_outline, l.featStreaksTitle, l.featStreaksBody, const []),
      (Icons.bar_chart, l.featProgressTitle, l.featProgressBody,
          [l.skillVocabulary, l.skillGrammar, l.skillReading, l.skillListening, l.skillWriting, l.skillSpeaking]),
      (Icons.wifi_off_outlined, l.featOfflineTitle, l.featOfflineBody, const []),
      (Icons.sync, l.featSyncTitle, l.featSyncBody, const []),
      (Icons.language, l.featLanguageTitle, l.featLanguageBody, const []),
      (Icons.contrast, l.featA11yTitle, l.featA11yBody, const []),
      (Icons.verified_user_outlined, l.featPrivateTitle, l.featPrivateBody, const []),
    ];
    // Collapsed, show whole rows only: one row of three, two rows of two, or three stacked.
    final shown = _expanded ? features.length : (cols == 2 ? 4 : 3);
    return Section(
      top: false,
      child: ContentWidth(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SectionHead(eyebrow: l.featEyebrow, title: l.featTitle, body: l.featBody),
          AnimatedSize(
            key: _gridKey,
            duration: MediaQuery.disableAnimationsOf(context) ? Duration.zero : const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            alignment: Alignment.topCenter,
            child: EqualGrid(
              columns: cols,
              gap: 12,
              reveal: true,
              children: [
                for (final (icon, title, body, tags) in features.take(shown))
                  SurfaceCard(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      IconBadge(icon, bg: p.accentSoft, fg: p.accent),
                      const SizedBox(height: 10),
                      Semantics(header: true, child: Text(title, style: context.heading(20, weight: FontWeight.w600, height: 1.25, tracking: -0.01))),
                      const SizedBox(height: 10),
                      Text(body, style: context.body(15.5, color: p.muted)),
                      if (tags.isNotEmpty) ...[
                        const SizedBox(height: 10),
                        Wrap(spacing: 6, runSpacing: 6, children: [for (final t in tags) Tag(t)]),
                      ],
                    ]),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Center(
            child: PillButton(
              label: _expanded ? l.featLess : l.featMore(features.length - shown),
              trailing: _expanded ? '↑' : '↓',
              kind: PillKind.ghost,
              small: true,
              onPressed: _toggle,
            ),
          ),
        ]),
      ),
    );
  }
}

// ───────────────────────────── screens

class ScreensSection extends StatefulWidget {
  const ScreensSection({super.key});

  @override
  State<ScreensSection> createState() => _ScreensSectionState();
}

class _ScreensSectionState extends State<ScreensSection> {
  final _scroll = ScrollController();

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = Palette.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final gutter = fluid(context, 16, 4, 48);
    // (light asset, has dark variant, title, caption)
    final screens = [
      ('sign-in', false, l.screenSignIn, l.screenSignInSub),
      ('welcome', false, l.screenWelcome, l.screenWelcomeSub),
      ('tour-lessons', false, l.screenTour, l.screenTourSub),
      ('tour-private', false, l.screenPrivate, l.screenPrivateSub),
      ('goal', false, l.screenGoal, l.screenGoalSub),
      ('home', true, l.screenHome, l.screenHomeSub),
      ('learn', false, l.screenLearn, l.screenLearnSub),
      ('practice', true, l.screenPractice, l.screenPracticeSub),
      ('writing', true, l.screenWriting, l.screenWritingSub),
      ('coach', true, l.screenCoach, l.screenCoachSub),
      ('progress', false, l.screenProgress, l.screenProgressSub),
      ('account', false, l.screenAccount, l.screenAccountSub),
    ];
    const cardWidth = 220.0;
    return Section(
      top: false,
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        ContentWidth(child: SectionHead(eyebrow: l.screensEyebrow, title: l.screensTitle, body: l.screensBody)),
        SizedBox(
          height: cardWidth * 779 / 360 + 96,
          child: Scrollbar(
            controller: _scroll,
            child: ListView.separated(
              controller: _scroll,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.fromLTRB(gutter, 8, gutter, 28),
              itemCount: screens.length,
              separatorBuilder: (_, _) => const SizedBox(width: 24),
              itemBuilder: (context, i) {
                final (name, hasDark, title, caption) = screens[i];
                final asset = 'assets/screens/$name${hasDark && dark ? '-dark' : ''}.png';
                return Reveal(
                  child: SizedBox(
                    width: cardWidth,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26),
                          border: Border.all(color: p.line),
                          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: dark ? 0.6 : 0.25), blurRadius: 40, offset: const Offset(0, 20), spreadRadius: -20)],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(26),
                          child: AspectRatio(
                            aspectRatio: 360 / 779,
                            child: Image.asset(asset, fit: BoxFit.cover, semanticLabel: title),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: p.ink)),
                      Text(caption, maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14, color: p.muted)),
                    ]),
                  ),
                );
              },
            ),
          ),
        ),
      ]),
    );
  }
}

// ───────────────────────────── how it works

class JourneySection extends StatelessWidget {
  const JourneySection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = Palette.of(context);
    final cols = _cols(context, wide: 6, medium: 3);
    final steps = [
      (l.step1Title, l.step1Body),
      (l.step2Title, l.step2Body),
      (l.step3Title, l.step3Body),
      (l.step4Title, l.step4Body),
      (l.step5Title, l.step5Body),
      (l.step6Title, l.step6Body),
    ];
    return Section(
      top: false,
      child: ContentWidth(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SectionHead(eyebrow: l.howEyebrow, title: l.howTitle),
          EqualGrid(
            columns: cols,
            gap: 12,
            reveal: true,
            children: [
              for (var i = 0; i < steps.length; i++)
                SurfaceCard(
                  padding: const EdgeInsets.all(20),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text((i + 1).toString().padLeft(2, '0'),
                        style: TextStyle(fontSize: 40, fontWeight: FontWeight.w300, letterSpacing: -1.2, height: 1, color: p.coral)),
                    const SizedBox(height: 8),
                    Text(steps[i].$1, style: context.body(17, weight: FontWeight.w700, height: 1.3)),
                    const SizedBox(height: 8),
                    Text(steps[i].$2, style: context.body(14.5, color: p.muted)),
                  ]),
                ),
            ],
          ),
        ]),
      ),
    );
  }
}

// ───────────────────────────── AI coach

class AiSection extends StatelessWidget {
  const AiSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = Palette.of(context);
    final stacked = MediaQuery.sizeOf(context).width <= Breakpoints.medium;
    final providers = ['Groq', 'Google Gemini', 'OpenAI', 'Anthropic Claude', 'xAI Grok', 'Mistral', 'DeepSeek', 'OpenRouter', l.aiProviderAny];
    final left = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionHead(eyebrow: l.aiEyebrow, title: l.aiTitle, body: l.aiBody, bottom: 0),
      const SizedBox(height: 20),
      Wrap(spacing: 8, runSpacing: 8, children: [
        for (final name in providers)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(99), border: Border.all(color: p.lineStrong)),
            child: Text(name, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: p.ink)),
          ),
      ]),
    ]);
    final options = [
      (Icons.smartphone, l.aiOptPhoneTitle, l.aiOptPhoneBody, true),
      (Icons.key_outlined, l.aiOptKeyTitle, l.aiOptKeyBody, false),
      (Icons.sync, l.aiOptAutoTitle, l.aiOptAutoBody, false),
    ];
    final right = Column(children: [
      for (final (icon, title, body, on) in options)
        Reveal(
          child: Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: SurfaceCard(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            radius: 16,
            borderWidth: 1.5,
            color: on ? p.accentSoft : p.surface,
            borderColor: on ? p.accent : p.line,
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(padding: const EdgeInsets.only(top: 2), child: Icon(icon, size: 22, color: p.ink)),
              const SizedBox(width: 16),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(title, style: context.body(17, weight: FontWeight.w700, height: 1.3)),
                  const SizedBox(height: 4),
                  Text(body, style: context.body(15, color: p.muted)),
                ]),
              ),
            ]),
          ),
        )),
    ]);
    return Section(
      top: false,
      child: ContentWidth(
        child: stacked
            ? Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [left, const SizedBox(height: 40), right])
            : Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Expanded(flex: 11, child: left),
                const SizedBox(width: 40),
                Expanded(flex: 10, child: right),
              ]),
      ),
    );
  }
}

// ───────────────────────────── privacy

class PrivacySection extends StatelessWidget {
  const PrivacySection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = Palette.of(context);
    final stacked = MediaQuery.sizeOf(context).width <= Breakpoints.medium;
    final points = [
      (l.privacy1Title, l.privacy1Body),
      (l.privacy2Title, l.privacy2Body),
      (l.privacy3Title, l.privacy3Body),
      (l.privacy4Title, l.privacy4Body),
    ];
    final head = SectionHead(
      eyebrow: l.privacyEyebrow,
      title: l.privacyTitle,
      body: l.privacyBody,
      bottom: 0,
      onPanel: true,
      action: PillButton(label: l.privacyReadPolicy, kind: PillKind.ghost, small: true, onPressed: () => showLegalDoc(context, LegalDoc.privacy)),
    );
    final list = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (final (title, body) in points)
        Reveal(
          child: Padding(
          padding: const EdgeInsets.only(bottom: 18),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(padding: EdgeInsets.only(top: 2), child: Icon(Icons.check, color: Color(0xFFF2877C), size: 22)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: context.body(16, weight: FontWeight.w600, color: p.onPanel)),
                Text(body, style: context.body(16, color: p.onPanelMuted)),
              ]),
            ),
          ]),
        )),
    ]);
    return Section(
      top: false,
      child: ContentWidth(
        child: Container(
          padding: EdgeInsets.all(fluid(context, 28, 5, 64)),
          decoration: BoxDecoration(color: p.panel, borderRadius: BorderRadius.circular(28)),
          child: stacked
              ? Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [head, const SizedBox(height: 48), list])
              : Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(flex: 10, child: head),
                  const SizedBox(width: 48),
                  Expanded(flex: 12, child: list),
                ]),
        ),
      ),
    );
  }
}

// ───────────────────────────── maker

class MakerSection extends StatefulWidget {
  const MakerSection({super.key});

  @override
  State<MakerSection> createState() => _MakerSectionState();
}

class _MakerSectionState extends State<MakerSection> {
  bool _copied = false;

  Future<void> _copy() async {
    await Clipboard.setData(const ClipboardData(text: contactEmail));
    if (!mounted) return;
    setState(() => _copied = true);
    SemanticsService.sendAnnouncement(View.of(context), AppLocalizations.of(context).makerCopied, Directionality.of(context));
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = Palette.of(context);
    final stacked = MediaQuery.sizeOf(context).width <= Breakpoints.medium;
    final portrait = ExcludeSemantics(
      child: SizedBox.square(
        dimension: 300,
        child: Stack(children: [
          Positioned(right: 24, top: 24, child: Container(width: 210, height: 210, decoration: BoxDecoration(color: p.coral, shape: BoxShape.circle))),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(width: 216, height: 216, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: p.lineStrong))),
          ),
          Positioned(
            left: 42,
            top: 66,
            child: Container(
              width: 168,
              height: 168,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: p.panel,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.35), blurRadius: 60, offset: const Offset(0, 30), spreadRadius: -24)],
              ),
              child: Text('S', style: TextStyle(fontSize: 72, fontWeight: FontWeight.w300, letterSpacing: -3, color: p.onPanel)),
            ),
          ),
        ]),
      ),
    );
    final text = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Eyebrow(l.makerEyebrow),
      const SizedBox(height: 14),
      ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560),
        child: Text(l.makerQuote, style: context.heading(fluid(context, 22, 2.4, 30), weight: FontWeight.w400, height: 1.3, tracking: -0.015)),
      ),
      const SizedBox(height: 20),
      const Text('Sripathi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
      Text(l.makerRole, style: context.body(16, color: p.muted)),
      const SizedBox(height: 24),
      Wrap(spacing: 10, runSpacing: 10, children: [
        LinkChip(
          icon: Icons.mail_outline,
          label: contactEmail,
          tooltip: l.makerCopyEmail,
          onTap: _copy,
          trailing: _copied ? Text(l.makerCopied, style: TextStyle(fontSize: 15, color: p.muted)) : null,
        ),
        LinkChip(icon: Icons.code, label: '@Sripathiyadav', onTap: () => openUrl(profileUrl)),
        LinkChip(icon: Icons.public, label: 'sripathiyadavportfolio.netlify.app', onTap: () => openUrl(portfolioUrl)),
        LinkChip(label: l.makerReport, onTap: () => openUrl(issuesUrl)),
      ]),
    ]);
    return Section(
      top: false,
      child: ContentWidth(
        child: stacked
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                FittedBox(child: portrait),
                const SizedBox(height: 32),
                text,
              ])
            : Row(children: [portrait, SizedBox(width: fluid(context, 32, 5, 72)), Expanded(child: text)]),
      ),
    );
  }
}

// ───────────────────────────── download

class DownloadSection extends StatelessWidget {
  const DownloadSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = Palette.of(context);
    final cols = _cols(context, wide: 4, medium: 2);
    final targets = [
      ('Android', l.dlAndroidBody, 'Google Play'),
      (l.dlIosTitle, l.dlIosBody, 'App Store'),
      (l.dlWebTitle, l.dlWebBody, l.dlWebButton),
      ('macOS', l.dlMacBody, 'Mac App Store'),
    ];
    return Section(
      top: false,
      child: ContentWidth(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SectionHead(eyebrow: l.dlEyebrow, title: l.dlTitle, body: l.dlBody, center: true),
          EqualGrid(
            columns: cols,
            gap: 16,
            reveal: true,
            children: [
              for (final (title, body, button) in targets)
                SurfaceCard(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: p.sunken, borderRadius: BorderRadius.circular(99)),
                      child: Text(context.isIndic ? l.dlSoon : context.upper(l.dlSoon),
                          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700, letterSpacing: 0.5, color: p.muted)),
                    ),
                    const SizedBox(height: 10),
                    Text(title, style: context.heading(20, weight: FontWeight.w600, height: 1.25, tracking: 0)),
                    const SizedBox(height: 10),
                    Text(body, style: context.body(16, color: p.muted)),
                    const Spacer(),
                    const SizedBox(height: 16),
                    PillButton(label: button, kind: PillKind.disabled, small: true),
                  ]),
                ),
            ],
          ),
          const SizedBox(height: 16),
          DashedBorder(
            color: p.lineStrong,
            radius: 20,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
              child: Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 16,
                runSpacing: 16,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(text: '${l.sourceTitle} ', style: const TextStyle(fontWeight: FontWeight.w700)),
                    TextSpan(text: l.sourceBody, style: TextStyle(color: p.muted)),
                  ]), style: context.body(16)),
                  PillButton(label: l.sourceButton, trailing: '↗', kind: PillKind.ghost, small: true, onPressed: () => openUrl(repoUrl)),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class DashedBorder extends StatelessWidget {
  const DashedBorder({super.key, required this.child, required this.color, this.radius = 20});
  final Widget child;
  final Color color;
  final double radius;

  @override
  Widget build(BuildContext context) => CustomPaint(painter: _DashPainter(color, radius), child: child);
}

class _DashPainter extends CustomPainter {
  _DashPainter(this.color, this.radius);
  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..addRRect(RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)));
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (final metric in path.computeMetrics()) {
      for (var d = 0.0; d < metric.length; d += 9) {
        canvas.drawPath(metric.extractPath(d, d + 4.5), paint);
      }
    }
  }

  @override
  bool shouldRepaint(_DashPainter old) => old.color != color;
}

// ───────────────────────────── FAQ

class FaqSection extends StatelessWidget {
  const FaqSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = Palette.of(context);
    final qa = [
      (l.faq1Q, l.faq1A),
      (l.faq2Q, l.faq2A),
      (l.faq3Q, l.faq3A),
      (l.faq4Q, l.faq4A),
      (l.faq5Q, l.faq5A),
      (l.faq6Q, l.faq6A),
      (l.faq7Q, l.faq7A),
    ];
    return Section(
      top: false,
      child: ContentWidth(
        child: Column(children: [
          SectionHead(eyebrow: l.faqEyebrow, title: l.faqTitle, center: true),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 860),
            child: Container(
              decoration: BoxDecoration(border: Border(top: BorderSide(color: p.line))),
              child: Column(children: [
                for (var i = 0; i < qa.length; i++) Reveal(child: _FaqItem(question: qa[i].$1, answer: qa[i].$2, initiallyOpen: i == 0)),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}

class _FaqItem extends StatefulWidget {
  const _FaqItem({required this.question, required this.answer, required this.initiallyOpen});
  final String question, answer;
  final bool initiallyOpen;

  @override
  State<_FaqItem> createState() => _FaqItemState();
}

class _FaqItemState extends State<_FaqItem> {
  late bool _open = widget.initiallyOpen;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final instant = MediaQuery.disableAnimationsOf(context);
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: p.line))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Semantics(
          button: true,
          expanded: _open,
          child: InkWell(
            onTap: () => setState(() => _open = !_open),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 22),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(child: Text(widget.question, style: context.body(19, weight: FontWeight.w500, height: 1.35))),
                const SizedBox(width: 16),
                ExcludeSemantics(
                  child: Text(_open ? '−' : '+', style: TextStyle(fontSize: 26, fontWeight: FontWeight.w300, height: 1, color: p.accent)),
                ),
              ]),
            ),
          ),
        ),
        AnimatedSize(
          duration: instant ? Duration.zero : const Duration(milliseconds: 180),
          alignment: Alignment.topCenter,
          child: _open
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 22),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 640),
                    child: Text(widget.answer, style: context.body(16, color: p.muted)),
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ]),
    );
  }
}

// ───────────────────────────── legal

class LegalSection extends StatelessWidget {
  const LegalSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = Palette.of(context);
    final cols = _cols(context, wide: 4, medium: 2);
    return Section(
      top: false,
      child: ContentWidth(
        child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          SectionHead(eyebrow: l.legalEyebrow, title: l.legalTitle, body: l.legalBody),
          EqualGrid(
            columns: cols,
            gap: 12,
            reveal: true,
            children: [
              for (final doc in LegalDoc.all)
                Material(
                  color: p.surface,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: p.line)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () => showLegalDoc(context, doc),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(doc.title(l), style: context.body(16, weight: FontWeight.w600, height: 1.3)),
                        const SizedBox(height: 4),
                        Text(doc.subtitle(l), style: context.body(13.5, color: p.muted, height: 1.4)),
                      ]),
                    ),
                  ),
                ),
            ],
          ),
        ]),
      ),
    );
  }
}
