import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationTimer extends ChangeNotifier {
  // Get stored preferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // This value is set to true after all values are loaded from SharedPreferences store.
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  // Selected date
  DateTime _selected;
  DateTime get selected => _selected;

  // True if the selected date is not null
  bool _isSelected = false;
  bool get isSelected => _isSelected;

  ApplicationTimer() {
    _prefs.then((prefs) {
      var date = prefs.getString('selectedDate') ?? null;
      if (date != null) {
        _selected = DateTime.tryParse(date);
        _isSelected = prefs.getBool('isSelected');
      }
    }).whenComplete(() {
      _isLoaded = true;
      notifyListeners();
    });
  }

  // Saves and updates the selected date
  void setSelectedDate(DateTime selected, [TimeOfDay time]) {
    if (selected != null) {
      if (time != null) {
        selected =
            selected.add(Duration(hours: time.hour, minutes: time.minute));
      }

      // Saves and updates the value if it hasn't changed
      if (_selected != selected) {
        _selected = selected;
        _isSelected = true;
        _prefs.then((prefs) {
          prefs.setBool('isSelected', _isSelected);
          prefs.setString('selectedDate', _selected.toIso8601String());
        }).whenComplete(() => notifyListeners());
      }
    }
  }
}
