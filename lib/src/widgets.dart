import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme.dart';

const repoUrl = 'https://github.com/Sripathiyadav/Sprichst';
const issuesUrl = 'https://github.com/Sripathiyadav/Sprichst/issues';
const profileUrl = 'https://github.com/Sripathiyadav';
const portfolioUrl = 'https://sripathiyadavportfolio.netlify.app';
const contactEmail = 'sripathiyadav66@gmail.com';

Future<void> openUrl(String url) => launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');

/// Centred content column with the page gutter, max 1160 wide.
class ContentWidth extends StatelessWidget {
  const ContentWidth({super.key, required this.child, this.maxWidth = 1160});
  final Widget child;
  final double maxWidth;

  @override
  Widget build(BuildContext context) {
    final gutter = fluid(context, 16, 4, 48);
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: EdgeInsets.symmetric(horizontal: gutter), child: child),
      ),
    );
  }
}

/// Slides its child up a little and fades it in the first time it scrolls
/// into view. Stays shown afterwards. With reduced motion it shows at once.
///
/// Reveals that come into view together (a row of cards, or a whole grid on
/// a tall screen) start one after another, [stagger] apart, in page order.
class Reveal extends StatefulWidget {
  const Reveal({super.key, required this.child});
  final Widget child;

  /// How far below its resting place the child starts.
  static const rise = 48.0;

  /// Gap between reveals that come into view at the same moment.
  static const stagger = Duration(milliseconds: 90);

  /// Longest wait in a cascade, so a big grid doesn't keep its last cards hidden.
  static const _maxQueue = 8;

  // Reveals triggered since the last frame; reset after each frame.
  static int _queued = 0;
  static bool _resetPending = false;

  static Duration _nextDelay() {
    final slot = _queued++;
    if (!_resetPending) {
      _resetPending = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _queued = 0;
        _resetPending = false;
      });
      WidgetsBinding.instance.ensureVisualUpdate();
    }
    return stagger * math.min(slot, _maxQueue);
  }

  @override
  State<Reveal> createState() => _RevealState();
}

class _RevealState extends State<Reveal> with SingleTickerProviderStateMixin {
  late final _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
  late final _curve = CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic);
  ScrollPosition? _position;
  Timer? _start;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    }
    // Track the page's vertical scroll, even inside a horizontal list.
    final position = Scrollable.maybeOf(context, axis: Axis.vertical)?.position;
    if (position != _position) {
      _position?.removeListener(_check);
      _position = position?..addListener(_check);
    }
    // Sections already on screen when the page opens.
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  void _check() {
    if (!mounted) return;
    // Already started, queued or shown (reduced motion): stop watching the scroll.
    if (_start != null || _controller.status != AnimationStatus.dismissed) {
      _position?.removeListener(_check);
      return;
    }
    final box = context.findRenderObject();
    final viewport = Scrollable.maybeOf(context, axis: Axis.vertical)?.context.findRenderObject();
    if (box is! RenderBox || viewport is! RenderBox || !box.attached || !viewport.attached) return;
    final top = box.localToGlobal(Offset.zero).dy - viewport.localToGlobal(Offset.zero).dy;
    // Start once the top edge is a little way into the viewport.
    if (top >= viewport.size.height - 60) return;
    _position?.removeListener(_check);
    if (top + box.size.height < 0) {
      // Jumped past it (a nav link): just show it, without holding up the
      // cards that are actually on screen.
      _controller.value = 1;
      return;
    }
    _start = Timer(Reveal._nextDelay(), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _position?.removeListener(_check);
    _start?.cancel();
    _curve.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _curve,
      child: AnimatedBuilder(
        animation: _curve,
        builder: (context, child) => Transform.translate(offset: Offset(0, Reveal.rise * (1 - _curve.value)), child: child),
        child: widget.child,
      ),
    );
  }
}

/// A page section with the standard vertical rhythm.
class Section extends StatelessWidget {
  const Section({super.key, required this.child, this.top = true});
  final Widget child;
  final bool top;

  @override
  Widget build(BuildContext context) {
    final pad = fluid(context, 64, 9, 112);
    return Padding(padding: EdgeInsets.only(top: top ? pad : 0, bottom: pad), child: child);
  }
}

