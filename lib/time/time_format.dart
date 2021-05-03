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
    /*
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
    */

    String value = '';

    if (duration.abs().inDays > 0) {
      value = duration.abs().inDays.toString() + ' days';
      //int remaining = duration.abs().inHours - duration.abs().inDays * 24;
    }

    if (duration.abs().inHours > 0) {
      int remaining = duration.abs().inHours - duration.abs().inDays * 24;
      value += ' ' + remaining.toString() + ' hours';
    }

    if (duration.abs().inMinutes > 0) {
      int remaining = duration.abs().inMinutes - duration.abs().inHours * 60;
      value += ' ' + remaining.toString() + ' minutes';
    }

    if (duration.abs().inSeconds > 0) {
      int remaining = duration.abs().inSeconds - duration.abs().inMinutes * 60;
      value += ' ' + remaining.toString() + ' seconds';
    }

    //duration.isNegative ? value += ' ago' : value += ' remaining';
    return value;
  }
}
