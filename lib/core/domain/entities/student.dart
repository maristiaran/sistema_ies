import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/utils/datetime.dart';

class Student extends UserRole {
  Syllabus syllabus;
  List<StudentRecordSubject> srSubjects = [];
  // List<MovementStudentRecord> studentEvents = [];

  Student({required this.syllabus});

  @override
  UserRoleTypeName userRoleTypeName() {
    return UserRoleTypeName.student;
  }

  @override
  String toString() {
    return 'Estudiante';
  }
  // addEvent(MovementStudentRecord studentEvent) {
  //   studentEvents.add(studentEvent);
  // }

  addSubjects(StudentRecordSubject subject) {
    if (!srSubjects.contains(subject)) {
      srSubjects = [...srSubjects, subject];
    }
  }

  @override
  String subtitle() {
    return syllabus.name;
  }
}

enum SubjetState { approved, regular, dessaproved, coursing, nule }

// Student Record subject
class StudentRecordSubject {
  List<MovementStudentRecord> movements = [];
  String name;
  int subjectId;
  //TODO: registeringDateIt'sNecessary
  DateTime? finalExamApprovalDateIfAny;
  int? finalExamApprovalGradeIfAny;
  DateTime? courseApprovalDateIfAny;
  int? courseAcreditationNumericalGrade;
  bool endCourseApproval = false;
  bool coursing = false;
  Enum subjectState = SubjetState.nule;
  StudentRecordSubject(
      {required this.subjectId,
      required this.name,
      this.finalExamApprovalDateIfAny,
      this.finalExamApprovalGradeIfAny,
      this.courseApprovalDateIfAny,
      this.endCourseApproval = false,
      this.courseAcreditationNumericalGrade});

  addMovementToStudentRecord(MovementStudentRecord movementStudentRecord) {
    if (!movements.contains(movementStudentRecord)) {
      movements = [...movements, movementStudentRecord];
    }
  }

  fromMapToObject(Map<String, dynamic> movement) {
    switch (movement['name']) {
      case 'finalExamApprovedByCertification':
        addMovFinalExamApprovedByCertification(
            bookNumber: movement['bookNumber'],
            certificationResolution: movement['certificationResolution'],
            date: movement['date'],
            numericalGrade: movement['numericalGrade'],
            pageNumber: movement['pageNumber']);
        break;
      case 'courseRegistering':
        addMovCourseRegistering(date: movement['date']);
        break;
      case 'courseFailedNonFree':
        addMovCourseFailedNonFree(date: movement['date']);
        break;
      case 'courseFailedFree':
        addMovCourseFailedFree(date: movement['date']);
        break;
      case 'courseApproved':
        addMovCourseApproved(date: movement['date']);
        break;
      case 'courseApprovedWithAccreditation':
        addMovCourseApprovedWithAccreditation(
            date: movement['date'], numericalGrade: movement['numericalGrade']);
        break;
      case 'finalExamApproved':
        addMovFinalExamApproved(
            date: movement['date'],
            numericalGrade: movement['numericalGrade'],
            bookNumber: movement['bookNumber'],
            pageNumber: movement['pageNumber']);
        break;
      case 'finalExamNonApproved':
        addMovFinalExamNonApproved(
            date: movement['date'], numericalGrade: movement['numericalGrade']);
        break;
      default:
    }
  }

  addMovFinalExamApprovedByCertification(
      {required DateTime date,
      required int numericalGrade,
      required int bookNumber,
      required int pageNumber,
      required String certificationResolution}) {
    addMovementToStudentRecord(MSRFinalExamApprovedByCertification(
        date: date,
        numericalGrade: numericalGrade,
        bookNumber: bookNumber,
        pageNumber: pageNumber));

    finalExamApprovalDateIfAny = date;
    finalExamApprovalGradeIfAny = numericalGrade;
    changeSubjetState(SubjetState.approved);
  }

  addMovCourseRegistering({required DateTime date}) {
    addMovementToStudentRecord(MSRCourseRegistering(date: date));

    coursing = true;
    changeSubjetState(SubjetState.coursing);
  }

  addMovCourseFailedNonFree({required DateTime date}) {
    addMovementToStudentRecord(MSRCourseFailedNonFree(date: date));
    changeSubjetState(SubjetState.regular);
  }

