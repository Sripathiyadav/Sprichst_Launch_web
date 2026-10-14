import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../theme.dart';
import '../widgets.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key, required this.onDownload, required this.onHow});
  final VoidCallback onDownload;
  final VoidCallback onHow;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = Palette.of(context);
    final width = MediaQuery.sizeOf(context).width;
    final stageHeight = width <= Breakpoints.medium ? 600.0 : fluid(context, 520, 62, 700);
    return Padding(
      padding: EdgeInsets.only(top: fluid(context, 40, 6, 72)),
      child: Column(
        children: [
          ContentWidth(
            child: Column(children: [
              const _ArticlePill(),
              const SizedBox(height: 24),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: context.isIndic ? 760 : 680),
                child: Semantics(
                  header: true,
                  child: emphasized(
                    l.heroTitle,
                    context.heading(fluid(context, 40, 6.4, 80), height: 1.02, tracking: -0.035),
                    p.accent,
                    align: TextAlign.center,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 560),
                child: Text(l.heroLede, textAlign: TextAlign.center, style: context.body(fluid(context, 17, 1.6, 20), color: p.muted)),
              ),
              const SizedBox(height: 32),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 12,
                runSpacing: 12,
                children: [
                  PillButton(label: l.ctaGet, trailing: '→', onPressed: onDownload),
                  PillButton(label: l.ctaHow, kind: PillKind.ghost, onPressed: onHow),
                ],
              ),
            ]),
          ),
          const SizedBox(height: 32),
          ExcludeSemantics(child: SizedBox(height: stageHeight, child: const _Stage())),
        ],
      ),
    );
  }
}

/// "der die das" chips plus the course summary.
class _ArticlePill extends StatelessWidget {
  const _ArticlePill();

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final l = AppLocalizations.of(context);
    Widget chip(String t, Color bg, Color fg, double shift) => Transform.translate(
          offset: Offset(shift, 0),
          child: Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: bg, shape: BoxShape.circle, border: Border.all(color: p.surface, width: 2)),
            child: Text(t, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: fg)),
          ),
        );
    return Container(
      padding: const EdgeInsets.fromLTRB(6, 6, 16, 6),
      decoration: BoxDecoration(color: p.surface, borderRadius: BorderRadius.circular(999), border: Border.all(color: p.line)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        chip('der', const Color(0xFFCFE5FF), const Color(0xFF001D34), 0),
        chip('die', const Color(0xFFFFDAD6), const Color(0xFF410002), -6),
        chip('das', const Color(0xFFB5F39A), const Color(0xFF042100), -12),
        const SizedBox(width: 0),
        Flexible(child: Text(l.heroPill, style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: p.ink))),
      ]),
    );
  }
}

class _Stage extends StatelessWidget {
  const _Stage();

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final l = AppLocalizations.of(context);
    final dark = Theme.of(context).brightness == Brightness.dark;
    final width = MediaQuery.sizeOf(context).width;
    final showFloats = width > Breakpoints.medium;
    final wide = width > Breakpoints.wide;
    final phoneWidth = width <= Breakpoints.medium ? 250.0 : 300.0;

    return LayoutBuilder(builder: (context, c) {
      final mid = c.maxWidth / 2;
      // Float positions follow the original: offsets from the centre on wide
      // screens, pinned to the edges in between.
      double leftOf(double fromCentre) => wide ? mid - fromCentre : 12;
      return Stack(clipBehavior: Clip.hardEdge, children: [
        Positioned.fill(child: CustomPaint(painter: _SunPainter(p.coral))),
        Positioned(
          left: mid - phoneWidth / 2,
          top: 24,
          width: phoneWidth,
          child: Transform.rotate(
            angle: -4 * math.pi / 180,
            child: Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: const Color(0xFF1B1A19),
                borderRadius: BorderRadius.circular(46),
                boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: dark ? 0.7 : 0.4), blurRadius: 60, offset: const Offset(0, 30), spreadRadius: -24)],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(36),
                child: AspectRatio(
                  aspectRatio: 360 / 779,
                  child: Image.asset(dark ? 'assets/screens/home-dark.png' : 'assets/screens/home.png', fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        ),
        if (showFloats) ...[
          Positioned(
            left: leftOf(420),
            top: 120,
            child: _Float(
              leading: Text('07', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w300, letterSpacing: -1, height: 1, color: p.ink)),
              title: l.floatStreakTitle,
              subtitle: l.floatStreakSub,
            ),
          ),
          Positioned(
            right: wide ? mid - 440 : 12,
            top: 210,
            child: _Float(
              leading: IconBadge(Icons.check, bg: p.successSoft, fg: p.success, size: 34, iconSize: 18),
              title: 'Ich möchte einen Kaffee, bitte.',
              subtitle: l.floatCorrectSub,
            ),
          ),
          Positioned(
            left: leftOf(380),
            top: 380,
            child: _Float(
              leading: Container(
                constraints: const BoxConstraints(minWidth: 40),
                height: 26,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(color: const Color(0xFFFFDAD6), borderRadius: BorderRadius.circular(99)),
                child: const Text('die', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Color(0xFF410002))),
              ),
              title: 'Rechnung',
              subtitle: l.floatWordSub,
            ),
          ),
          Positioned(
            right: wide ? mid - 400 : 12,
            top: 450,
            child: _Float(
              leading: IconBadge(Icons.bookmark_outline, bg: p.accentSoft, fg: p.accent, size: 34, iconSize: 18),
              title: l.floatBadgeTitle,
              subtitle: l.floatBadgeSub,
            ),
          ),
        ],
      ]);
    });
  }
}

class _Float extends StatelessWidget {
  const _Float({required this.leading, required this.title, required this.subtitle});
  final Widget leading;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: p.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: p.line),
        boxShadow: [BoxShadow(color: p.ink.withValues(alpha: 0.25), blurRadius: 60, offset: const Offset(0, 30), spreadRadius: -24)],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        leading,
        const SizedBox(width: 12),
        Flexible(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
            Text(title, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: p.ink)),
            Text(subtitle, style: TextStyle(fontSize: 14, color: p.muted)),
          ]),
        ),
      ]),
    );
  }
}

/// The coral sun behind the phone. The rings around it are painted for the
/// whole page by the landing page's background.
class _SunPainter extends CustomPainter {
  _SunPainter(this.sun);
  final Color sun;

  @override
  void paint(Canvas canvas, Size size) {
    // Up and to the right of the phone, partly behind it.
    final centre = Offset(size.width / 2, size.height + 420 - 700);
    canvas.drawCircle(centre + const Offset(310, -280), 70, Paint()..color = sun);
  }

  @override
  bool shouldRepaint(_SunPainter old) => old.sun != sun;
}
