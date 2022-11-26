import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
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
    List<Syllabus> iesUserSyllabuses;
    Student? studentRoleIfAny = iesUser.studentRoleIfAny();
    if (studentRoleIfAny == null) {
      iesUserSyllabuses = [];
    } else {
      iesUserSyllabuses = studentRoleIfAny.syllabuses;
    }
    print('-------yy------');

    for (Syllabus s
        in IESSystem().getSyllabusesRepository().getAllSyllabuses()) {
      print(s.administrativeResolution);
    }

    print('-------ii-------');
    print(iesUserSyllabuses);
    print('--------------');
    // return IESSystem().getSyllabusesRepository().getAllSyllabuses();
    return IESSystem().getSyllabusesRepository().getAllSyllabuses();
    // return IESSystem()
    //     .getSyllabusesRepository()
    //     .getAllSyllabuses()
    //     .where((syllabus) => !iesUserSyllabuses.contains(syllabus))
    //     .toList();
  }

  void cancelRegistation() {
    IESSystem().onReturnFromOperation();
  }

  void changeSelectedSyllabus(Syllabus? newSelectedSyllabus) {
    changeState(RegisteringAsIncomingStudentState(
        stateName:
            RegisteringAsIncomingStudentStateName.selectedSyllabusChanged,
        selectedSyllabusIfAny: newSelectedSyllabus));
  }

  void registerAsIncomingStudent() async {
    print("entro");
    if (currentState.selectedSyllabusIfAny == null) {
      print("entro1");
      changeState(currentState
          .newChangingState(RegisteringAsIncomingStudentStateName.failure));
    } else {
      print("entro2");
      Either<Failure, IESUser> response = IESSystem()
          .getUsersRepository()
          .registerAsIncomingStudent(
              iesUser: iesUser, syllabus: currentState.selectedSyllabusIfAny!);
      print("entro3r");
      response.fold(
          (failure) => changeState(currentState.newChangingState(
              RegisteringAsIncomingStudentStateName.failure)), (iesUser) {
        changeState(currentState.newChangingState(
            RegisteringAsIncomingStudentStateName.successfullyRegistered));
        IESSystem().onReturnFromOperation();
      });
    }
  }
}
