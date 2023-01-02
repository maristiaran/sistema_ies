import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';

enum CheckStudentRecordStateName { init }

class CheckStudentRecordState extends OperationState {
  // final IESUser currentUser;
  final UserRole currentRole;
  const CheckStudentRecordState(
      {required Enum stateName, required this.currentRole})
      : super(stateName: stateName);
  CheckStudentRecordState copyChangingRole({required UserRole newUserRole}) {
    return CheckStudentRecordState(
        stateName: stateName, currentRole: newUserRole);
  }

  CheckStudentRecordState copyChangingState(
      {required CheckStudentRecordStateName newState}) {
    return CheckStudentRecordState(
        stateName: newState, currentRole: currentRole);
  }

  UserRoleTypeName getUserRoleTypeName() {
    return currentRole.userRoleTypeName();
  }

  List<UserRoleOperation> getCurrentUserRoleOperations() {
    RolesAndOperationsRepositoryPort operationsAndRolesRepo =
        IESSystem().getRolesAndOperationsRepository();

    return operationsAndRolesRepo.getUserRoleOperations(getUserRoleTypeName());
  }
}

// AUTORIZATION
class CheckStudentRecordUseCase extends Operation<CheckStudentRecordState> {
  final IESUser currentIESUser;

  CheckStudentRecordUseCase({required this.currentIESUser})
      : super(CheckStudentRecordState(
            stateName: CheckStudentRecordStateName.init,
            currentRole: currentIESUser.getDefaultRole()));
}
