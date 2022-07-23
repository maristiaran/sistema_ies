// import 'package:flutter/widgets.dart';

class IESUser {
  late String firstname;
  late String surname;
  late DateTime birthdate;
  late int dni;
  late String email;
  List<UserRole> roles = [];

  IESUser(
      {required this.firstname,
      required this.surname,
      required this.dni,
      required this.birthdate,
      required this.email});

  addRole(UserRole newRole) {
    roles.add(newRole);
  }
}

enum UserRoleNames { student, teacher, systemAdmin, administrative, manager }

abstract class UserRole {
  final IESUser user;
  Enum userRoleName();
  UserRole({required this.user});
}
