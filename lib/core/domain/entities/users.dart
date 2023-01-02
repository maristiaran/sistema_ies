// import 'package:collection/collection.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
// import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';

class IESUser {
  final dynamic id;
  final String firstname;
  final String surname;
  final DateTime birthdate;
  final int dni;
  final String email;
  List<UserRole> roles = [];
  UserRole? defaultRole;

  IESUser(
      {required this.id,
      required this.firstname,
      required this.surname,
      required this.dni,
      required this.birthdate,
      required this.email,
      required this.roles,
      required this.defaultRole});

  addRole(UserRole newRole) {
    if ((roles.length == 1) &&
        (roles.first.userRoleTypeName() == UserRoleTypeName.guest)) {
      roles.removeAt(0);
      defaultRole = newRole;
    }
    roles.add(newRole);
  }

  // Student? studentRoleIfAny() {
  //   UserRole? studentRoleIfAny = roles.firstWhereOrNull(
  //       (userRole) => userRole.userRoleTypeName() == UserRoleTypeName.student);
  //   if (studentRoleIfAny == null) {
  //     return null;
  //   } else {
  //     return studentRoleIfAny as Student;
  //   }
  // }

  List<Syllabus> studentRolesSyllabuses() {
    return roles
        .where((aRole) => aRole.userRoleTypeName() == UserRoleTypeName.student)
        .map((aStudent) => (aStudent as Student).syllabus)
        .toList();
  }

  UserRole getDefaultRole() {
    return defaultRole ?? roles[0];
  }
}
