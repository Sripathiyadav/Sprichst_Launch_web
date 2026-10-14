import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../l10n/app_localizations.dart';
import 'theme.dart';
import 'widgets.dart';

/// One bundled legal document.
class LegalDoc {
  const LegalDoc(this.file, this.title, this.subtitle);
  final String file;
  final String Function(AppLocalizations) title;
  final String Function(AppLocalizations) subtitle;

  static final privacy = LegalDoc('privacy-policy', (l) => l.legalPrivacy, (l) => l.legalPrivacySub);
  static final terms = LegalDoc('terms-of-service', (l) => l.legalTerms, (l) => l.legalTermsSub);
  static final cookies = LegalDoc('cookies-and-storage', (l) => l.legalCookies, (l) => l.legalCookiesSub);
  static final impressum = LegalDoc('impressum', (l) => l.legalImpressum, (l) => l.legalImpressumSub);

  static final all = [
    privacy,
    terms,
    LegalDoc('your-rights', (l) => l.legalRights, (l) => l.legalRightsSub),
    cookies,
    LegalDoc('ai-transparency', (l) => l.legalAi, (l) => l.legalAiSub),
    LegalDoc('disclaimer', (l) => l.legalDisclaimer, (l) => l.legalDisclaimerSub),
    LegalDoc('accessibility', (l) => l.legalA11y, (l) => l.legalA11ySub),
    LegalDoc('security-summary', (l) => l.legalSecurity, (l) => l.legalSecuritySub),
    LegalDoc('copyright-and-takedown', (l) => l.legalCopyright, (l) => l.legalCopyrightSub),
    LegalDoc('third-party-notices', (l) => l.legalThirdParty, (l) => l.legalThirdPartySub),
    impressum,
  ];
}

Future<void> showLegalDoc(BuildContext context, LegalDoc doc) {
  return showDialog<void>(
    context: context,
    barrierColor: const Color(0x8C141211),
    builder: (context) => _LegalDialog(doc: doc),
  );
}

class _LegalDialog extends StatefulWidget {
  const _LegalDialog({required this.doc});
  final LegalDoc doc;

  @override
  State<_LegalDialog> createState() => _LegalDialogState();
}

class _LegalDialogState extends State<_LegalDialog> {
  // Loaded once, so a rebuild (resize, theme switch) doesn't flash the spinner.
  late final Future<String> _text = rootBundle.loadString('assets/legal/${widget.doc.file}.md');

