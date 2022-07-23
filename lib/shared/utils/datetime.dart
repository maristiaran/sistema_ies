String dateToString(DateTime date) {
  return '${date.day}/${date.month}/${date.year}';
}

DateTime stringToDate(String date) {
  List<String> dayMonthYear = date.split('/');
  return DateTime(int.parse(dayMonthYear[2]), int.parse(dayMonthYear[1]),
      int.parse(dayMonthYear[0]));
}
