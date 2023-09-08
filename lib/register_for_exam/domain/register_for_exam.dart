import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';

enum RegisterForExamStateName { init, failure, loading, loadnull }

// final Map<Enum, Widget> widgetElements = {
//       RegisterForExamStateName.init: RegisterForm(),
//       RegisterForExamStateName.failure: const FailureRegisterPage(),
//       RegisterForExamStateName.loading: const Center(
//         child: CircularProgressIndicator(),
//       )
//     };

class RegisterForExamState extends OperationState {
  // final IESUser currentUser;
  final Student currentRole;
  const RegisterForExamState(
      {required Enum stateName, required this.currentRole})
      : super(stateName: stateName);
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
class RegisterForExamUseCase extends Operation<RegisterForExamState> {
  final IESUser currentIESUser;
  final Student studentRole;

  RegisterForExamUseCase(
      {required this.currentIESUser, required this.studentRole})
      : super(RegisterForExamState(
            stateName: RegisterForExamStateName.init,
            currentRole: studentRole));

  List<Subject> getSubjectsToRegister() {
    List<Subject> registerSubjects =
        IESSystem().registerForExamUseCase.studentRole.syllabus.subjects;

    return registerSubjects;
  }

  void ManualChangeState(RegisterForExamStateName state) {
    if (state == RegisterForExamStateName.init)
      changeState(currentState.copyChangingState(
          newState: RegisterForExamStateName.init));
  }

  Future<List> registereds() async {
    // List subjects = [
    //   IESSystem().registerForExamUseCase.studentRole.syllabus.subjects[0].name,
    //   IESSystem().registerForExamUseCase.studentRole.syllabus.subjects[7].name
    // ];
    changeState(currentState.copyChangingState(
        newState: RegisterForExamStateName.loading));
    List subjectsf = [];
    await IESSystem()
        .getStudentsRepository()
        .getRegistersForExam(
            idUser: IESSystem().homeUseCase.currentIESUser.id,
            syllabus: (IESSystem().homeUseCase.currentIESUser.getCurrentRole()
                    as Student)
                .syllabus
                .administrativeResolution)
        .then((value) => subjectsf = value.right);
    print("recibido $subjectsf");
    // if (subjectsf.isNotEmpty) {
    //   return subjectsf;
    // }
    changeState(currentState.copyChangingState(
        newState: RegisterForExamStateName.init));
    return subjectsf;
  }

  // void updateRegisters(WidgetRef ref) {
  //   changeState(currentState.copyChangingState(
  //       newState: RegisterForExamStateName.loading));
  //   ref.read(registersProvider.notifier).update();
  // }

  Future<bool> submitRegister(List registereds) async {
    changeState(currentState.copyChangingState(
        newState: RegisterForExamStateName.loading));
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
    changeState(currentState.copyChangingState(
        newState: RegisterForExamStateName.init));
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

// StateNotifier
@immutable
class Register {
  const Register({required this.id, required this.name, required this.check});

  final int id;
  final String name;
  final bool check;

  Register copyWith({int? id, String? name, bool? check}) {
    return Register(
      id: id ?? this.id,
      name: name ?? this.name,
      check: check ?? this.check,
    );
  }
}

// StateNotifierProvider
class RegisterNotifier extends StateNotifier<List<Register>> {
  RegisterNotifier() : super([]);

  void addRegister(Register register) {
    // Make a new list appending the new register
    state = [...state, register];
    // Note: changing "state" will rebuild the interface on the fly
  }

  void completeRegisters() async {
    List registereds = await IESSystem().registerForExamUseCase.registereds();
    print("completing...");
    for (final si
        in IESSystem().registerForExamUseCase.getSubjectsToRegister()) {
      bool checked = false;
      // registereds.where((element) => element.contains(si.name)).isNotEmpty;
      for (final regs in registereds) {
        if (si.id.toString() == regs) checked = true;
      }
      if (checked) {
        print("${si.name}: checked");
      }
      addRegister(Register(id: si.id, name: si.name, check: checked));
    }
  }

  // Delete`registers`
  void removeRegister(int registerId) {
    state = [
      for (final register in state)
        if (register.id != registerId) register,
    ];
  }

  // Toggle the check status of a register
  void toggle(int registerId) {
    state = [
      for (final register in state)
        if (register.id == registerId)
          register.copyWith(check: !register.check)
        else
          // other `registers` won't change
          register,
    ];
  }

  // Rebuild the state with the new changes from firestore
  void update() async {
    List registereds = await IESSystem().registerForExamUseCase.registereds();
    state = [
      for (final register in state)
        if (registereds.contains(register.id.toString()))
          register.copyWith(check: true)
        else
          register.copyWith(check: false)
    ];
    for (final s in state) {
      if (s.check) print("update: ${s.name}, ${s.id}");
    }
  }
}

var si = RegisterNotifier().completeRegisters();
// Finalmente, estamos usando StateNotifierProvider para permitir que la
// interfaz de usuario interactúe con nuestra clase RegisterNotifier.
final registersProvider =
    StateNotifierProvider<RegisterNotifier, List<Register>>((ref) {
  var reg = RegisterNotifier();
  reg.completeRegisters();
  return reg;
});
