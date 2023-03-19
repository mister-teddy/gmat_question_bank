import 'package:flutter/material.dart';
import 'package:open_gmat_database/state/database.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewQuestionSource extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseState>(
      builder: (context, value, child) => Tooltip(
        message: 'View original question on GMAT Club',
        child: IconButton(
          icon: const Icon(Icons.open_in_new_sharp),
          onPressed: () async {
            final text = value.questionContent;
            if (text != null) {
              final url = Uri.parse(value.questionSrc!);
              await launchUrl(url);
            }
          },
        ),
      ),
    );
  }
}
