import 'package:intl/intl.dart';

class AppDateUtils {
  AppDateUtils._();

  static String formatDurationDate(DateTime date) {
    return DateFormat('yyyy-MM-dd hh:mm').format(date);
  }
}
