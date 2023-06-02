import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

DateTime stringToDate(String date) {
  return DateFormat("yyyy/MM/dd").parse(date);
}

String dateToString(DateTime date) {
  return DateFormat("yyyy/MM/dd").format(date);
}

DateTime timestampToDate(Timestamp date) {
  DateTime dateTime = date.toDate();
  return dateTime;
}
