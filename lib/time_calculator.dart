import 'dart:math';

class TimeCalculator {
  final DateTime start, end;
  final int precision;

  TimeCalculator(this.start, this.end, this.precision);

  Map<String, String> get common => {
        'years': TimeCalc.diffInYears(start, end, precision),
        'months': TimeCalc.diffInMonths(start, end, precision),
        'weeks': TimeCalc.diffInWeeks(start, end, precision),
        'days': TimeCalc.diffInDays(start, end, precision),
        'hours': TimeCalc.diffInHours(start, end, precision),
        'minutes': TimeCalc.diffInMinutes(start, end, precision),
        'seconds': TimeCalc.diffInSeconds(start, end, precision),
      };

  Map<String, String> get ancient => {
        'moments': TimeCalc.diffInMedievalMoment(start, end, precision),
        'lustrum': TimeCalc.diffInLustrum(start, end, precision),
        'decades': TimeCalc.diffInDecades(start, end, precision),
        'centuries': TimeCalc.diffInCenturies(start, end, precision),
        'millenia': TimeCalc.diffInMillennia(start, end, precision),
        'ke': TimeCalc.diffInKe(start, end, precision),
      };

  Map<String, String> get scientific => {
        'plank time': TimeCalc.diffInPlankTime(start, end, precision),
        'galactic year': TimeCalc.diffInGalacticYear(start, end, precision),
        'electronic jiffies':
            TimeCalc.diffInElectronicsJiffy(start, end, precision),
        'physics jiffies': TimeCalc.diffInPhysicsJiffy(start, end, precision),
      };
}

class TimeCalc {
  static const int daysInYear = 365;
  static const int daysInMonth = 30;
  static const int daysInWeek = 7;
  static const int _precision = 4;

  static String diffInYears(DateTime start, DateTime end,
      [int precision = _precision]) {
    return ((end.difference(start).inDays) / daysInYear)
        .toStringAsPrecision(precision);
  }

  static String diffInMonths(DateTime start, DateTime end,
      [int precision = _precision]) {
    return ((end.difference(start).inDays) / daysInMonth)
        .toStringAsPrecision(precision);
  }

  static String diffInWeeks(DateTime start, DateTime end,
      [int precision = _precision]) {
    return ((end.difference(start).inDays) / daysInWeek)
        .toStringAsPrecision(precision);
  }

  static String diffInDays(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (end.difference(start).inDays).toStringAsPrecision(precision);
  }

  static String diffInHours(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (end.difference(start).inHours).toStringAsPrecision(precision);
  }

  static String diffInMinutes(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (end.difference(start).inMinutes).toStringAsPrecision(precision);
  }

  static String diffInSeconds(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (end.difference(start).inSeconds).toStringAsPrecision(precision);
  }

  //https://en.wikipedia.org/wiki/Moment_(time)
  static String diffInMedievalMoment(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (end.difference(start).inSeconds / 90)
        .toStringAsPrecision(precision);
  }

  //https://en.wikipedia.org/wiki/Traditional_Chinese_timekeeping
  static String diffInKe(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (end.difference(start).inSeconds / ((14 * 60) + 24))
        .toStringAsPrecision(precision);
  }

  //https://en.wikipedia.org/wiki/Jiffy_(time)
  static String diffInElectronicsJiffy(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (end.difference(start).inSeconds / (1 / 60))
        .toStringAsPrecision(precision);
  }

  //https://en.wikipedia.org/wiki/Jiffy_(time)
  static String diffInPhysicsJiffy(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (((end.difference(start).inSeconds) / (3 * pow(10, -24))))
        .toStringAsPrecision(precision);
  }

  //https://en.wikipedia.org/wiki/Lustrum
  static String diffInLustrum(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (((end.difference(start).inDays / daysInYear) / 5))
        .toStringAsPrecision(precision);
  }

  //https://en.wikipedia.org/wiki/Decade
  static String diffInDecades(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (((end.difference(start).inDays / daysInYear) / 10))
        .toStringAsPrecision(precision);
  }

  //https://en.wikipedia.org/wiki/Century
  static String diffInCenturies(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (((end.difference(start).inDays / daysInYear) / 100))
        .toStringAsPrecision(precision);
  }

  //https://en.wikipedia.org/wiki/Millennium
  static String diffInMillennia(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (((end.difference(start).inDays / daysInYear) / 1000))
        .toStringAsPrecision(precision);
  }

  //https://en.wiktionary.org/wiki/megayear
  static String diffInMegannum(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (((end.difference(start).inDays / daysInYear) / pow(10, 6)))
        .toStringAsPrecision(precision);
  }

  //https://en.wikipedia.org/wiki/Galactic_year
  static String diffInGalacticYear(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (((end.difference(start).inDays / daysInYear) / (2.3 * pow(10, 8))))
        .toStringAsPrecision(precision);
  }

  //https://en.wikipedia.org/wiki/Planck_units#Planck_time
  static String diffInPlankTime(DateTime start, DateTime end,
      [int precision = _precision]) {
    return (end.difference(start).inSeconds / (5.39 * pow(10, -44)))
        .toStringAsPrecision(precision);
  }
}
