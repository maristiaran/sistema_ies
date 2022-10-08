// import 'package:flutter/widgets.dart';

import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';

class IESUser {
  late String firstname;
  late String surname;
  late DateTime birthdate;
  late int dni;
  late String email;
  List<UserRole> roles = [GuestUserRole()];
  UserRole defaultRole = GuestUserRole();

  IESUser(
      {required this.firstname,
      required this.surname,
      required this.dni,
      required this.birthdate,
      required this.email});

  addRole(UserRole newRole) {
    if ((roles.length == 1) &&
        (roles.first.userRoleName() == UserRoleNames.guest)) {
      roles.removeAt(0);
      defaultRole = newRole;
    }
    roles.add(newRole);
  }
}

enum UserRoleNames {
  student,
  teacher,
  systemAdmin,
  administrative,
  manager,
  guest
}

abstract class UserRole {
  // final IESUser user;
  Enum userRoleName();
  List<UserRoleOperation> userRoleOperations = [];
  // UserRole({required this.user});
  UserRole();
}

class GuestUserRole extends UserRole {
  @override
  Enum userRoleName() {
    return UserRoleNames.teacher;
  }
}
