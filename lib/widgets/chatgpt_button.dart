import 'package:flutter/material.dart';
import 'package:open_gmat_database/state.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatGPTButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseState>(
      builder: (context, value, child) => Tooltip(
        message: 'Open ChatGPT',
        child: IconButton(
          icon: const Icon(Icons.smart_toy),
          onPressed: () async {
            final text = value.questionContent;
            if (text != null) {
              final url = Uri.parse("https://chat.openai.com/chat");
              await launchUrl(url);
            }
          },
        ),
      ),
    );
  }
}
