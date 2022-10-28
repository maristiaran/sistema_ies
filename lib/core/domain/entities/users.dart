import 'package:sistema_ies/core/domain/entities/user_roles.dart';

class IESUser {
  final String firstname;
  final String surname;
  final DateTime birthdate;
  final int dni;
  final String email;
  List<UserRole> roles = [];
  late UserRole defaultRole;

  IESUser(
      {required this.firstname,
      required this.surname,
      required this.dni,
      required this.birthdate,
      required this.email});

  addRole(UserRole newRole) {
    if ((roles.length == 1) &&
        (roles.first.userRoleTypeName() == UserRoleTypeName.guest)) {
      roles.removeAt(0);
      defaultRole = newRole;
    }
    roles.add(newRole);
  }
}
