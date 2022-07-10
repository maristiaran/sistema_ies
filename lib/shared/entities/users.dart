// import 'package:flutter/widgets.dart';

class IESUser {
  final int id;
  late String firstname;
  late String surname;
  late DateTime birthdate;
  late int uniqueNumber;
  late bool emailVerified;
  List<UserRole> roles = [];

  IESUser(
      {required this.id,
      required this.firstname,
      required this.surname,
      required this.birthdate,
      required this.uniqueNumber,
      required this.emailVerified,
      required this.roles});
}

class UserRole {
  final IESUser user;
  UserRole({required this.user});
}

class UserRoleOperation {}