  addMovCourseFailedFree({required DateTime date}) {
    addMovementToStudentRecord(MSRCourseFailedFree(date: date));

    courseApprovalDateIfAny = date;
    endCourseApproval = false;
    changeSubjetState(SubjetState.dessaproved);
  }

  addMovCourseApproved({required DateTime date}) {
    addMovementToStudentRecord(MSRCourseApproved(date: date));

    courseApprovalDateIfAny = date;
    endCourseApproval = true;
    changeSubjetState(SubjetState.approved);
  }

  addMovCourseApprovedWithAccreditation(
      {required DateTime date, required int numericalGrade}) {
    courseApprovalDateIfAny = date;
    endCourseApproval = true;
    courseAcreditationNumericalGrade = numericalGrade;
    changeSubjetState(SubjetState.approved);
    addMovementToStudentRecord(MSRCourseApprovedWithAccreditation(
        date: date, numericalGrade: numericalGrade));
  }

  addMovFinalExamApproved(
      {required DateTime date,
      required int numericalGrade,
      required int bookNumber,
      required int pageNumber}) {
    addMovementToStudentRecord(MSRFinalExamApproved(
        date: date,
        numericalGrade: numericalGrade,
        bookNumber: bookNumber,
        pageNumber: pageNumber));
    changeSubjetState(SubjetState.approved);
    finalExamApprovalDateIfAny = date;
    finalExamApprovalGradeIfAny = numericalGrade;
  }

  addMovFinalExamNonApproved(
      {required DateTime date, required int numericalGrade}) {
    addMovementToStudentRecord(
        MSRFinalExamNonApproved(date: date, numericalGrade: numericalGrade));
    changeSubjetState(SubjetState.regular);
  }

  changeSubjetState(SubjetState newState) {
    subjectState = newState;
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
  finalExamNonApproved,
  // final no aprobado
  unknow
  // desconocido
}

abstract class MovementStudentRecord {
  //Type of student event
  final MovementStudentRecordName movementName;
  // Events's DDMMYYYY
  final DateTime date;

  MovementStudentRecord({required this.movementName, required this.date});

  @override
  String toString() {
    return " MovementStudentRecord";
  }

  String numericalGradeString() {
    return '???';
  }

  Map<String, dynamic> toMap(MovementStudentRecord movement);
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

  factory MSRFinalExamApprovedByCertification.fromMap(
      Map<String, dynamic> movement) {
    return MSRFinalExamApprovedByCertification(
        date: timestampToDate(movement['date']),
        numericalGrade: movement['numericalGrade'],
        certificationInstitute: movement['certificationInstitute'],
        bookNumber: movement['bookNumber'],
        pageNumber: movement['pageNumber'],
        certificationResolution: movement['certificationResolution']);
  }

  @override
  String numericalGradeString() {
    return numericalGrade.toString();
  }

