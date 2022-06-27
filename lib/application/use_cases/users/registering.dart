import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/application/use_cases/users/auth.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';

enum RegisteringStateName {
  init,
  failure,
  successfullyRegistered,
  waitingEmailValidation
}

class RegisteringUseCase extends UseCase {
  List<Syllabus> syllabuses = [];
  Syllabus? currentSyllabus;

//Auth Use Case initialization
  RegisteringUseCase({required parentOperation})
      : super(parentOperation: parentOperation);

  @override
  OperationState initialState() {
    return const OperationState(stateName: RegisteringStateName.init);
  }

  @override
  Future<void> initializeRepositories() async {
    (await IESSystem().getSyllabusesRepository().getActiveSyllabuses())
        .fold((left) => syllabuses = [], (right) => syllabuses = right);
  }

  setCurrentSyllabus(Syllabus? newSyllabus) {
    currentSyllabus = newSyllabus;
    notifyStateChanges(changes: {"currentSyllabus": currentSyllabus});
  }

  void registerAsIncomingUser(
      {required String firstname,
      required String surname,
      required dni,
      required String email,
      required String password,
      required String confirmPassword,
      required Syllabus? syllabus}) async {
    IESSystem()
        .getUsersRepository()
        .registerIncomingStudent(
            email: email,
            password: password,
            dni: dni!,
            firstname: firstname,
            surname: surname,
            syllabus: syllabus!)
        .then((registerResponse) => registerResponse.fold(
            (failure) => changeState(
                const OperationState(stateName: RegisteringStateName.failure)),
            (success) => changeState(const OperationState(
                stateName: RegisteringStateName.successfullyRegistered))));
  }

  void initRegistering() {
    changeState(const OperationState(stateName: RegisteringStateName.init));
  }

  returnToLogin() {
    (parentOperation as AuthUseCase).startLogin();
  }
}
