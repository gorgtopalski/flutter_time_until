import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationTimer extends ChangeNotifier {
  //Get stored preferences
  SharedPreferences _prefs;
  DateTime selected;
  bool isSelected = false;

  ApplicationTimer() {
    SharedPreferences.getInstance()
        .then((value) => _prefs = value)
        .whenComplete(() => _load());
  }

  void _load() {
    var date = _prefs.getString('selectedDate') ?? null;
    if (date != null) {
      selected = DateTime.tryParse(date);
      isSelected = _prefs.getBool('isSelected');
    }
  }

  void setSelectedDate(DateTime selected, [TimeOfDay time]) {
    if (selected != null) {
      if (time != null) {
        selected =
            selected.add(Duration(hours: time.hour, minutes: time.minute));
      }

      if (this.selected != selected) {
        this.selected = selected;
        isSelected = true;
        _prefs.setBool('isSelected', isSelected);
        _prefs.setString('selectedDate', selected.toIso8601String());
        notifyListeners();
      }
    }
  }
}
