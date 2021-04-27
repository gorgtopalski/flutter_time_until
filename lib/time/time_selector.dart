import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SelectDateTime {
  static int _yearOffset = 100;

  static Future<DateTime?> selectDate(
    BuildContext context, {
    DateTime? initialDate,
  }) {
    if (initialDate == null) {
      initialDate = DateTime.now();
    }
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(initialDate.year - _yearOffset),
      lastDate: DateTime(initialDate.year + _yearOffset),
    );
  }
}
