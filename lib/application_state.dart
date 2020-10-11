import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'time_calculator.dart';
import 'wigets/page_widget.dart';

class ApplicationState extends ChangeNotifier {
  DateTime now = DateTime.now();
  DateTime selected;
  bool isSelected = false;
  int precision = 2;
  bool darkTheme = true;
  bool showTime = false;
  TabBuilder tabBuilder;

  ApplicationState() {
    Timer.periodic(Duration(seconds: 1), updateCurrenTimeCallback);
  }

  void _updateTabBuilder() {
    tabBuilder = TabBuilder(TimeCalculator(now, selected, precision));
  }

  void setSelectedDate(DateTime selected) {
    if (selected != null) {
      this.selected = selected;
      isSelected = true;
      _updateTabBuilder();
      notifyListeners();
    }
  }

  void addTimeToSelectedDate(TimeOfDay time) {
    if (time != null && selected != null) {
      selected = selected.add(Duration(hours: time.hour, minutes: time.minute));
      _updateTabBuilder();
      notifyListeners();
    }
  }

  void updatePrecission(int precision) {
    this.precision = precision;
    _updateTabBuilder();
    notifyListeners();
  }

  void updateCurrentTime() {
    now = DateTime.now();
    _updateTabBuilder();
    notifyListeners();
  }

  void updateCurrenTimeCallback(Timer t) {
    updateCurrentTime();
  }

  void changeTheme(bool dark) {
    darkTheme = dark;
    notifyListeners();
  }

  void showTimePicker(bool time) {
    showTime = time;
    notifyListeners();
  }
}