  @override
  Widget build(BuildContext context) {
    final doc = widget.doc;
    final p = Palette.of(context);
    final l = AppLocalizations.of(context);
    final size = MediaQuery.sizeOf(context);
    return Dialog(
      backgroundColor: p.surface,
      surfaceTintColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 820, maxHeight: size.height - 64),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(24, 12, 12, 12),
              decoration: BoxDecoration(border: Border(bottom: BorderSide(color: p.line))),
              child: Row(children: [
                Expanded(child: Text(doc.title(l), style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16))),
                IconButton(
                  tooltip: l.close,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                  style: IconButton.styleFrom(side: BorderSide(color: p.lineStrong), minimumSize: const Size(44, 44)),
                ),
              ]),
            ),
            Flexible(
              child: FutureBuilder<String>(
                future: _text,
                builder: (context, snap) {
                  if (snap.hasError) {
                    return Padding(padding: const EdgeInsets.all(32), child: Text(l.legalLoadError));
                  }
                  if (!snap.hasData) {
                    return const Padding(padding: EdgeInsets.all(48), child: Center(child: CircularProgressIndicator()));
                  }
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(32, 24, 32, 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (Localizations.localeOf(context).languageCode != 'en')
                          Container(
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                            decoration: BoxDecoration(color: p.sunken, borderRadius: BorderRadius.circular(12)),
                            child: Row(children: [
                              Icon(Icons.translate, size: 18, color: p.muted),
                              const SizedBox(width: 10),
                              Expanded(child: Text(l.legalEnglishOnly, style: context.body(14, color: p.muted))),
                            ]),
                          ),
                        // Legal text stays English; mark it so screen readers pronounce it correctly.
                        Localizations.override(
                          context: context,
                          locale: const Locale('en'),
                          child: SelectionArea(child: MarkdownView(snap.data!)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Minimal Markdown: #-### headings, bullet lists, pipe tables, paragraphs,
/// **bold**, *italic*, `code` and [links](https://…). Unlike standard
/// Markdown, line breaks inside a paragraph are kept, so address blocks and
/// numbered lines stay one per line.
class MarkdownView extends StatefulWidget {
  const MarkdownView(this.source, {super.key});
  final String source;

  @override
  State<MarkdownView> createState() => _MarkdownViewState();
}

class _MarkdownViewState extends State<MarkdownView> {
  // Link recognizers from the latest build; disposed when replaced or removed.
  final _recognizers = <TapGestureRecognizer>[];

  void _disposeRecognizers() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
  }

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _disposeRecognizers();
    final source = widget.source;
    final p = Palette.of(context);
    final blocks = <Widget>[];
    final lines = source.split('\n');
    final bullet = RegExp(r'^\s*[-*] ');
    final heading = RegExp(r'^(#{1,3}) ');
    var i = 0;
    while (i < lines.length) {
      final line = lines[i];
      final h = heading.firstMatch(line);
      if (h != null) {
        final level = h.group(1)!.length;
        final size = [30.0, 21.0, 17.0][level - 1];
        blocks.add(Padding(
          padding: EdgeInsets.only(top: level == 1 ? 0 : (level == 2 ? 28 : 20), bottom: level == 1 ? 12 : 8),
          child: Semantics(
            header: true,
            child: Text.rich(_inline(context, line.substring(level + 1)),
                style: TextStyle(fontSize: size, fontWeight: level == 1 ? FontWeight.w500 : FontWeight.w600, height: 1.25, color: p.ink)),
          ),
        ));
        i++;
        continue;
      }
      if (bullet.hasMatch(line)) {
        final items = <Widget>[];
        while (i < lines.length && bullet.hasMatch(lines[i])) {
          items.add(Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(padding: const EdgeInsets.only(top: 9, right: 12, left: 4), child: CircleAvatar(radius: 2.5, backgroundColor: p.ink)),
              Expanded(child: Text.rich(_inline(context, lines[i].replaceFirst(bullet, '')), style: _para(p))),
            ]),
          ));
          i++;
        }
        blocks.add(Padding(padding: const EdgeInsets.only(bottom: 6), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: items)));
        continue;
      }
      if (line.startsWith('|')) {
        final rows = <String>[];
        while (i < lines.length && lines[i].startsWith('|')) {
          rows.add(lines[i]);
          i++;
        }
        blocks.add(_table(context, rows));
        continue;
      }
      if (line.trim().isEmpty) {
        i++;
        continue;
      }
      final para = <String>[];
      while (i < lines.length &&
          lines[i].trim().isNotEmpty &&
          !heading.hasMatch(lines[i]) &&
          !bullet.hasMatch(lines[i]) &&
          !lines[i].startsWith('|')) {
        para.add(lines[i]);
        i++;
      }
      blocks.add(Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Text.rich(_inline(context, para.join('\n')), style: _para(p)),
      ));
    }
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 700),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: blocks),
    );
  }

  TextStyle _para(Palette p) => TextStyle(fontSize: 15.5, height: 1.55, color: p.ink);

  Widget _table(BuildContext context, List<String> rows) {
    final p = Palette.of(context);
    List<String> cells(String r) => r.replaceAll(RegExp(r'^\||\|$'), '').split('|').map((c) => c.trim()).toList();
    final header = cells(rows.first);
    final body = rows.length > 2 ? rows.sublist(2).map(cells).toList() : <List<String>>[];
    Widget cell(String text, {bool head = false}) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text.rich(_inline(context, text),
              style: TextStyle(fontSize: 14, height: 1.4, fontWeight: head ? FontWeight.w600 : FontWeight.w400, color: p.ink)),
        );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 480, maxWidth: 760),
          child: Table(
            border: TableBorder.all(color: p.line),
            defaultColumnWidth: const IntrinsicColumnWidth(flex: 1),
            children: [
              TableRow(children: [for (final h in header) cell(h, head: true)]),
              for (final r in body)
                TableRow(children: [for (var c = 0; c < header.length; c++) cell(c < r.length ? r[c] : '')]),
            ],
          ),
        ),
      ),
    );
  }

  static final _token = RegExp(r'\*\*([^*]+)\*\*|\*([^*]+)\*|`([^`]+)`|\[([^\]]+)\]\(([^)]*)\)');

  TextSpan _inline(BuildContext context, String text) {
    final p = Palette.of(context);
    final spans = <InlineSpan>[];
    var last = 0;
    for (final m in _token.allMatches(text)) {
      if (m.start > last) spans.add(TextSpan(text: text.substring(last, m.start)));
      if (m.group(1) != null) {
        spans.add(TextSpan(text: m.group(1), style: const TextStyle(fontWeight: FontWeight.w700)));
      } else if (m.group(2) != null) {
        spans.add(TextSpan(text: m.group(2), style: const TextStyle(fontStyle: FontStyle.italic)));
      } else if (m.group(3) != null) {
        spans.add(TextSpan(text: m.group(3), style: TextStyle(fontFamily: 'monospace', backgroundColor: p.sunken)));
      } else {
        final label = m.group(4)!;
        final href = m.group(5)!;
        if (href.startsWith('http')) {
          final tap = TapGestureRecognizer()..onTap = () => openUrl(href);
          _recognizers.add(tap);
          spans.add(TextSpan(
            text: label,
            style: TextStyle(color: p.accent, decoration: TextDecoration.underline, decorationColor: p.accent),
            recognizer: tap,
            mouseCursor: SystemMouseCursors.click,
          ));
        } else {
          spans.add(TextSpan(text: label));
        }
      }
      last = m.end;
    }
    if (last < text.length) spans.add(TextSpan(text: text.substring(last)));
    return TextSpan(children: spans);
  }
}
