import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApplicationTimer extends ChangeNotifier {
  // Get stored preferences
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  // Indicates that loading the stored values is complete
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

  void setSelectedDate(DateTime selected, [TimeOfDay time]) {
    if (selected != null) {
      if (time != null) {
        selected =
            selected.add(Duration(hours: time.hour, minutes: time.minute));
      }

      if (_selected != selected) {
        _selected = selected;
        _isSelected = true;
        _prefs.then((value) => value.setBool('isSelected', _isSelected));
        _prefs.then((value) =>
            value.setString('selectedDate', _selected.toIso8601String()));
        notifyListeners();
      }
    }
  }
}
