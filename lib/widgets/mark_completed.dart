import 'package:flutter/material.dart';
import 'package:open_gmat_database/state/preferences.dart';
import 'package:provider/provider.dart';

class MarkCompleted extends StatelessWidget {
  MarkCompleted({super.key, required this.questionId});

  final String questionId;

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesState>(
        builder: (context, value, child) => value.isCompleted(questionId)
            ? FilledButton.icon(
                onPressed: () {
                  value.complete(questionId, false);
                },
                icon: Icon(Icons.check),
                label: Text("Complete"),
              )
            : ElevatedButton.icon(
                onPressed: () {
                  value.complete(questionId, true);
                },
                icon: Icon(Icons.check),
                label: Text("Complete"),
              ));
  }
}
