import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationPreferences extends ChangeNotifier {
  //Get stored preferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  int precision = 10;
  bool darkTheme = true;
  bool showTime = false;
  bool updateTimer = true;
  bool _isLoaded = false;

  bool get isLoaded => _isLoaded;

  DateTime _now = DateTime.now();
  DateTime get now => _now;

  Timer _timer;

  ApplicationPreferences() {
    _prefs.then((prefs) {
      precision = prefs.getInt('precision') ?? 10;
      darkTheme = prefs.getBool('darkTheme') ?? true;
      showTime = prefs.getBool('showTime') ?? false;
      updateTimer = prefs.getBool('updateTimer') ?? true;
    }).whenComplete(() {
      if (updateTimer) {
        _timer = Timer.periodic(Duration(seconds: 1), _updateNow);
      }
    }).whenComplete(() {
      _isLoaded = true;
      notifyListeners();
    });
  }

  void _updateNow(Timer t) {
    _now = DateTime.now();
    notifyListeners();
  }

  void showTimeSelection(bool toShow) {
    if (showTime != toShow) {
      showTime = toShow;
      _prefs.then((value) => value.setBool('showTimer', showTime));
      notifyListeners();
    }
  }

  void changePrecision(int precision) {
    if (this.precision != precision) {
      this.precision = precision;
      _prefs.then((value) => value.setInt('precision', this.precision));
      notifyListeners();
    }
  }

  void changeTheme(bool theme) {
    if (darkTheme != theme) {
      this.darkTheme = theme;
      _prefs.then((value) => value.setBool('darkTheme', darkTheme));
      notifyListeners();
    }
  }

  void toggleTimerUpdate() {
    updateTimer = !updateTimer;
    _prefs.then((value) => value.setBool('updateTimer', updateTimer));
    notifyListeners();
    if (!updateTimer && _timer.isActive) {
      _timer.cancel();
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), _updateNow);
    }
  }
}
