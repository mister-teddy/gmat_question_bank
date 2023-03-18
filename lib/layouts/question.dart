// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:open_gmat_database/constants.dart';
import 'package:open_gmat_database/widgets/component_screen.dart';
import 'package:open_gmat_database/state.dart';
import 'package:provider/provider.dart';
import 'package:open_gmat_database/layouts/home.dart';
import 'package:open_gmat_database/models/question.dart';
import 'package:open_gmat_database/widgets/rich_content.dart';
import 'package:http/http.dart' as http;

class QuestionScreen extends StatelessWidget {
  QuestionScreen({
    super.key,
    required this.railAnimation,
  });
  final CurvedAnimation railAnimation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(children: [
      SizedBox(
        width: 200,
        child: Sidebar(),
      ),
      Expanded(
        child: Consumer<DatabaseState>(
            builder: (context, state, child) => state.database == null
                ? SizedBox.shrink()
                : QuestionDetail(
                    railAnimation: railAnimation,
                    questionId:
                        state.questionsByCategory[state.selectedQuestionIndex],
                  )),
      )
    ]));
  }
}

class QuestionDetail extends StatelessWidget {
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
  late final Future<Question> _anotherfuture;

  final CurvedAnimation railAnimation;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<Question> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Container(
              child: OneTwoTransition(
            animation: railAnimation,
            one: FocusTraversalGroup(
              child: SingleChildScrollView(
                child: RichContent(snapshot.data!.question),
              ),
            ),
            two: FocusTraversalGroup(
                child: ListView.builder(
                    padding:
                        const EdgeInsetsDirectional.only(end: smallSpacing),
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
                    })),
          ));
        }
      },
    );
  }
}

class Sidebar extends StatelessWidget {
  const Sidebar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseState>(
      builder: (context, state, child) {
        if (state.database != null) {
          return NavigationDrawer(
            selectedIndex: state.selectedQuestionIndex,
            onDestinationSelected: (value) => state.selectQuestion(value),
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(28, 16, 16, 10),
                child: Text(
                  CategoryNames
                      .values[ScreenSelected.values[state.screenIndex].value]
                      .value,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              ...state.questionsByCategory
                  .map((id) => NavigationDrawerDestination(
                        label: Text(id),
                        icon: Icon(Icons.abc),
                      ))
            ],
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
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
