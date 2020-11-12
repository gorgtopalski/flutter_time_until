import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationPreferences extends ChangeNotifier {
  //Get stored preferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // This value is set to true after all values are loaded from SharedPreferences store.
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  // Controls the precision of the calculation
  int _precision = 10;
  int get precision => _precision;

  // Controls if dark theme is selected
  bool _isDarkThemeSelected = true;
  bool get darkTheme => _isDarkThemeSelected;

  // Current date time for remaing time calculation
  DateTime _now = DateTime.now();
  DateTime get now => _now;

  // Controls if the current time is updates generating the countdown animation
  bool _isTimerUpdate = true;
  bool get isTimerUpdate => _isTimerUpdate;

  // Timer that updates the current time each second
  Timer _timer;

  // Controls if time selection is shown
  bool _isShowTime = false;
  bool get isShowTime => _isShowTime;

  ApplicationPreferences() {
    _prefs.then((prefs) {
      _precision = prefs.getInt('precision') ?? 10;
      _isDarkThemeSelected = prefs.getBool('isDarkThemeSelected') ?? true;
      _isShowTime = prefs.getBool('isShowTime') ?? false;
      _isTimerUpdate = prefs.getBool('isTimerUpdate') ?? true;
    }).whenComplete(() {
      if (_isTimerUpdate) {
        _timer = Timer.periodic(Duration(seconds: 1), _updateNow);
      }
    }).whenComplete(() {
      _isLoaded = true;
      notifyListeners();
    });
  }

  void toogleTimeSelection() {
    _isShowTime = !_isShowTime;
    _prefs
        .then((value) => value.setBool('isShowTime', _isShowTime))
        .whenComplete(() => notifyListeners());
  }

  void incrementPrecision() {
    if (precision < 21) {
      _precision++;
      _prefs
          .then((value) => value.setInt('precision', this._precision))
          .whenComplete(() => notifyListeners());
    }
  }

  void decrementPrecision() {
    if (precision > 1) {
      _precision--;
      _prefs
          .then((value) => value.setInt('precision', this._precision))
          .whenComplete(() => notifyListeners());
    }
  }

  void toggleTheme() {
    _isDarkThemeSelected = !_isDarkThemeSelected;
    _prefs
        .then((value) => value.setBool('darkTheme', _isDarkThemeSelected))
        .whenComplete(() => notifyListeners());
  }

  void toggleTimerUpdate() {
    _isTimerUpdate = !_isTimerUpdate;
    _prefs
        .then((value) => value.setBool('isTimerUpdate', _isTimerUpdate))
        .whenComplete(() {
      if (!_isTimerUpdate && _timer.isActive) {
        _timer.cancel();
      } else {
        _timer = Timer.periodic(Duration(seconds: 1), _updateNow);
      }
    }).whenComplete(() => notifyListeners());
  }

  void _updateNow(Timer t) {
    _now = DateTime.now();
    notifyListeners();
  }
}
