import 'dart:math';

import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_time_until/time_calculator.dart';

void main() {
  var start = DateTime.utc(2020, 03, 01);
  var end = DateTime.utc(2020, 04, 01);
  var precision = 4;

  test('test difference in years', () {
    var diff = TimeCalc.diffInYears(start, end, precision);
    var value = (31 / 365).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in months', () {
    var diff = TimeCalc.diffInMonths(start, end, precision);
    var value = (31 / 30).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in weeks', () {
    var diff = TimeCalc.diffInWeeks(start, end, precision);
    var value = (31 / 7).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in days', () {
    var diff = TimeCalc.diffInDays(start, end, precision);
    var value = (31).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in hours', () {
    var diff = TimeCalc.diffInHours(start, end, precision);
    var value = (31 * 24).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in minutes', () {
    var diff = TimeCalc.diffInMinutes(start, end, precision);
    var value = (31 * 24 * 60).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in seconds', () {
    var diff = TimeCalc.diffInSeconds(start, end, precision);
    var value = (31 * 24 * 60 * 60).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in medieval moment', () {
    var diff = TimeCalc.diffInMedievalMoment(start, end, precision);
    var value = ((31 * 24 * 60 * 60) / 90).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in Ke', () {
    var diff = TimeCalc.diffInKe(start, end, precision);
    var value =
        ((31 * 24 * 60 * 60) / ((14 * 60) + 24)).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in electronics jiffy', () {
    var diff = TimeCalc.diffInElectronicsJiffy(start, end, precision);
    var value = ((31 * 24 * 60 * 60) / (1 / 60)).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in physics jiffy', () {
    var diff = TimeCalc.diffInPhysicsJiffy(start, end, precision);
    var value = ((31 * 24 * 60 * 60) / (3 * pow(10, -24)))
        .toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in lustrums', () {
    var diff = TimeCalc.diffInLustrum(start, end, precision);
    var value = ((31 / 365) / 5).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in decades', () {
    var diff = TimeCalc.diffInDecades(start, end, precision);
    var value = ((31 / 365) / 10).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in centuries', () {
    var diff = TimeCalc.diffInCenturies(start, end, precision);
    var value = ((31 / 365) / 100).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in millenia', () {
    var diff = TimeCalc.diffInMillennia(start, end, precision);
    var value = ((31 / 365) / 1000).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in megannum', () {
    var diff = TimeCalc.diffInMegannum(start, end, precision);
    var value = ((31 / 365) / pow(10, 6)).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in galactic year', () {
    var diff = TimeCalc.diffInGalacticYear(start, end, precision);
    var value =
        ((31 / 365) / (2.3 * pow(10, 8))).toStringAsPrecision(precision);

    expect(diff, value);
  });

  test('test difference in plank time', () {
    var diff = TimeCalc.diffInPlankTime(start, end, precision);
    var value = ((31 * 24 * 60 * 60) / (5.39 * pow(10, -44)))
        .toStringAsPrecision(precision);

    expect(diff, value);
  });
}
