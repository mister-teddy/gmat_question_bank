// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gmat_coach/component_screen.dart';
import 'package:gmat_coach/home.dart';
import 'package:gmat_coach/models/question.dart';
import 'package:gmat_coach/rich_content.dart';
import 'package:http/http.dart' as http;

class QuestionScreen extends StatelessWidget {
  QuestionScreen({
    super.key,
    required this.railAnimation,
  });
  final CurvedAnimation railAnimation;

  final _future = http
      .get(Uri.parse(
          'https://nguyenhongphat0.github.io/gmat-database/218526.json'))
      .then((value) => Question.fromJson(jsonDecode(value.body)));

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: OneTwoTransition(
        animation: railAnimation,
        one: FocusTraversalGroup(
            child: FutureBuilder(
                future: _future,
                builder:
                    (BuildContext context, AsyncSnapshot<Question> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return Center(
                      child: RichContent(snapshot.data!.question),
                    );
                  }
                })),
        two: ExplainationList(
          futureQuestion: _future,
        ),
      ),
    );
  }
}

class ExplainationList extends StatelessWidget {
  const ExplainationList({super.key, required this.futureQuestion});

  final Future<Question> futureQuestion;

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      child: FutureBuilder(
        future: futureQuestion,
        builder: (BuildContext context, AsyncSnapshot<Question> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
                padding: const EdgeInsetsDirectional.only(end: smallSpacing),
                itemCount: snapshot.data!.explanations.length,
                itemBuilder: (context, index) {
                  final item = ComponentGroupDecoration(
                      label: "Explanations",
                      children: [
                        RichContent(snapshot.data!.explanations[index])
                      ]);
                  if (index == 0) {
                    return item;
                  } else {
                    return Column(
                      children: [colDivider, item],
                    );
                  }
                });
          }
        },
      ),
    );
  }
}

class TextStyleExample extends StatelessWidget {
  const TextStyleExample({
    super.key,
    required this.name,
    required this.style,
  });

  final String name;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(name, style: style),
    );
  }
}
