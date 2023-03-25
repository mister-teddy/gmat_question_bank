import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gmat_question_bank/state/database.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AskAIButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseState>(
      builder: (context, value, child) => Tooltip(
        message: 'Ask AI',
        child: IconButton(
          icon: const Icon(Icons.smart_toy),
          onPressed: () async {
            final text = value.questionContent;
            if (text != null) {
              Clipboard.setData(ClipboardData(text: text));
              final url = Uri.parse("https://poe.com/");
              await launchUrl(url);
            }
          },
        ),
      ),
    );
  }
}
