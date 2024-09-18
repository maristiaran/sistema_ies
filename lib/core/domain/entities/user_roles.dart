import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';

enum UserRoleTypeName {
  guest,
  incomingStudent,
  student,
  teacher,
  administrative,
  manager
}

class UserRoleType {
  // final IESUser user;
  UserRoleTypeName name;
  String title;
  List<UserRoleOperationName> operationNames;

  UserRoleType(
      {required this.name, required this.title, required this.operationNames});

  String subtitle() {
    return '';
  }
  // operationTitles() {
  //   RolesAndOperationsRepositoryPort operationsRepository =
  //       IESSystem().getRolesAndOperationsRepository();
  //   return operationNames
  //       .map((op) => operationsRepository.getUserRoleOperations(this))
  //       .toList();
  // }
}

// UserRoleType userRoleTypeNamed(UserRoleTypeName userRoleTypeName){
//  switch( userRoleTypeName) {
//    case UserRoleTypeName.administrative: {
//       // statements;
//    }
//    break;

//    case constant_expr2: {
//       //statements;
//    }
//    break;

//    default: {
//       //statements;
//    }
//    break;
// }
// }
abstract class UserRole {
  UserRoleTypeName userRoleTypeName();
  String subtitle() {
    return '';
  }
}

class Guest extends UserRole {
  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.guest;
  }

  @override
  String toString() {
    return 'Invitado';
  }
}

class IncomingStudent extends UserRole {
  IncomingStudent();

  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.incomingStudent;
  }

  @override
  String toString() {
    return 'Ingresante';
  }
}

class Teacher extends UserRole {
  Syllabus syllabus;
  List<Subject> subjects;

  Teacher({required this.syllabus, required this.subjects});

  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.teacher;
  }

  @override
  String toString() {
    return 'Docente';
  }

  List<String> get syllabusIDs =>
      subjects.map((aSubject) => aSubject.syllabusID).toSet().toList();
  // List<Syllabus> get syllabuses {
  //   List<Syllabus> newSyllabuses = [];
  //   for (var syllabusID in syllabusIDs) {
  //     syllabusesRepository
  //         .getSyllabusByAdministrativeResolution(
  //             administrativeResolution: syllabusID)
  //         .fold((left) {}, (right) {
  //       newSyllabuses.add(right);
  //     });
  //   }
  //   return newSyllabuses;
  // }
  @override
  String subtitle() {
    return syllabus.name;
  }
}

class Administrative extends UserRole {
  Syllabus syllabus;

  Administrative({required this.syllabus});

  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.administrative;
  }

  @override
  String toString() {
    return 'Administrativo';
  }

  @override
  String subtitle() {
    return syllabus.name;
  }
}

class Manager extends UserRole {
  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.manager;
  }

  @override
  String toString() {
    return 'Directivo';
  }
}
