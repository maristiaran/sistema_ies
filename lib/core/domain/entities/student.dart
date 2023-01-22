import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';

class Student extends UserRole {
  Syllabus syllabus;
  List<SubjectSR> srSubjects = [];
  List<MovementStudentRecord> studentEvents = [];

  Student({required this.syllabus});

  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.student;
  }

  addEvent(MovementStudentRecord studentEvent) {
    studentEvents.add(studentEvent);
  }

  addSubjects(SubjectSR subject) {
    if (!srSubjects.contains(subject)) {
      srSubjects = [...srSubjects, subject];
    }
  }
}

class SubjectSR {
  List<MovementStudentRecord> movements = [];
  String name;
  int subjectId;
  DateTime? finalExamApprovalDateIfAny;
  int? finalExamApprovalGradeIfAny;
  DateTime? courseApprovalDateIfAny;
  DateTime? courseApprovalNumericalGrade;
  bool? courseApprovalGradeBooleanGrade;

  SubjectSR(
      {required this.subjectId,
      required this.name,
      this.finalExamApprovalDateIfAny,
      this.finalExamApprovalGradeIfAny,
      this.courseApprovalDateIfAny,
      this.courseApprovalGradeBooleanGrade,
      this.courseApprovalNumericalGrade});

  addMovement(MovementStudentRecord movementStudentRecord) {
    if (!movements.contains(movementStudentRecord)) {
      movements = [...movements, movementStudentRecord];
    }
  }

  @override
  String toString() {
    return 'SRSubject($name)';
  }
}

enum Institute { ies9004, ies9009, ies9015 }

enum MovementStudentRecordName {
  finalExamApprovedByCertification,
  // arpobado por equivalencia
  courseRegistering,
  // se inscribió a cursar
  courseFailedNonFree,
  // abandonó
  courseFailedFree,
  // cursó y quedó libre
  courseApproved,
  // cursado aprobado
  courseApprovedWithAccreditation,
  // aprobó con acreditación directa
  finalExamApproved,
  // final aprobado
  finalExamNonApproved
  // final no aprobado
}

class MovementStudentRecord {
  //Type of student event
  final MovementStudentRecordName movementName;
  // final Subject subject;
  // Events's DDMMYYYY
  final DateTime date;
  // 0-9 grade
  // int? numericalGrade;
  // // approved-non approved grade
  // bool? approvedOrNotGrade;
  // // Institute (for finalExamApprovedByCertification), null = IES 9-010
  // Institute? certificationInstitute;
  // // Registering book number (for finalExams events)
  // int? bookNumber;
  // // Registering book page number (for finalExams events)
  // int? pageNumber;
  // // CertificationResolution(for finalExamApprovedByCertification)
  // String? certificationResolution;

  MovementStudentRecord({required this.movementName, required this.date});

  @override
  String toString() {
    String eName;
    if (movementName == MovementStudentRecordName.finalExamApproved) {
      eName = 'Examen';
    } else {
      eName = 'Equivalencia';
    }

    return "$eName (${date.day}-${date.month}-${date.year})  ";
  }

  String numericalGradeString() {
    return '???';
  }
}

class MSRFinalExamApprovedByCertification extends MovementStudentRecord {
  // Institute (for finalExamApprovedByCertification), null = IES 9-010
  final Institute? certificationInstitute;
  // Registering book number (for finalExams events)
  final int? bookNumber;
  // Registering book page number (for finalExams events)
  final int? pageNumber;
  // CertificationResolution(for finalExamApprovedByCertification)
  final String? certificationResolution;
  // 0-9 grade
  final int numericalGrade;
  MSRFinalExamApprovedByCertification({
    required DateTime date,
    required this.numericalGrade,
    this.certificationInstitute,
    this.bookNumber,
    this.pageNumber,
    this.certificationResolution,
  }) : super(
            movementName:
                MovementStudentRecordName.finalExamApprovedByCertification,
            date: date);

  @override
  String numericalGradeString() {
    return numericalGrade.toString();
  }
}

class MSRCourseRegistering extends MovementStudentRecord {
  MSRCourseRegistering({required Subject subject, required DateTime date})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);
}

class MSRCourseFailedNonFree extends MovementStudentRecord {
  MSRCourseFailedNonFree({required Subject subject, required DateTime date})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);
}

class MSRCourseFailedFree extends MovementStudentRecord {
  MSRCourseFailedFree({required Subject subject, required DateTime date})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);
}

class MSRCourseApproved extends MovementStudentRecord {
  MSRCourseApproved({required Subject subject, required DateTime date})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);
  @override
  String numericalGradeString() {
    return 'A';
  }
}

class MSRCourseApprovedWithAccreditation extends MovementStudentRecord {
  // 0-9 grade
  final int numericalGrade;

  MSRCourseApprovedWithAccreditation(
      {required Subject subject,
      required DateTime date,
      required this.numericalGrade})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);
  @override
  String numericalGradeString() {
    return numericalGrade.toString();
  }
}

class MSRFinalExamApproved extends MovementStudentRecord {
  final int numericalGrade;
  final int bookNumber;
  final int pageNumber;

  MSRFinalExamApproved(
      {
      // required Subject subject,
      required DateTime date,
      required this.numericalGrade,
      required this.bookNumber,
      required this.pageNumber})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);
  @override
  String numericalGradeString() {
    return numericalGrade.toString();
  }
}

class MSRFinalExamNonApproved extends MovementStudentRecord {
  final int numericalGrade;

  MSRFinalExamNonApproved(
      {required Subject subject,
      required DateTime date,
      required this.numericalGrade})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);
  @override
  String numericalGradeString() {
    return numericalGrade.toString();
  }
}
