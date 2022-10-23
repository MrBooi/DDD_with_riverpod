import 'package:intl/intl.dart';

class DateTimeFormat {
  static String dateFormat(DateTime date) {
    final dif = DateTime.now().difference(date);

    if (dif < const Duration(days: 1)) {
      return DateFormat('hh:mm a').format(date);
    } else if (dif < const Duration(days: 10)) {
      return DateFormat('EEE d').format(date);
    } else {
      return DateFormat('MMM d').format(date);
    }
  }
}
