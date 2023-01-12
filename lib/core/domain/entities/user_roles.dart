import 'package:sistema_ies/core/domain/entities/student_record_entries.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';

enum UserRoleTypeName {
  guest,
  incomingStudent,
  student,
  teacher,
  administrative,
  manager,
  systemAdmin
}

class UserRoleType {
  // final IESUser user;
  UserRoleTypeName name;
  String title;
  List<UserRoleOperationName> operationNames;

  UserRoleType(
      {required this.name, required this.title, required this.operationNames});

  // operationTitles() {
  //   RolesAndOperationsRepositoryPort operationsRepository =
  //       IESSystem().getRolesAndOperationsRepository();
  //   return operationNames
  //       .map((op) => operationsRepository.getUserRoleOperations(this))
  //       .toList();
  // }
}

abstract class UserRole {
  UserRoleTypeName userRoleTypeName();
}

class Guest extends UserRole {
  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.guest;
  }
}

class IncomingStudent extends UserRole {
  IncomingStudent();

  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.incomingStudent;
  }
}

class Student extends UserRole {
  Syllabus syllabus;
  List<StudentEvent> studentEvents = [];

  Student({required this.syllabus});
  Student.forTesting({required this.syllabus}) {
    List<StudentEvent> sEvents = [];

    sEvents.add(StudentEvent.finalExamApproved(
        subject: syllabus.getSubjectIfAnyByID(1)!,
        date: DateTime(2021, 12, 11),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));
    sEvents.add(StudentEvent.finalExamApproved(
        subject: syllabus.getSubjectIfAnyByID(1)!,
        date: DateTime(2021, 12, 9),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));
    sEvents.add(StudentEvent.finalExamApproved(
        subject: syllabus.getSubjectIfAnyByID(1)!,
        date: DateTime(2021, 12, 9),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));
    sEvents.add(StudentEvent.finalExamApproved(
        subject: syllabus.getSubjectIfAnyByID(1)!,
        date: DateTime(2021, 12, 9),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));
    sEvents.add(StudentEvent.finalExamApproved(
        subject: syllabus.getSubjectIfAnyByID(1)!,
        date: DateTime(2021, 12, 9),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));
    sEvents.add(StudentEvent.finalExamApproved(
        subject: syllabus.getSubjectIfAnyByID(1)!,
        date: DateTime(2021, 12, 9),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));

    sEvents.add(StudentEvent.finalExamApproved(
        subject: syllabus.getSubjectIfAnyByID(1)!,
        date: DateTime(2021, 12, 12),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));
    sEvents.add(StudentEvent.finalExamApprovedByCertification(
        subject: syllabus.getSubjectIfAnyByID(2)!,
        date: DateTime(2020, 12, 9),
        numericalGrade: 10,
        certificationResolution: '85CO20'));
    sEvents.add(StudentEvent.finalExamApproved(
        subject: syllabus.getSubjectIfAnyByID(3)!,
        date: DateTime(2020, 8, 3),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 1));
    sEvents.add(StudentEvent.finalExamApproved(
        subject: syllabus.getSubjectIfAnyByID(4)!,
        date: DateTime(2020, 12, 16),
        numericalGrade: 8,
        bookNumber: 1,
        pageNumber: 9));

    sEvents.add(StudentEvent.finalExamApprovedByCertification(
        subject: syllabus.getSubjectIfAnyByID(5)!,
        date: DateTime(2020, 12, 9),
        numericalGrade: 9,
        certificationResolution: '85CO20'));

    sEvents.add(StudentEvent.finalExamApprovedByCertification(
        subject: syllabus.getSubjectIfAnyByID(6)!,
        date: DateTime(2020, 12, 9),
        numericalGrade: 9,
        certificationResolution: '85CO20'));

    sEvents.add(StudentEvent.finalExamApprovedByCertification(
        subject: syllabus.getSubjectIfAnyByID(7)!,
        date: DateTime(2021, 10, 21),
        numericalGrade: 9,
        certificationResolution: '35TI'));
    sEvents.add(StudentEvent.finalExamApprovedByCertification(
        subject: syllabus.getSubjectIfAnyByID(8)!,
        date: DateTime(2020, 12, 10),
        numericalGrade: 8,
        certificationResolution: '85CO20'));
    sEvents.add(StudentEvent.finalExamApprovedByCertification(
        subject: syllabus.getSubjectIfAnyByID(9)!,
        date: DateTime(2021, 12, 3),
        numericalGrade: 10,
        certificationResolution: '34TI'));

    sEvents.add(StudentEvent.finalExamApprovedByCertification(
        subject: syllabus.getSubjectIfAnyByID(10)!,
        date: DateTime(2021, 12, 16),
        numericalGrade: 10,
        certificationResolution: '34TI'));

    studentEvents = sEvents;
  }

  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.student;
  }

  addEvent(StudentEvent studentEvent) {
    studentEvents.add(studentEvent);
  }
}

class Teacher extends UserRole {
  List<Subject> subjects;

  Teacher({required this.subjects});

  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.teacher;
  }
}

class Administrative extends UserRole {
  Syllabus syllabus;

  Administrative({required this.syllabus});

  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.administrative;
  }
}

class Manager extends UserRole {
  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.manager;
  }
}

class SystemAdmin extends UserRole {
  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.systemAdmin;
  }
}
