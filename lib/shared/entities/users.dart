// import 'package:flutter/widgets.dart';

class User {
  final int id;
  late String firstname;
  late String surname;
  late DateTime birthdate;
  late int uniqueNumber;
  List<UserRole> roles = [];

  User(
      {required this.id,
      required this.firstname,
      required this.surname,
      required this.birthdate,
      required this.uniqueNumber,
      required this.roles});
}

class UserRole {}
