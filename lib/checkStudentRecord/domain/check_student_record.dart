import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';

enum CheckStudentRecordStateName {
  init,
  success,
  loading,
  failure,
  studentRecordExtended
}

class CheckStudentRecordState extends OperationState {
  // final IESUser currentUser;
  final Student currentRole;
  const CheckStudentRecordState(
      {required Enum stateName, required this.currentRole})
      : super(stateName: stateName);
  CheckStudentRecordState copyChangingRole({required Student newUserRole}) {
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
  final Student studentRole;

  CheckStudentRecordUseCase(
      {required this.currentIESUser, required this.studentRole})
      : super(CheckStudentRecordState(
            stateName: CheckStudentRecordStateName.init,
            currentRole: studentRole));

  void getStudentRecords() async {
    changeState(currentState.copyChangingState(
        newState: CheckStudentRecordStateName.loading));
    await IESSystem()
        .getStudentRecordRepository()
        .getStudentRecord(
            idUser: IESSystem().homeUseCase.currentIESUser.id,
            syllabus:
                (IESSystem().homeUseCase.currentIESUser.defaultRole as Student)
                    .syllabus
                    .administrativeResolution)
        .fold((left) {
      changeState(currentState.copyChangingState(
          newState: CheckStudentRecordStateName.failure));
      print(left.failureName);
    }, (right) {
      studentRole.srSubjects = right;

      changeState(currentState.copyChangingState(
          newState: CheckStudentRecordStateName.success));
    });
  }

  void getStudentRecordMovements(
      StudentRecordSubject studentRecordSubject) async {
    changeState(currentState.copyChangingState(
        newState: CheckStudentRecordStateName.loading));
    List<MovementStudentRecord> movements = [];
    await IESSystem()
        .getStudentRecordRepository()
        .getStudentRecordMovements(
            idUser: IESSystem().homeUseCase.currentIESUser.id,
            syllabusId:
                (IESSystem().homeUseCase.currentIESUser.defaultRole as Student)
                    .syllabus
                    .administrativeResolution,
            subjectId: studentRecordSubject.subjectId)
        .then((value) => studentRecordSubject.movements = value);
    print(studentRecordSubject.movements);
    changeState(currentState.copyChangingState(
        newState: CheckStudentRecordStateName.studentRecordExtended));
  }
}



