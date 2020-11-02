import 'package:flutter_time_until/time/time_calculator.dart';

class TimeUntil {
  final DateTime start, end;
  final int precision;

  TimeUntil(this.start, this.end, this.precision);

  Map<String, String> get common => {
        'years': TimeCalculator.diffInYears(start, end, precision),
        'months': TimeCalculator.diffInMonths(start, end, precision),
        'weeks': TimeCalculator.diffInWeeks(start, end, precision),
        'days': TimeCalculator.diffInDays(start, end, precision),
        'hours': TimeCalculator.diffInHours(start, end, precision),
        'minutes': TimeCalculator.diffInMinutes(start, end, precision),
        'seconds': TimeCalculator.diffInSeconds(start, end, precision),
      };

  Map<String, String> get ancient => {
        'moments': TimeCalculator.diffInMedievalMoment(start, end, precision),
        'lustrum': TimeCalculator.diffInLustrum(start, end, precision),
        'decades': TimeCalculator.diffInDecades(start, end, precision),
        'centuries': TimeCalculator.diffInCenturies(start, end, precision),
        'millenia': TimeCalculator.diffInMillennia(start, end, precision),
        'ke': TimeCalculator.diffInKe(start, end, precision),
      };

  Map<String, String> get scientific => {
        'plank time': TimeCalculator.diffInPlankTime(start, end, precision),
        'galactic year':
            TimeCalculator.diffInGalacticYear(start, end, precision),
        'electronic jiffies':
            TimeCalculator.diffInElectronicsJiffy(start, end, precision),
        'physics jiffies':
            TimeCalculator.diffInPhysicsJiffy(start, end, precision),
      };
}
