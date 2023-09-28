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

// final Map<Enum, Widget> widgetElements = {
//       RegisterForExamStateName.init: RegisterForm(),
//       RegisterForExamStateName.failure: const FailureRegisterPage(),
//       RegisterForExamStateName.loading: const Center(
//         child: CircularProgressIndicator(),
//       )
//     };

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

// class RegisterForExamInitialState extends RegisterForExamState {
//   final registereds;
//   const RegisterForExamInitialState(this.registereds,
//       {required Enum stateName, required Student currentRole})
//       : super(stateName: stateName, currentRole: currentRole);
// }

// AUTORIZATION
class RegisterForExamUseCase extends Operation<OperationState> {
  final IESUser currentIESUser;
  final Student studentRole;
  List regs = [];

  RegisterForExamUseCase(
      {required this.currentIESUser, required this.studentRole})
      : super(RegisterForExamState(
            stateName: RegisterForExamStateName.init,
            currentRole: studentRole)) {
    registereds();
  }

  // copyChangingState({newState}) {
  //   RegisterForExamState(stateName: newState, currentRole: studentRole);
  // }

  List<Subject> getSubjectsToRegister() {
    List<Subject> registerSubjects =
        IESSystem().registerForExamUseCase.studentRole.syllabus.subjects;

    return registerSubjects;
  }

  Future<void> registereds() async {
    // List subjects = [
    //   IESSystem().registerForExamUseCase.studentRole.syllabus.subjects[0].name,
    //   IESSystem().registerForExamUseCase.studentRole.syllabus.subjects[7].name
    // ];
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

  // void updateRegisters(WidgetRef ref) {
  //   changeState(currentState.copyChangingState(
  //       newState: RegisterForExamStateName.loading));
  //   ref.read(registersProvider.notifier).update();
  // }

  // Future<void> completeRegisters() async {
  //   // changeState(
  //   //     const OperationState(stateName: RegisterForExamStateName.loading));
  //   List getted = (await registereds());
  //   changeState(
  //       const OperationState(stateName: RegisterForExamStateName.loading));
  //   for (String r in getted) {
  //     toogleRegister(r);
  //   }
  //   changeState(RegisterForExamInitialState(
  //       stateName: RegisterForExamStateName.init,
  //       currentRole: studentRole,
  //       registereds: regs));
  // }

  void toogleRegister(String registerId) {
    if (regs.contains(registerId)) {
      regs.remove(registerId);
    } else {
      regs.add(registerId);
    }
    print("regs toogle: $regs");
    changeState(RegisterForExamInitialState(
        stateName: RegisterForExamStateName.init,
        currentRole: studentRole,
        registereds: regs));
  }

  Future<bool> submitRegister(List registereds) async {
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
    changeState(
        const OperationState(stateName: RegisterForExamStateName.success));
    changeState(RegisterForExamInitialState(
        stateName: RegisterForExamStateName.init,
        currentRole: studentRole,
        registereds: regs));
    return res;
    // return res;
  }

  List<MovementStudentRecord> getStudentRecordMovements(int subjectId) {
    List<MovementStudentRecord> movements = [];
    IESSystem()
        .getStudentRecordRepository()
        .getStudentRecordMovements(
            idUser: IESSystem().homeUseCase.currentIESUser.id,
            syllabusId: (IESSystem().homeUseCase.currentIESUser.getCurrentRole()
                    as Student)
                .syllabus
                .administrativeResolution,
            subjectId: subjectId)
        .then((value) => movements = value);
    movements.sort((a, b) => a.date.isBefore(b.date) ? 1 : -1);
    return movements;
  }
}
