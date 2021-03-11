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
  DateTime _selected = DateTime.now();
  DateTime get selected => _selected;

  // True if the selected date is not null
  bool _isSelected = false;
  bool get isSelected => _isSelected;

  ApplicationTimer() {
    _prefs.then((prefs) {
      //Load the saved date if any
      var date = prefs.getString('selectedDate') ?? '';
      _selected = DateTime.tryParse(date) ?? DateTime.now();

      //Load the selected toggle
      _isSelected = prefs.getBool('isSelected') ?? false;
    }).whenComplete(() {
      //Data is loaded
      _isLoaded = true;
      notifyListeners();
    });
  }

  // Saves and updates the selected date
  void setSelectedDate(DateTime? selectedDate,
      [TimeOfDay? selectedTime = const TimeOfDay(hour: 0, minute: 0)]) {
    //Add the time of day to the selected date
    if (selectedTime != const TimeOfDay(hour: 0, minute: 0)) {
      selectedDate = selectedDate!.add(
          Duration(hours: selectedTime!.hour, minutes: selectedTime.minute));
    }

    // Saves and updates the value if it hasn't changed
    if (_selected != selectedDate) {
      _isSelected = true;
      _selected = selectedDate!;

      _prefs.then((prefs) {
        prefs.setBool('isSelected', _isSelected);
        prefs.setString('selectedDate', _selected.toIso8601String());
      }).whenComplete(() => notifyListeners());
    }
  }

  void reset() {
    //Set selected to false
    _isSelected = false;

    _prefs.then((prefs) {
      //Persist it to disk
      prefs.setBool('isSelected', _isSelected);
    }).whenComplete(() => notifyListeners());
  }
}
