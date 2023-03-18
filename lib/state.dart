import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:open_gmat_database/constants.dart';
import 'package:open_gmat_database/models/database.dart';
import 'package:http/http.dart' as http;

class DatabaseState extends ChangeNotifier {
  /// Internal, private state of the cart.
  Database? database;
  int selectedQuestionIndex = 0;
  int screenIndex = ScreenSelected.ds.value;

  DatabaseState() {
    _init();
  }

  Future _init() async {
    final value = await http.get(Uri.parse(
        'https://nguyenhongphat0.github.io/gmat-database/index.json'));
    final database = Database.fromJson(jsonDecode(value.body));
    this.database = database;
    print(database);
    notifyListeners();
  }

  void changeScreen(int screenSelected) {
    screenIndex = screenSelected;
    notifyListeners();
  }

  void selectQuestion(int index) {
    this.selectedQuestionIndex = index;
    notifyListeners();
  }

  List<String> get questionsByCategory {
    if (this.database != null) {
      final database = this.database!;
      switch (ScreenSelected.values[screenIndex]) {
        case ScreenSelected.cr:
          return database.cr;
        case ScreenSelected.ds:
          return database.ds;
        case ScreenSelected.ps:
          return database.ps;
        case ScreenSelected.sc:
          return database.sc;
        case ScreenSelected.rc:
          return database.rc;
      }
    }
    return [];
  }
}
