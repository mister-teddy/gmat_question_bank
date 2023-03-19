import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:catex/catex.dart';

class RichContent extends StatelessWidget {
  const RichContent(this.text, {Key? key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    final regex = RegExp(r'\\\(.*?\\\)');
    final matches = regex.allMatches(text);

    int start = 0;
    final List<String> parts = [];

    for (final match in matches) {
      if (match.start > start) {
        parts.add(text.substring(start, match.start));
      }
      parts.add(text.substring(match.start, match.end));
      start = match.end;
    }

    if (start < text.length) {
      parts.add(text.substring(start));
    }

    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: List.generate(
            parts.length,
            (index) {
              final part = parts[index].trim();

              if (part.startsWith(r"\(") && part.endsWith(r"\)")) {
                final latex = part
                    .substring(2, part.length - 2)
                    .replaceAll('&lt;', '<')
                    .replaceAll('&gt;', '>');

                return WidgetSpan(child: CaTeX(latex));
              } else {
                return WidgetSpan(child: Html(data: part));
              }
            },
          ),
        ));
  }
}
