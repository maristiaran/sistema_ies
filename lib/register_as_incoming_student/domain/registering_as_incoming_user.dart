// import 'package:collection/collection.dart';
import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
// import 'package:sistema_ies/core/domain/entities/user_roles.dart';
// import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

enum RegisteringAsIncomingStudentStateName {
  init,
  failure,
  selectedSyllabusChanged,
  cancel,
  successfullyRegistered
}

class RegisteringAsIncomingStudentState extends OperationState {
  final Syllabus? selectedSyllabusIfAny;
  const RegisteringAsIncomingStudentState(
      {required RegisteringAsIncomingStudentStateName stateName,
      this.selectedSyllabusIfAny})
      : super(stateName: stateName);

  RegisteringAsIncomingStudentState newChangingState(
      RegisteringAsIncomingStudentStateName newStateName) {
    return RegisteringAsIncomingStudentState(
        stateName: newStateName, selectedSyllabusIfAny: selectedSyllabusIfAny);
  }

  RegisteringAsIncomingStudentState newChangingSyllabus(
      Syllabus? newSyllabusIfAny) {
    return RegisteringAsIncomingStudentState(
        stateName: stateName as RegisteringAsIncomingStudentStateName,
        selectedSyllabusIfAny: newSyllabusIfAny);
  }
}

class RegisteringAsIncomingStudentUseCase
    extends Operation<RegisteringAsIncomingStudentState> {
  final IESUser iesUser;
  RegisteringAsIncomingStudentUseCase({required this.iesUser})
      : super(const RegisteringAsIncomingStudentState(
            stateName: RegisteringAsIncomingStudentStateName.init));

  List<Syllabus> getRegisteringSyllabuses() {
    return IESSystem()
        .getSyllabusesRepository()
        .getAllSyllabuses()
        .where(
            (syllabus) => !iesUser.studentRolesSyllabuses().contains(syllabus))
        .toList();
  }

  void cancelRegistation() {
    IESSystem().homeUseCase.onReturnFromOperation();
  }

  void changeSelectedSyllabus(Syllabus? newSelectedSyllabus) {
    changeState(RegisteringAsIncomingStudentState(
        stateName:
            RegisteringAsIncomingStudentStateName.selectedSyllabusChanged,
        selectedSyllabusIfAny: newSelectedSyllabus));
  }

  void registerAsIncomingStudent() async {
    if (currentState.selectedSyllabusIfAny == null) {
      changeState(currentState
          .newChangingState(RegisteringAsIncomingStudentStateName.failure));
    } else {
      if (iesUser
          .studentRolesSyllabuses()
          .contains(currentState.selectedSyllabusIfAny)) {
        changeState(currentState
            .newChangingState(RegisteringAsIncomingStudentStateName.failure));
      } else {
        Either<Failure, Success> response = await IESSystem()
            .getUsersRepository()
            .registerAsIncomingStudent(
                iesUser: iesUser,
                syllabus: currentState.selectedSyllabusIfAny!);

        response.fold(
            (failure) => changeState(currentState.newChangingState(
                RegisteringAsIncomingStudentStateName.failure)), (success) {
          changeState(currentState.newChangingState(
              RegisteringAsIncomingStudentStateName.successfullyRegistered));
          IESSystem().homeUseCase.onReturnFromRegisteringAsIncommingStudent(
              currentState.selectedSyllabusIfAny == null
                  ? null
                  : Student(syllabus: currentState.selectedSyllabusIfAny!));
        });
      }
    }
  }
}
