import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class ApplicationPreferences extends ChangeNotifier {
  //Get stored preferences
  late Box _prefs = Hive.box('prefs');

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
  late Timer _timer;

  ApplicationPreferences() {
    _precision = _prefs.get('precision', defaultValue: 10);
    _isDarkThemeSelected =
        _prefs.get('isDarkThemeSelected', defaultValue: true);
    _isTimerUpdate = _prefs.get('isTimerUpdate', defaultValue: true);

    if (_isTimerUpdate) {
      _timer = Timer.periodic(Duration(seconds: 1), _updateNow);
    }

    notifyListeners();
  }

  // Increments precision by one
  void incrementPrecision() {
    if (precision < 21) {
      _precision++;
      _prefs.put('precision', _precision);
      notifyListeners();
    }
  }

  // Decrements precision by one
  void decrementPrecision() {
    if (precision > 1) {
      _precision--;
      _prefs.put('precision', _precision);
      notifyListeners();
    }
  }

  // Toggle the used theme
  void toggleTheme() {
    _isDarkThemeSelected = !_isDarkThemeSelected;
    _prefs.put('darkTheme', _isDarkThemeSelected);
    notifyListeners();
  }

  // Toggle the timer update
  void toggleTimerUpdate() {
    _isTimerUpdate = !_isTimerUpdate;
    _prefs.put('isTimerUpdate', _isTimerUpdate);

    _isTimerUpdate
        ? _timer = Timer.periodic(Duration(seconds: 1), _updateNow)
        : _timer.cancel();

    notifyListeners();
  }

  // Timer update callback
  void _updateNow(Timer t) {
    _now = DateTime.now();
    notifyListeners();
  }
}
