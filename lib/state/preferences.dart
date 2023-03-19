import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesState extends ChangeNotifier {
  /// Internal, private state of the cart.
  SharedPreferences? prefs;

  PreferencesState() {
    _init();
  }

  Future _init() async {
    this.prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  bool isCompleted(String questionId) {
    if (prefs != null) {
      return prefs?.getBool("completed.$questionId") ?? false;
    }
    return false;
  }

  void complete(String questionId, bool completed) {
    if (prefs != null) {
      prefs?.setBool("completed.$questionId", completed);
      notifyListeners();
    }
  }

  bool isFlagged(String questionId) {
    if (prefs != null) {
      return prefs?.getBool("flagged.$questionId") ?? false;
    }
    return false;
  }

  void flag(String questionId, bool flagged) {
    if (prefs != null) {
      prefs?.setBool("flagged.$questionId", flagged);
      notifyListeners();
    }
  }
}
