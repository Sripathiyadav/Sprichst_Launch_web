import 'package:flutter/material.dart';

/// The Sprichst palette: warm paper, ink and one coral accent.
@immutable
class Palette extends ThemeExtension<Palette> {
  const Palette({
    required this.canvas,
    required this.surface,
    required this.sunken,
    required this.panel,
    required this.ink,
    required this.muted,
    required this.line,
    required this.lineStrong,
    required this.onPanel,
    required this.onPanelMuted,
    required this.coral,
    required this.accent,
    required this.accentSoft,
    required this.action,
    required this.onAction,
    required this.glyph,
    required this.success,
    required this.successSoft,
    required this.panelEyebrow,
  });

  final Color canvas, surface, sunken, panel, ink, muted, line, lineStrong;
  final Color onPanel, onPanelMuted, coral, accent, accentSoft, action, onAction, glyph;
  final Color success, successSoft, panelEyebrow;

  static const light = Palette(
    canvas: Color(0xFFF2EAE1),
    surface: Color(0xFFFBF7F2),
    sunken: Color(0xFFE8DED3),
    panel: Color(0xFF363433),
    ink: Color(0xFF2A2826),
    muted: Color(0xFF645B54),
    line: Color(0xFFDDD2C6),
    lineStrong: Color(0xFF8E8379),
    onPanel: Color(0xFFF5EEE6),
    onPanelMuted: Color(0xFFBCB2A9),
    coral: Color(0xFFE45347),
    accent: Color(0xFFB32F28),
    accentSoft: Color(0xFFFBE6E1),
    action: Color(0xFF2A2826),
    onAction: Color(0xFFFBF7F2),
    glyph: Color(0xFFF2877C),
    success: Color(0xFF22706A),
    successSoft: Color(0xFFD7EEEA),
    panelEyebrow: Color(0xFFF2877C),
  );

  static const dark = Palette(
    canvas: Color(0xFF1F1D1C),
    surface: Color(0xFF2A2827),
    sunken: Color(0xFF171615),
    panel: Color(0xFF3A3735),
    ink: Color(0xFFF3ECE4),
    muted: Color(0xFFB5ABA2),
    line: Color(0xFF3B3836),
    lineStrong: Color(0xFF7D736B),
    onPanel: Color(0xFFF5EEE6),
    onPanelMuted: Color(0xFFC2B8AF),
    coral: Color(0xFFD9625A),
    accent: Color(0xFFF08A7F),
    accentSoft: Color(0xFF4A2724),
    action: Color(0xFFF08A7F),
    onAction: Color(0xFF241A18),
    glyph: Color(0xFF241A18),
    success: Color(0xFF6CC9BC),
    successSoft: Color(0xFF173A37),
    panelEyebrow: Color(0xFFF08A7F),
  );

  static Palette of(BuildContext context) => Theme.of(context).extension<Palette>()!;

  @override
  Palette copyWith() => this;

  @override
  Palette lerp(Palette? other, double t) => t < 0.5 ? this : (other ?? this);
}

ThemeData buildTheme(Brightness brightness) {
  final p = brightness == Brightness.dark ? Palette.dark : Palette.light;
  final base = ThemeData(
    brightness: brightness,
    useMaterial3: true,
    fontFamily: 'Figtree',
    scaffoldBackgroundColor: p.canvas,
    colorScheme: ColorScheme.fromSeed(
      seedColor: p.coral,
      brightness: brightness,
      surface: p.surface,
      onSurface: p.ink,
      primary: p.accent,
    ),
    extensions: [p],
    splashFactory: InkSparkle.splashFactory,
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(bodyColor: p.ink, displayColor: p.ink),
    iconTheme: IconThemeData(color: p.ink),
    dividerColor: p.line,
    textSelectionTheme: TextSelectionThemeData(selectionColor: p.accentSoft),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(color: p.panel, borderRadius: BorderRadius.circular(8)),
      textStyle: TextStyle(color: p.onPanel, fontSize: 13),
    ),
  );
}

/// Breakpoints taken from the original page.
abstract final class Breakpoints {
  static const wide = 1060.0;
  static const medium = 760.0;
  static const narrow = 520.0;
}

/// Type helpers. Devanagari and Telugu need looser line height and no
/// negative tracking, so headings adapt to the current language.
extension SiteType on BuildContext {
  bool get isIndic {
    final code = Localizations.localeOf(this).languageCode;
    return code == 'hi' || code == 'te';
  }

  /// Uppercase for small labels. Greek capitals drop their accents.
  String upper(String text) {
    final up = text.toUpperCase();
    if (Localizations.localeOf(this).languageCode != 'el') return up;
    const accented = 'ΆΈΉΊΌΎΏΪΫ';
    const plain = 'ΑΕΗΙΟΥΩΙΥ';
    return String.fromCharCodes(up.runes.map((r) {
      final i = accented.indexOf(String.fromCharCode(r));
      return i >= 0 ? plain.codeUnitAt(i) : r;
    }));
  }

  TextStyle heading(double size, {FontWeight weight = FontWeight.w500, double height = 1.05, double tracking = -0.02, Color? color}) {
    final indic = isIndic;
    return TextStyle(
      fontSize: indic ? size * 0.9 : size,
      fontWeight: weight,
      height: indic ? (height < 1.35 ? 1.35 : height) : height,
      letterSpacing: indic ? 0 : size * tracking,
      color: color ?? Palette.of(this).ink,
    );
  }

  TextStyle body(double size, {Color? color, FontWeight weight = FontWeight.w400, double height = 1.5}) => TextStyle(
        fontSize: size,
        fontWeight: weight,
        height: isIndic ? height + 0.1 : height,
        color: color ?? Palette.of(this).ink,
      );
}

/// Fluid value between [min] and [max], like CSS clamp() with a vw term.
double fluid(BuildContext context, double min, double vw, double max) {
  final w = MediaQuery.sizeOf(context).width;
  return (w * vw / 100).clamp(min, max);
}