  @override
  Map<String, dynamic> toMap(MovementStudentRecord movement) {
    return {
      "date": dateToString(date),
      "numericalGrade": numericalGrade,
      "certificationInstitute": certificationInstitute.toString(),
      "bookNumber": bookNumber,
      "pageNumber": pageNumber,
      "certificationResolution": certificationResolution,
    };
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

  @override
  Map<String, dynamic> toMap(MovementStudentRecord movement) {
    return {"movementName": movementName, "date": dateToString(date)};
  }

  factory MSRCourseRegistering.fromMap(Map<String, dynamic> movement) {
    return MSRCourseRegistering(
      date: timestampToDate(movement['date']),
    );
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

  @override
  Map<String, dynamic> toMap(MovementStudentRecord movement) {
    return {"movementName": movementName, "date": dateToString(date)};
  }

  factory MSRCourseFailedNonFree.fromMap(Map<String, dynamic> movement) {
    return MSRCourseFailedNonFree(date: timestampToDate(movement['date']));
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

  @override
  Map<String, dynamic> toMap(MovementStudentRecord movement) {
    return {"movementName": movementName, "date": dateToString(date)};
  }

  factory MSRCourseFailedFree.fromMap(Map<String, dynamic> movement) {
    return MSRCourseFailedFree(date: timestampToDate(movement['date']));
  }
}

class MSRCourseApproved extends MovementStudentRecord {
  MSRCourseApproved({required DateTime date})
      : super(
            movementName: MovementStudentRecordName.courseRegistering,
            date: date);
  // This should reset the final exam counter.
  @override
  String numericalGradeString() {
    return 'A';
  }

  @override
  String toString() {
    return "Curso regularizado (${date.day}-${date.month}-${date.year})  ";
  }

  @override
  Map<String, dynamic> toMap(MovementStudentRecord movement) {
    return {"movementName": movementName, "date": dateToString(date)};
  }

  factory MSRCourseApproved.fromMap(Map<String, dynamic> movement) {
    return MSRCourseApproved(date: timestampToDate(movement['date']));
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

  @override
  Map<String, dynamic> toMap(MovementStudentRecord movement) {
    return {"movementName": movementName, "date": dateToString(date)};
  }

  factory MSRCourseApprovedWithAccreditation.fromMap(
      Map<String, dynamic> movement) {
    return MSRCourseApprovedWithAccreditation(
        date: timestampToDate(movement['date']),
        numericalGrade: movement['numericalGrade']);
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

  @override
  Map<String, dynamic> toMap(MovementStudentRecord movement) {
    return {
      "date": dateToString(date),
      "numericalGrade": numericalGrade,
      "bookNumber": bookNumber,
      "pageNumber": pageNumber
    };
  }

  factory MSRFinalExamApproved.fromMap(Map<String, dynamic> movement) {
    return MSRFinalExamApproved(
        date: timestampToDate(movement['date']),
        numericalGrade: movement['numericalGrade'],
        bookNumber: movement['bookNumber'],
        pageNumber: movement['pageNumber']);
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

  // This should increase the final exam counter.
  @override
  String toString() {
    return "Examen final desaprobado (${date.day}-${date.month}-${date.year})  ";
  }

  @override
  Map<String, dynamic> toMap(MovementStudentRecord movement) {
    return {"movementName": movementName, "date": dateToString(date)};
  }

  factory MSRFinalExamNonApproved.fromMap(Map<String, dynamic> movement) {
    return MSRFinalExamNonApproved(
        date: timestampToDate(movement['date']),
        numericalGrade: movement['numericalGrade']);
  }
}

class StudentRecordSubject2 {
/*    cantidad de veces que rindio (mal) desde la ultima regularizacion     */

  int subjectId;
  // date of last registration for the course
  DateTime? dateLastRegistration;
  // date of the last time the subject was regularized
  DateTime? dateLastRegularized;
  // date of the last time the final exam was taken
  DateTime? dateLastExamTaken;
  // ------------------------ //
  List<MovementStudentRecord> movements = [];
  String subjectName;
  DateTime? finalExamApprovalDateIfAny; // if this exist so
  bool endCourseApproval = false; // I think this is unnecessary
  int? finalExamApprovalGradeIfAny;
  DateTime?
      courseApprovalDateIfAny; // if there are an final exam approval date, is it necessary an course approval date? I guess they are both the same.
  int? courseAcreditationNumericalGrade;

  bool coursing = false;
  Enum subjectState = SubjetState.nule;

  StudentRecordSubject2(
      {required this.subjectId,
      required this.subjectName,
      this.finalExamApprovalDateIfAny,
      this.finalExamApprovalGradeIfAny,
      this.courseApprovalDateIfAny,
      this.endCourseApproval = false,
      this.courseAcreditationNumericalGrade});
  factory StudentRecordSubject2.fromJson(Map<dynamic, dynamic> parsedJson) {
    return StudentRecordSubject2(
        subjectId: parsedJson['id'],
        subjectName: parsedJson['subjectName'] ?? "",
        finalExamApprovalDateIfAny:
            parsedJson['finalExamApprovalDateIfAny'] == null
                ? null
                : timestampToDate(parsedJson['finalExamApprovalDateIfAny']),
        finalExamApprovalGradeIfAny: parsedJson['finalExamApprovalGradeIfAny'],
        courseApprovalDateIfAny: parsedJson['courseApprovalDateIfAny'] == null
            ? null
            : timestampToDate(parsedJson['courseApprovalDateIfAny']),
        endCourseApproval: false,
        courseAcreditationNumericalGrade:
            parsedJson['courseAcreditationNumericalGrade']);
  }
}
