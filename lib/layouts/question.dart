// Copyright 2021 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:open_gmat_database/constants.dart';
import 'package:open_gmat_database/state/database.dart';
import 'package:open_gmat_database/state/preferences.dart';
import 'package:open_gmat_database/widgets/question_detail.dart';
import 'package:provider/provider.dart';

class QuestionScreen extends StatelessWidget {
  QuestionScreen(
      {super.key, required this.railAnimation, required this.showSecondList});
  final bool showSecondList;
  final CurvedAnimation railAnimation;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Row(children: [
      SizedBox(
        width: showSecondList ? 200 : 160,
        child: Sidebar(),
      ),
      Expanded(
        child: Consumer<DatabaseState>(
            builder: (context, state, child) => state.database == null
                ? SizedBox.shrink()
                : QuestionDetail(
                    key: Key(
                        state.questionsByCategory[state.selectedQuestionIndex]),
                    railAnimation: railAnimation,
                    questionId:
                        state.questionsByCategory[state.selectedQuestionIndex],
                    showSecondList: showSecondList,
                  )),
      )
    ]));
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
          return Consumer<PreferencesState>(
              builder: (context, prefState, child) {
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
                ...state.questionsByCategory.map(
                  (id) => NavigationDrawerDestination(
                    label: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(id),
                          if (prefState.isFlagged(id))
                            Expanded(
                                child: Icon(
                              Icons.flag,
                              size: 16.0,
                            ))
                        ],
                      ),
                    ),
                    icon: Icon(prefState.isCompleted(id)
                        ? Icons.rocket_launch
                        : Icons.abc),
                  ),
                )
              ],
            );
          });
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