class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key, this.color});
  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final upper = !context.isIndic;
    return Text(
      upper ? context.upper(text) : text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: upper ? 1.04 : 0,
        color: color ?? Palette.of(context).accent,
      ),
    );
  }
}

/// Eyebrow, heading and lede at the top of a section.
class SectionHead extends StatelessWidget {
  const SectionHead({super.key, required this.eyebrow, required this.title, this.body, this.center = false, this.bottom = 48, this.onPanel = false, this.action});
  final String eyebrow;
  final String title;
  final String? body;
  final bool center;
  final double bottom;
  final bool onPanel;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final align = center ? CrossAxisAlignment.center : CrossAxisAlignment.start;
    final textAlign = center ? TextAlign.center : TextAlign.start;
    return Padding(
      padding: EdgeInsets.only(bottom: bottom),
      child: Align(
        alignment: center ? Alignment.center : Alignment.centerLeft,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            crossAxisAlignment: align,
            children: [
              Eyebrow(eyebrow, color: onPanel ? p.panelEyebrow : null),
              const SizedBox(height: 14),
              Semantics(
                header: true,
                child: Text(title,
                    textAlign: textAlign,
                    style: context.heading(fluid(context, 32, 4.2, 52), color: onPanel ? p.onPanel : null)),
              ),
              if (body != null) ...[
                const SizedBox(height: 14),
                Text(body!, textAlign: textAlign, style: context.body(18, color: onPanel ? p.onPanelMuted : p.muted)),
              ],
              if (action != null) ...[const SizedBox(height: 20), action!],
            ],
          ),
        ),
      ),
    );
  }
}

/// Renders "Learn German by *speaking* it." with the starred word accented.
Text emphasized(String source, TextStyle style, Color accent, {TextAlign? align}) {
  final parts = source.split('*');
  return Text.rich(
    TextSpan(children: [
      for (var i = 0; i < parts.length; i++)
        TextSpan(text: parts[i], style: i.isOdd ? TextStyle(color: accent) : null),
    ]),
    style: style,
    textAlign: align,
  );
}

enum PillKind { primary, ghost, disabled }

/// Rounded pill button matching the site's .btn styles.
class PillButton extends StatefulWidget {
  const PillButton({super.key, required this.label, this.onPressed, this.kind = PillKind.primary, this.small = false, this.trailing});
  final String label;
  final VoidCallback? onPressed;
  final PillKind kind;
  final bool small;
  final String? trailing;

  @override
  State<PillButton> createState() => _PillButtonState();
}

class _PillButtonState extends State<PillButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    final (bg, fg, border) = switch (widget.kind) {
      PillKind.primary => (p.action, p.onAction, Colors.transparent),
      PillKind.ghost => (p.surface, p.ink, p.line),
      PillKind.disabled => (p.sunken, p.muted, Colors.transparent),
    };
    final enabled = widget.kind != PillKind.disabled && widget.onPressed != null;
    final lift = enabled && _hover && !MediaQuery.disableAnimationsOf(context);
    return Semantics(
      button: true,
      enabled: enabled,
      child: MouseRegion(
        cursor: enabled ? SystemMouseCursors.click : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _hover = true),
        onExit: (_) => setState(() => _hover = false),
        child: AnimatedSlide(
          duration: const Duration(milliseconds: 120),
          offset: Offset(0, lift ? -0.02 : 0),
          child: Material(
            color: bg,
            shape: StadiumBorder(side: BorderSide(color: border, width: 1.5)),
            elevation: widget.kind == PillKind.ghost ? 1 : 0,
            shadowColor: p.ink.withValues(alpha: 0.2),
            child: InkWell(
              customBorder: const StadiumBorder(),
              onTap: enabled ? widget.onPressed : null,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: widget.small ? 44 : 52),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: widget.small ? 20 : 26, vertical: 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Text(widget.label,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: widget.small ? 15 : 16, fontWeight: FontWeight.w600, color: fg)),
                      ),
                      if (widget.trailing != null) ...[
                        const SizedBox(width: 10),
                        Text(widget.trailing!,
                            style: TextStyle(
                                fontSize: 18,
                                height: 1,
                                color: widget.kind == PillKind.primary ? p.glyph : fg)),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Small rounded chip used for contact links.
class LinkChip extends StatelessWidget {
  const LinkChip({super.key, required this.label, this.icon, required this.onTap, this.trailing, this.tooltip});
  final String label;
  final IconData? icon;
  final VoidCallback onTap;
  final Widget? trailing;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    Widget chip = Material(
      color: p.surface,
      shape: StadiumBorder(side: BorderSide(color: p.line)),
      child: InkWell(
        customBorder: const StadiumBorder(),
        onTap: onTap,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(mainAxisSize: MainAxisSize.min, children: [
              if (icon != null) ...[Icon(icon, size: 18, color: p.ink), const SizedBox(width: 8)],
              Flexible(child: Text(label, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: p.ink))),
              if (trailing != null) ...[const SizedBox(width: 8), trailing!],
            ]),
          ),
        ),
      ),
    );
    if (tooltip != null) chip = Tooltip(message: tooltip!, child: chip);
    return chip;
  }
}

