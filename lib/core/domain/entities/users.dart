// import 'package:collection/collection.dart';
// import 'package:sistema_ies/core/domain/entities/syllabus.dart';
// import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';

enum Documents {
  idPhotocopy,
  photcopyBirthCertificate,
  passportPhoto,
  analytical,
  psychophysical,
  vaccinationCertificate
}

class IESUser {
  final dynamic id;
  final String firstname;
  final String surname;
  final DateTime birthdate;
  final int dni;
  final String email;
  final Map<Documents, bool> documents = {
    Documents.idPhotocopy: false,
    Documents.photcopyBirthCertificate: false,
    Documents.passportPhoto: false,
    Documents.analytical: false,
    Documents.psychophysical: false,
    Documents.vaccinationCertificate: false
  };
  List<UserRole> roles = [];
  // UserRole? defaultRole;
  int currentRoleIndex = 0;

  IESUser(
      {required this.id,
      required this.firstname,
      required this.surname,
      required this.dni,
      required this.birthdate,
      required this.email,
      required this.roles,
      this.currentRoleIndex = 0});

  addRole(UserRole newRole) {
    if ((roles.length == 1) &&
        (roles.first.userRoleTypeName() == UserRoleTypeName.guest)) {
      roles.removeAt(0);
      // defaultRole = newRole;
    }
    roles.add(newRole);
  }

  registerDocumentation(document) {
    if (documents.containsKey(document)) {
      documents[document] = true;
    }
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

  UserRole getCurrentRole() {
    return roles[currentRoleIndex];
  }

  UserRole changeToNextRole() {
    if (roles.length == (currentRoleIndex + 1)) {
      currentRoleIndex = 0;
    } else {
      currentRoleIndex += 1;
    }
    return roles[currentRoleIndex];
  }
}
