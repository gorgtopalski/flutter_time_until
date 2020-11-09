import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationPreferences extends ChangeNotifier {
  //Get stored preferences
  SharedPreferences _prefs;

  int precision = 10;
  bool darkTheme = true;
  bool showTime = false;
  bool updateTimer = true;
  DateTime now = DateTime.now();
  Timer _timer;

  ApplicationPreferences() {
    SharedPreferences.getInstance()
        .then((value) => _prefs = value)
        .whenComplete(() => _load());
  }

  _load() {
    precision = _prefs.getInt('precision') ?? 10;
    darkTheme = _prefs.getBool('darkTheme') ?? true;
    showTime = _prefs.getBool('showTime') ?? false;
    updateTimer = _prefs.getBool('updateTimer') ?? true;

    if (updateTimer) {
      _timer = Timer.periodic(Duration(seconds: 1), updateCurrenTimeCallback);
    }
  }

  void updateCurrentTime() {
    now = DateTime.now();
    notifyListeners();
  }

  void updateCurrenTimeCallback(Timer t) {
    updateCurrentTime();
  }

  void showTimeSelection(bool toShow) {
    if (showTime != toShow) {
      showTime = toShow;
      //_prefs.then((value) => value.setBool('showTimer', showTime));
      notifyListeners();
    }
  }

  void changePrecision(int precision) {
    if (this.precision != precision) {
      this.precision = precision;
      //_prefs.then((value) => value.setInt('precision', this.precision));
      notifyListeners();
    }
  }

  void changeTheme(bool theme) {
    if (darkTheme != theme) {
      this.darkTheme = theme;
      //_prefs.then((value) => value.setBool('darkTheme', darkTheme));
      notifyListeners();
    }
  }

  void changeTimerUpdate(bool timer) {
    if (updateTimer != timer) {
      if (!updateTimer) {
        if (_timer.isActive) {
          _timer.cancel();
        }
      } else {
        _timer = Timer.periodic(Duration(seconds: 1), updateCurrenTimeCallback);
      }

      updateTimer = timer;
      //_prefs.then((value) => value.setBool('updateTimer', updateTimer));
      notifyListeners();
    }
  }
}
