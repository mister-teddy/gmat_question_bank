import 'package:flutter/material.dart';
import 'package:gmat_question_bank/state/preferences.dart';
import 'package:provider/provider.dart';

class FlagQuestion extends StatelessWidget {
  FlagQuestion({super.key, required this.questionId});

  final String questionId;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesState>(
        builder: (context, value, child) => value.isFlagged(questionId)
            ? FilledButton.icon(
                onPressed: () {
                  value.flag(questionId, false);
                },
                icon: Icon(Icons.flag_outlined),
                label: Text("Unflag"),
              )
            : ElevatedButton.icon(
                onPressed: () {
                  value.flag(questionId, true);
                },
                icon: Icon(Icons.flag),
                label: Text("Flag"),
              ));
  }
}
