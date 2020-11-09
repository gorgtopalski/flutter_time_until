import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'wigets/page_widget.dart';
/*
class ApplicationState extends ChangeNotifier {
  DateTime now = DateTime.now();
  DateTime selected;
  bool isSelected = false;
  int precision = 10;
  bool darkTheme = true;
  bool showTime = false;
  TabBuilder tabBuilder = TabBuilder();
  bool updateTimer = true;

  ApplicationState() {
    Timer.periodic(Duration(seconds: 1), updateCurrenTimeCallback);
  }

  void setSelectedDate(DateTime selected, [TimeOfDay time]) {
    if (selected != null) {
      if (time != null) {
        this.selected =
            selected.add(Duration(hours: time.hour, minutes: time.minute));
      } else {
        this.selected = selected;
      }
      isSelected = true;
      notifyListeners();
    }
  }

  void updatePrecission(int precision) {
    this.precision = precision;
    notifyListeners();
  }

  void updateCurrentTime() {
    now = DateTime.now();
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
*/
