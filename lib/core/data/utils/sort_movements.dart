import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/utils/prints.dart';

List<MovementStudentRecord> sortMovements(studentRecordsDocs) {
  List<MovementStudentRecord> movements = [];
  for (var movement in studentRecordsDocs) {
    switch (movement['movementName']) {
      case MovementStudentRecordName.finalExamApprovedByCertification:
        movements.add(MSRFinalExamApprovedByCertification.fromMap(movement));
        break;
      case MovementStudentRecordName.courseRegistering:
        // Course registering
        movements.add(MSRCourseRegistering.fromMap(movement));
        break;
      case MovementStudentRecordName.courseFailedNonFree:
        // courseFailedNonFree
        movements.add(MSRCourseFailedNonFree.fromMap(movement));
        break;
      case MovementStudentRecordName.courseFailedFree:
        // courseFailedFree
        movements.add(MSRCourseFailedFree.fromMap(movement));
        break;
      case MovementStudentRecordName.courseApproved:
        // courseApproved
        movements.add(MSRCourseApproved.fromMap(movement));
        break;
      case MovementStudentRecordName.courseApprovedWithAccreditation:
        // courseApprovedWithAccreditation
        movements.add(MSRCourseApprovedWithAccreditation.fromMap(movement));
        break;
      case MovementStudentRecordName.finalExamApproved:
        // finalExamApproved
        movements.add(MSRFinalExamApproved.fromMap(movement));
        break;
      case MovementStudentRecordName.finalExamNonApproved:
        // finalExamNonApproved
        movements.add(MSRFinalExamNonApproved.fromMap(movement));
        break;
      default:
        // unknow
        prints("unknow");
    }
  }
  return movements;
}
