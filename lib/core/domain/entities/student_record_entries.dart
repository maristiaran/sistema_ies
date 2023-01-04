import 'package:sistema_ies/core/domain/entities/syllabus.dart';

enum Institute { ies9004, ies9009, ies9015 }

enum StudentEventName {
  finalExamApprovedByCertification,
  courseRegistering,
  courseFailedNonFree,
  courseFailedFree,
  courseApproved,
  courseApprovedWithAccreditation,
  finalExamApproved,
  finalExamNonApproved
}

class StudentEvent {
  //Type of student event
  final StudentEventName eventName;
  final Subject subject;
  // Events's DDMMYYYY
  final DateTime date;
  // 0-9 grade
  int? numericalGrade;
  // approved-non approved grade
  bool? approvedOrNotGrade;
  // Institute (for finalExamApprovedByCertification), null = IES 9-010
  Institute? certificationInstitute;
  // Registering book number (for finalExams events)
  int? bookNumber;
  // Registering book page number (for finalExams events)
  int? pageNumber;
  // CertificationResolution(for finalExamApprovedByCertification)
  String? certificationResolution;

  StudentEvent.finalExamApprovedByCertification(
      {required this.subject,
      required this.date,
      required this.numericalGrade,
      required this.certificationResolution,
      this.certificationInstitute})
      : eventName = StudentEventName.finalExamApprovedByCertification,
        approvedOrNotGrade = true;

  StudentEvent.courseRegistering({required this.subject, required this.date})
      : eventName = StudentEventName.courseRegistering;

  StudentEvent.courseFailedNonFree({required this.subject, required this.date})
      : eventName = StudentEventName.courseFailedNonFree,
        approvedOrNotGrade = false;

  StudentEvent.courseFailedFree({required this.subject, required this.date})
      : eventName = StudentEventName.courseFailedFree,
        approvedOrNotGrade = false;

  StudentEvent.courseApproved(
      {required this.subject, required this.date, this.numericalGrade})
      : eventName = StudentEventName.courseApproved,
        approvedOrNotGrade = true;

  StudentEvent.courseApprovedWithAccreditation(
      {required this.subject, required this.date, required this.numericalGrade})
      : eventName = StudentEventName.courseApprovedWithAccreditation,
        approvedOrNotGrade = true;

  StudentEvent.finalExamApproved(
      {required this.subject,
      required this.date,
      required this.numericalGrade,
      required this.bookNumber,
      required this.pageNumber})
      : eventName = StudentEventName.finalExamApproved,
        approvedOrNotGrade = true;

  StudentEvent.finalExamNonApproved(
      {required this.subject, required this.date, required this.numericalGrade})
      : eventName = StudentEventName.finalExamNonApproved,
        approvedOrNotGrade = false;

  @override
  String toString() {
    String eName;
    if (eventName == StudentEventName.finalExamApproved) {
      eName = 'Examen';
    } else {
      eName = 'Equivalencia';
    }

    return "$eName (${date.day}-${date.month}-${date.year}): ${subject.name}  ";
  }

  // final Subject subject;
  // // Events's DDMMYYYY
  // final DateTime date;
  // // 0-9 grade
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

}
