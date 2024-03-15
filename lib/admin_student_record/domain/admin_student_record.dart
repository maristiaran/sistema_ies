import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';

enum AdminStudentRecordStateName {
  init,
  success,
  loading,
  failure,
  studentRecordExtended
}

class AdminStudentRecordState extends OperationState {
  final Administrative currentRole;
  const AdminStudentRecordState(
      {required Enum stateName, required this.currentRole})
      : super(stateName: stateName);
  AdminStudentRecordState copyChangingRole(
      {required Administrative newUserRole}) {
    return AdminStudentRecordState(
        stateName: stateName, currentRole: newUserRole);
  }

  AdminStudentRecordState copyChangingState(
      {required AdminStudentRecordStateName newState}) {
    return AdminStudentRecordState(
        stateName: newState, currentRole: currentRole);
  }
}

class AdminStudentRecordUseCase extends Operation<AdminStudentRecordState> {
  final IESUser iesUser;
  final Administrative administrative;

  AdminStudentRecordUseCase(
      {required this.iesUser, required this.administrative})
      : super(AdminStudentRecordState(
            stateName: AdminStudentRecordStateName.init,
            currentRole: administrative));
}
