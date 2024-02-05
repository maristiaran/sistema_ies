import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

enum StudentRecordStateName {
  init,
  success,
  loading,
  failure,
  studentRecordExtended
}

class StudentRecordState extends OperationState {
  final Student currentRole;
  const StudentRecordState({required Enum stateName, required this.currentRole})
      : super(stateName: stateName);
  StudentRecordState copyChangingRole({required Student newUserRole}) {
    return StudentRecordState(stateName: stateName, currentRole: newUserRole);
  }

  StudentRecordState copyChangingState(
      {required StudentRecordStateName newState}) {
    return StudentRecordState(stateName: newState, currentRole: currentRole);
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
class StudentRecordUseCase extends Operation<StudentRecordState> {
  final IESUser currentIESUser;
  final Student studentRole;

  StudentRecordUseCase(
      {required this.currentIESUser, required this.studentRole})
      : super(StudentRecordState(
            stateName: StudentRecordStateName.init, currentRole: studentRole));

  void getStudentRecords() async {
    changeState(currentState.copyChangingState(
        newState: StudentRecordStateName.loading));
    await IESSystem()
        .getStudentRepository()
        .getStudentRecord(
            idUser: IESSystem().homeUseCase.currentIESUser.id,
            syllabus: (IESSystem().homeUseCase.currentIESUser.getCurrentRole()
                    as Student)
                .syllabus
                .administrativeResolution)
        .fold((left) {
      changeState(currentState.copyChangingState(
          newState: StudentRecordStateName.failure));
    }, (right) {
      studentRole.srSubjects = right;

      changeState(currentState.copyChangingState(
          newState: StudentRecordStateName.success));
    });
  }

  void getStudentRecordMovements(
      StudentRecordSubject studentRecordSubject) async {
    changeState(currentState.copyChangingState(
        newState: StudentRecordStateName.loading));
    await IESSystem()
        .getStudentRepository()
        .getStudentRecordMovements(
            idUser: IESSystem().homeUseCase.currentIESUser.id,
            syllabusId: (IESSystem().homeUseCase.currentIESUser.getCurrentRole()
                    as Student)
                .syllabus
                .administrativeResolution,
            subjectId: studentRecordSubject.subjectId)
        .then((value) => studentRecordSubject.movements = value);
    changeState(currentState.copyChangingState(
        newState: StudentRecordStateName.studentRecordExtended));
  }

  Future<Either<Failure, List>> getSubjects() async {
    List subjects = [];
    // to change current state to loading state
    changeState(currentState.copyChangingState(
        newState: StudentRecordStateName.loading));
    // throught IESSystem we'll to try get the subjects
    await IESSystem().getStudentRepository().getSubjects(idUser: IESSystem().homeUseCase.currentIESUser.id, syllabusId: (IESSystem().homeUseCase.currentIESUser.getCurrentRole()
                    as Student)
                .syllabus
                .administrativeResolution);

    return Right(subjects);
  }
}