/// Round tinted icon badge.
class IconBadge extends StatelessWidget {
  const IconBadge(this.icon, {super.key, required this.bg, required this.fg, this.size = 44, this.iconSize = 22});
  final IconData icon;
  final Color bg, fg;
  final double size, iconSize;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        child: Icon(icon, color: fg, size: iconSize),
      );
}

/// Small rounded tag, e.g. CEFR levels or game names.
class Tag extends StatelessWidget {
  const Tag(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(color: p.sunken, borderRadius: BorderRadius.circular(99)),
      child: Text(text, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: p.ink)),
    );
  }
}

/// Lays children out in [columns] equal-width columns with equal-height rows.
class EqualGrid extends StatelessWidget {
  const EqualGrid({super.key, required this.columns, required this.children, this.gap = 20, this.reveal = false});
  final int columns;
  final List<Widget> children;
  final double gap;

  /// Slide each cell in, one after another, as it scrolls into view.
  final bool reveal;

  @override
  Widget build(BuildContext context) {
    final rows = <Widget>[];
    for (var i = 0; i < children.length; i += columns) {
      final cells = <Widget>[];
      for (var c = 0; c < columns; c++) {
        if (c > 0) cells.add(SizedBox(width: gap));
        final idx = i + c;
        final cell = idx < children.length ? children[idx] : const SizedBox.shrink();
        cells.add(Expanded(child: reveal && idx < children.length ? Reveal(child: cell) : cell));
      }
      if (rows.isNotEmpty) rows.add(SizedBox(height: gap));
      rows.add(IntrinsicHeight(child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: cells)));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }
}

/// Bordered card on the surface colour.
class SurfaceCard extends StatelessWidget {
  const SurfaceCard({super.key, required this.child, this.padding = const EdgeInsets.all(24), this.radius = 20, this.color, this.borderColor, this.borderWidth = 1});
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final Color? color;
  final Color? borderColor;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? p.surface,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor ?? p.line, width: borderWidth),
      ),
      child: child,
    );
  }
}

/// The Sprichst mark, recoloured for the current theme.
class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.size = 34});
  final double size;

  static Future<String>? _source;

  @override
  Widget build(BuildContext context) {
    final p = Palette.of(context);
    _source ??= rootBundle.loadString('assets/brand/mark.svg');
    return FutureBuilder<String>(
      future: _source,
      builder: (context, snap) {
        if (!snap.hasData) return SizedBox.square(dimension: size);
        final svg = snap.data!
            .replaceAll('#2a2826', _hex(p.ink))
            .replaceAll('#e45347', _hex(p.coral));
        return SvgPicture.string(svg, width: size, height: size, excludeFromSemantics: true);
      },
    );
  }

  static String _hex(Color c) => '#${(c.toARGB32() & 0xFFFFFF).toRadixString(16).padLeft(6, '0')}';
}

/// Brand name with mark, used in the nav and the footer.
class BrandLockup extends StatelessWidget {
  const BrandLockup({super.key, this.onTap});
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      link: true,
      label: 'Sprichst',
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: onTap,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          const BrandMark(size: 34),
          const SizedBox(width: 10),
          ExcludeSemantics(
            child: Text('Sprichst',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.w700, letterSpacing: -0.6, color: Palette.of(context).ink)),
          ),
        ]),
      ),
    );
  }
}
