import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_time_until/time/time_calculator.dart';

void main() {
  var start = DateTime.utc(2020, 03, 01);
  var end = DateTime.utc(2020, 04, 01);
  var precision = 4;

  test('test difference in years', () {
    var diff = TimeCalculator.diffInYears(start, end, precision);
    var value = (31 / 365).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in months', () {
    var diff = TimeCalculator.diffInMonths(start, end, precision);
    var value = (31 / 30).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in weeks', () {
    var diff = TimeCalculator.diffInWeeks(start, end, precision);
    var value = (31 / 7).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in days', () {
    var diff = TimeCalculator.diffInDays(start, end, precision);
    var value = (31).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in hours', () {
    var diff = TimeCalculator.diffInHours(start, end, precision);
    var value = (31 * 24).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in minutes', () {
    var diff = TimeCalculator.diffInMinutes(start, end, precision);
    var value = (31 * 24 * 60).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in seconds', () {
    var diff = TimeCalculator.diffInSeconds(start, end, precision);
    var value = (31 * 24 * 60 * 60).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in medieval moment', () {
    var diff = TimeCalculator.diffInMedievalMoment(start, end, precision);
    var value = ((31 * 24 * 60 * 60) / 90).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in Ke', () {
    var diff = TimeCalculator.diffInKe(start, end, precision);
    var value =
        ((31 * 24 * 60 * 60) / ((14 * 60) + 24)).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in electronics jiffy', () {
    var diff = TimeCalculator.diffInElectronicsJiffy(start, end, precision);
    var value = ((31 * 24 * 60 * 60) / (1 / 60)).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in physics jiffy', () {
    var diff = TimeCalculator.diffInPhysicsJiffy(start, end, precision);
    var value = ((31 * 24 * 60 * 60) / (3 * pow(10, -24)))
        .toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in lustrums', () {
    var diff = TimeCalculator.diffInLustrum(start, end, precision);
    var value = ((31 / 365) / 5).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in decades', () {
    var diff = TimeCalculator.diffInDecades(start, end, precision);
    var value = ((31 / 365) / 10).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in centuries', () {
    var diff = TimeCalculator.diffInCenturies(start, end, precision);
    var value = ((31 / 365) / 100).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in millenia', () {
    var diff = TimeCalculator.diffInMillennia(start, end, precision);
    var value = ((31 / 365) / 1000).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in megannum', () {
    var diff = TimeCalculator.diffInMegannum(start, end, precision);
    var value = ((31 / 365) / pow(10, 6)).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in galactic year', () {
    var diff = TimeCalculator.diffInGalacticYear(start, end, precision);
    var value =
        ((31 / 365) / (2.3 * pow(10, 8))).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in plank time', () {
    var diff = TimeCalculator.diffInPlankTime(start, end, precision);
    var value = ((31 * 24 * 60 * 60) / (5.39 * pow(10, -44)))
        .toStringAsPrecision(precision);

    expect(diff, value);
  });
}
