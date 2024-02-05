import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/register_for_exam/utils/prints.dart';

enum RegisterForExamStateName { init, failure, loading, loadnull, success }

class RegisterForExamState extends OperationState {
  const RegisterForExamState(
      {required Enum stateName, required Student currentRole})
      : super(stateName: stateName);

  @override
  List<Object?> get props => [stateName];
}

class RegisterForExamInitialState extends RegisterForExamState {
  // final IESUser currentUser;
  final Student currentRole;
  final List registereds;
  const RegisterForExamInitialState(
      {required Enum stateName,
      required this.currentRole,
      required this.registereds})
      : super(stateName: stateName, currentRole: currentRole);

  @override
  List<Object?> get props => [stateName, registereds];

  RegisterForExamState copyChangingRole({required Student newUserRole}) {
    return RegisterForExamState(stateName: stateName, currentRole: newUserRole);
  }

  RegisterForExamState copyChangingState(
      {required RegisterForExamStateName newState}) {
    return RegisterForExamState(stateName: newState, currentRole: currentRole);
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
class RegisterForExamUseCase extends Operation<OperationState> {
  final IESUser currentIESUser;
  final Student studentRole;
  List regs = [];
  Map movements = <int, List<MovementStudentRecord>>{};

  RegisterForExamUseCase(
      {required this.currentIESUser, required this.studentRole})
      : super(RegisterForExamState(
            stateName: RegisterForExamStateName.init,
            currentRole: studentRole)) {
    getRegistereds();
  }

  /// Get a filtered list of subjects to register
  List<Subject> getSubjectsToRegister() {
    List<Subject> registerSubjects =
        IESSystem().registerForExamUseCase.studentRole.syllabus.subjects;

    return registerSubjects;
  }

  /// Get previous registers
  Future<void> getRegistereds() async {
    changeState(
        const OperationState(stateName: RegisterForExamStateName.loading));
    await IESSystem()
        .getStudentsRepository()
        .getRegistersForExam(
            idUser: IESSystem().homeUseCase.currentIESUser.id,
            syllabus: (IESSystem().homeUseCase.currentIESUser.getCurrentRole()
                    as Student)
                .syllabus
                .administrativeResolution)
        .then((value) => regs = value.right);
    prints("recibido $regs");
    // if (subjectsf.isNotEmpty) {
    //   return subjectsf;
    // }
    changeState(RegisterForExamInitialState(
        stateName: RegisterForExamStateName.init,
        currentRole: studentRole,
        registereds: regs));
  }

  /// Check or not check, that is the question
  void toogleRegister(int registerId) {
    if (regs.contains(registerId)) {
      regs.remove(registerId);
    } else {
      regs.add(registerId);
    }
    prints("regs toogle: $regs");
    changeState(RegisterForExamInitialState(
        stateName: RegisterForExamStateName.init,
        currentRole: studentRole,
        registereds: regs));
  }

  /// Update the checklist in repo
  Future<void> submitRegister(List registereds) async {
    changeState(
        const OperationState(stateName: RegisterForExamStateName.loading));
    // bool res = false;
    var res = IESSystem()
        .getStudentsRepository()
        .setRegistersForExam(
            idUser: IESSystem().homeUseCase.currentIESUser.id,
            syllabus: (IESSystem().homeUseCase.currentIESUser.getCurrentRole()
                    as Student)
                .syllabus
                .administrativeResolution,
            registereds: registereds)
        .then((value) => value.isRight);
    if (await res) {
      changeState(
          const OperationState(stateName: RegisterForExamStateName.success));
    } else {
      changeState(
          const OperationState(stateName: RegisterForExamStateName.failure));
    }
    getRegistereds();
    changeState(RegisterForExamInitialState(
        stateName: RegisterForExamStateName.init,
        currentRole: studentRole,
        registereds: regs));
  }

  /// Get movements to filter subjects list
  void getStudentRecordMovements(int subjectId) async {
    List<MovementStudentRecord> movs = [];
    prints(
        "GET MOVEMENTS ${studentRole.syllabus.subjects.where((element) => element.id == subjectId).single.name}");
    // List<MovementStudentRecord> movements = [];
    try {
      await IESSystem()
          .getStudentRepository()
          .getStudentRecordMovements(
              idUser: IESSystem().homeUseCase.currentIESUser.id,
              syllabusId: (IESSystem()
                      .homeUseCase
                      .currentIESUser
                      .getCurrentRole() as Student)
                  .syllabus
                  .administrativeResolution,
              subjectId: subjectId)
          .then((value) => movs = value);
      movs.sort((a, b) => a.date.isAfter(b.date) ? 1 : -1);
      movements.update(
          studentRole.syllabus.subjects
              .where((element) => element.id == subjectId)
              .single
              .id,
          ((movs) => movs));
    } catch (e) {
      prints(e);
    }
    // return movements;
  }
}
