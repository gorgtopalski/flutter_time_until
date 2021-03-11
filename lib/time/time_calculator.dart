import 'dart:math';

class TimeCalculator {
  static const int daysInYear = 365;
  static const int daysInMonth = 30;
  static const int daysInWeek = 7;
  static const int _precision = 4;
  static const int secondsInDay = 86400;

  // Common units of time

  static _diff(DateTime start, DateTime end) => end.difference(start).inSeconds;

  static _diffYears(DateTime start, DateTime end) =>
      end.difference(start).inSeconds / (daysInYear * secondsInDay);

  static String? diffInYears(DateTime start, DateTime end,
      [int precision = _precision]) {
    return _diffYears(start, end).toStringAsPrecision(precision);
  }

  static String? diffInMonths(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (_diff(start, end) / (daysInMonth * secondsInDay))
        .toStringAsPrecision(precision);
  }

  static String? diffInWeeks(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (_diff(start, end) / (daysInWeek * secondsInDay))
        .toStringAsPrecision(precision);
  }

  static String? diffInDays(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (_diff(start, end) / secondsInDay).toStringAsPrecision(precision);
  }

  static String? diffInHours(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (_diff(start, end) / (60 * 60)).toStringAsPrecision(precision);
  }

  static String? diffInMinutes(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (_diff(start, end) / 60).toStringAsPrecision(precision);
  }

  static String diffInSeconds(DateTime start, DateTime end,
      [int precision = _precision]) {
    return _diff(start, end).toString();
  }

  // Ancient units of time

  // https://en.wikipedia.org/wiki/Moment_(time)
  static String? diffInMedievalMoment(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (_diff(start, end) / 90).toStringAsPrecision(precision);
  }

  //https://en.wikipedia.org/wiki/Lustrum
  static String? diffInLustrum(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (_diffYears(start, end) / 5).toStringAsPrecision(precision);
  }

  // https://en.wikipedia.org/wiki/Decade
  static String? diffInDecades(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (_diffYears(start, end) / 10).toStringAsPrecision(precision);
  }

  // https://en.wikipedia.org/wiki/Century
  static String? diffInCenturies(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (_diffYears(start, end) / 100).toStringAsPrecision(precision);
  }

  // https://en.wikipedia.org/wiki/Millennium
  static String? diffInMillennia(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (_diffYears(start, end) / 1000).toStringAsPrecision(precision);
  }

  // https://en.wikipedia.org/wiki/Traditional_Chinese_timekeeping
  static String? diffInKe(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (_diff(start, end) / ((14.4 * 60) + 24))
        .toStringAsPrecision(precision);
  }

  // https://en.wiktionary.org/wiki/megayear
  static String? diffInMegannum(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (_diffYears(start, end) / pow(10, 6)).toStringAsPrecision(precision);
  }

  // Scientific units of time

  //https://en.wikipedia.org/wiki/Galactic_year
  static String? diffInGalacticYear(DateTime start, DateTime end,
      [int precision = _precision]) {
    return ((_diffYears(start, end) / (2.3 * pow(10, 8))))
        .toStringAsPrecision(precision);
  }

  // https://en.wikipedia.org/wiki/Planck_units#Planck_time
  static String diffInPlankTime(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (end.difference(start).inSeconds / (5.39 * pow(10, -44)))
        .toStringAsPrecision(precision);
  }

  // https://en.wikipedia.org/wiki/Jiffy_(time)
  static String diffInElectronicsJiffy(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (end.difference(start).inSeconds / (1 / 60))
        .toStringAsPrecision(precision);
  }

  // https://en.wikipedia.org/wiki/Jiffy_(time)
  static String diffInPhysicsJiffy(DateTime start, DateTime end,
      [int precision = _precision]) {
    return ((end.difference(start).inSeconds / (3 * pow(10, -24))))
        .toStringAsPrecision(precision);
  }
}
