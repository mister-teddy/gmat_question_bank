import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:open_gmat_database/layouts/home.dart';
import 'package:open_gmat_database/state/database.dart';
import 'package:open_gmat_database/widgets/component_screen.dart';
import 'package:open_gmat_database/widgets/rich_content.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../models/question.dart';

class QuestionDetail extends StatefulWidget {
  QuestionDetail({
    super.key,
    required this.railAnimation,
    required this.questionId,
  }) : _future = http
            .get(Uri.parse(
                'https://nguyenhongphat0.github.io/gmat-database/$questionId.json'))
            .then((value) => Question.fromJson(jsonDecode(value.body)));

  final String questionId;
  late final Future<Question> _future;
  final CurvedAnimation railAnimation;

  @override
  State<QuestionDetail> createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {
  bool showExplanations = false;
  int selectedAnswerIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseState>(
      builder: (context, state, child) => FutureBuilder(
        future: widget._future,
        builder: (BuildContext context, AsyncSnapshot<Question> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final question = snapshot.data!;
            state.setQuestionContent(question);
            return Container(
              child: OneTwoTransition(
                animation: widget.railAnimation,
                one: FocusTraversalGroup(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Column(
                        children: [
                          RichContent(question.question),
                          if (question.answers != null)
                            ListAnswer(answers: question.answers!),
                          if (question.subQuestions != null)
                            Column(
                              children: List.generate(
                                question.subQuestions!.length,
                                (index) => Column(
                                  children: [
                                    RichContent(
                                        question.subQuestions![index].question),
                                    ListAnswer(
                                        answers: question
                                            .subQuestions![index].answers),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                two: FocusTraversalGroup(
                  child: showExplanations
                      ? ListView.builder(
                          padding: const EdgeInsetsDirectional.only(
                              end: smallSpacing),
                          itemCount: snapshot.data!.explanations.length,
                          itemBuilder: (context, index) {
                            final item = ComponentGroupDecoration(children: [
                              RichContent(snapshot.data!.explanations[index])
                            ]);
                            if (index == 0) {
                              return item;
                            } else {
                              return Column(
                                children: [colDivider, item],
                              );
                            }
                          })
                      : Card(
                          margin: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16.0),
                                  bottomLeft: Radius.circular(16.0))),
                          child: Center(
                            child: FloatingActionButton.extended(
                              onPressed: () {
                                setState(() {
                                  showExplanations = true;
                                });
                              },
                              label: Text(
                                  "Show ${question.explanations.length} explanation${question.explanations.length > 1 ? 's' : ''}"),
                              icon: Icon(Icons.reviews),
                            ),
                          ),
                        ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class ListAnswer extends StatefulWidget {
  ListAnswer({super.key, required this.answers});

  final List<String> answers;

  @override
  State<ListAnswer> createState() => _ListAnswerState();
}

class _ListAnswerState extends State<ListAnswer> {
  int selectedAnswerIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.answers.length, (int index) {
        return Card(
          color: index == selectedAnswerIndex
              ? Theme.of(context).colorScheme.surfaceVariant
              : null,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            onTap: () {
              setState(() {
                selectedAnswerIndex = index;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    child: Text(String.fromCharCode(65 + index)),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Flexible(child: RichContent(widget.answers[index])),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
