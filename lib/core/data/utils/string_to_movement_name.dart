import 'package:sistema_ies/core/domain/entities/student.dart';

MovementStudentRecordName stringToSRMovementName(String name) {
  MovementStudentRecordName movementName;
  switch (name) {
    case 'courseApproved':
      movementName = MovementStudentRecordName.courseApproved;
      break;
    case 'courseApprovedWithAccreditation':
      movementName = MovementStudentRecordName.courseApprovedWithAccreditation;
      break;
    case 'courseFailedFree':
      movementName = MovementStudentRecordName.courseFailedFree;
      break;
    case 'courseFailedNonFree':
      movementName = MovementStudentRecordName.courseFailedNonFree;
      break;
    case 'courseRegistering':
      movementName = MovementStudentRecordName.courseRegistering;
      break;
    case 'finalExamApproved':
      movementName = MovementStudentRecordName.finalExamApproved;
      break;
    case 'finalExamApprovedByCertification':
      movementName = MovementStudentRecordName.finalExamApprovedByCertification;
      break;
    case 'finalExamNonApproved':
      movementName = MovementStudentRecordName.finalExamNonApproved;
      break;
    default:
      movementName = MovementStudentRecordName.unknow;
  }
  return movementName;
}
