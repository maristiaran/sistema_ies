import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';

class Student extends UserRole {
  Syllabus syllabus;
  List<SubjectSR> srSubjects = [];
  // List<MovementStudentRecord> studentEvents = [];

  Student({required this.syllabus});

  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.student;
  }

  // addEvent(MovementStudentRecord studentEvent) {
  //   studentEvents.add(studentEvent);
  // }

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

  addMovFinalExamApprovedByCertification(
      {required DateTime date,
      required int numericalGrade,
      required int bookNumber,
      required int pageNumber,
      required String certificationResolution}) {
    addMovement(MSRFinalExamApprovedByCertification(
        date: date,
        numericalGrade: numericalGrade,
        bookNumber: bookNumber,
        pageNumber: pageNumber));
  }

  addMovCourseRegistering({required DateTime date}) {
    addMovement(MSRCourseRegistering(date: date));
  }

  addMovCourseFailedNonFree({required DateTime date}) {
    addMovement(MSRCourseFailedNonFree(date: date));
  }

  addMovCourseFailedFree({required DateTime date}) {
    addMovement(MSRCourseFailedFree(date: date));
  }

  addMovCourseApproved({required DateTime date}) {
    addMovement(MSRCourseApproved(date: date));
  }

  addMovCourseApprovedWithAccreditation(
      {required DateTime date, required int numericalGrade}) {
    addMovement(MSRCourseApprovedWithAccreditation(
        date: date, numericalGrade: numericalGrade));
  }

  addMovFinalExamApproved(
      {required DateTime date,
      required int numericalGrade,
      required int bookNumber,
      required int pageNumber}) {
    addMovement(MSRFinalExamApproved(
        date: date,
        numericalGrade: numericalGrade,
        bookNumber: bookNumber,
        pageNumber: pageNumber));
  }

  addMovFinalExamNonApproved(
      {required DateTime date, required int numericalGrade}) {
    addMovement(
        MSRFinalExamNonApproved(date: date, numericalGrade: numericalGrade));
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
  // Events's DDMMYYYY
  final DateTime date;

  MovementStudentRecord({required this.movementName, required this.date});

  @override
  String toString() {
    return " MovementStudentRecord";
  }

  //   @override
  // String toString() {
  //   String eName;
  //   if (movementName == MovementStudentRecordName.finalExamApproved) {
  //     eName = 'Examen';
  //   } else {
  //     eName = 'Equivalencia';
  //   }

  //   return "$eName (${date.day}-${date.month}-${date.year})  ";
  // }

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
  MSRCourseRegistering({required DateTime date})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);

  @override
  String toString() {
    return "Incripción a cursar (${date.day}-${date.month}-${date.year})  ";
  }
}

class MSRCourseFailedNonFree extends MovementStudentRecord {
  MSRCourseFailedNonFree({required DateTime date})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);

  @override
  String toString() {
    return "Abandono de cursado (${date.day}-${date.month}-${date.year})  ";
  }
}

class MSRCourseFailedFree extends MovementStudentRecord {
  MSRCourseFailedFree({required DateTime date})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);
  @override
  String toString() {
    return "Cursado libre(${date.day}-${date.month}-${date.year})  ";
  }
}

class MSRCourseApproved extends MovementStudentRecord {
  MSRCourseApproved({required DateTime date})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);
  @override
  String numericalGradeString() {
    return 'A';
  }

  @override
  String toString() {
    return "Curso regularizado (${date.day}-${date.month}-${date.year})  ";
  }
}

class MSRCourseApprovedWithAccreditation extends MovementStudentRecord {
  // 0-9 grade
  final int numericalGrade;

  MSRCourseApprovedWithAccreditation(
      {required DateTime date, required this.numericalGrade})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);
  @override
  String numericalGradeString() {
    return numericalGrade.toString();
  }

  @override
  String toString() {
    return "Curso aprovado por acreditación directo(${date.day}-${date.month}-${date.year})  ";
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

  @override
  String toString() {
    return "Examen final aprobado (${date.day}-${date.month}-${date.year})  ";
  }
}

class MSRFinalExamNonApproved extends MovementStudentRecord {
  final int numericalGrade;

  MSRFinalExamNonApproved(
      {required DateTime date, required this.numericalGrade})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);
  @override
  String numericalGradeString() {
    return numericalGrade.toString();
  }

  @override
  String toString() {
    return "Examen final desaprobado (${date.day}-${date.month}-${date.year})  ";
  }
}
