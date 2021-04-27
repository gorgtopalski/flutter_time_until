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
    return duration.inDays.toString() + ' days';
  }
}
