import 'package:intl/intl.dart';

DateTime stringToDate(String date) {
  return DateFormat("yyyy/MM/dd").parse(date);
}

String dateToString(DateTime date) {
  return DateFormat("yyyy/MM/dd").format(date);
}
