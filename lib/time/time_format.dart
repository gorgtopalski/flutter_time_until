import 'package:intl/intl.dart';

class TimeFormat {
  static DateFormat dateFormat = new DateFormat.yMd();
  static DateFormat dateFormatWithTime = new DateFormat.yMd().add_Hm();

  static String formatDate(DateTime date) {
    if (date.minute == 0 && date.hour == 0) {
      return dateFormat.format(date);
    } else {
      return dateFormatWithTime.format(date);
    }
  }

  static String formatDuration(Duration duration) {
    String value = '';

    if (duration.abs().inDays > 1) {
      value = duration.inDays.toString() + ' days';
    } else {
      if (duration.abs().inHours > 1) {
        value = duration.inHours.toString() + ' hours';
      } else {
        if (duration.abs().inMinutes > 1) {
          value = duration.inMinutes.toString() + ' minutes';
        } else {
          value = duration.inSeconds.toString() + ' seconds';
        }
      }
    }

    //duration.isNegative ? value += ' ago' : value += ' remaining';
    return value;
  }
}
