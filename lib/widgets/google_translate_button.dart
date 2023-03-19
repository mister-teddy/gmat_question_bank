import 'package:flutter/material.dart';
import 'package:open_gmat_database/state.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleTranslateButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseState>(
      builder: (context, value, child) => Tooltip(
        message: 'Open in Google Translate',
        child: IconButton(
          icon: const Icon(Icons.g_translate),
          onPressed: () async {
            final text = value.questionContent;
            if (text != null) {
              final googleTranslateUrl = Uri.parse(
                  "googletranslate://translate.google.com/?text=$text");
              final fallbackUrl =
                  Uri.parse("https://translate.google.com/?text=$text");
              if (await canLaunchUrl(googleTranslateUrl)) {
                await launchUrl(googleTranslateUrl);
              } else {
                await launchUrl(fallbackUrl);
              }
            }
          },
        ),
      ),
    );
  }
}
