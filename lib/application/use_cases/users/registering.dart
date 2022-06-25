import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';

//Login states

enum RegisteringStateName {
  init,
  failure,
  successfullyRegistered,
  waitingEmailValidation
}

// LOGIN USE CASE
class RegisteringUseCase extends UseCase {
  List<Syllabus> syllabuses = [];
  Syllabus? currentSyllabus;

//Auth Use Case initialization
  RegisteringUseCase({required parentOperation})
      : super(parentOperation: parentOperation);

  @override
  OperationState<RegisteringStateName> initialState() {
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

  void initRegistering() {
    changeState(const OperationState<RegisteringStateName>(
        stateName: RegisteringStateName.failure));
  }

  void registerAsIncomingUser(
      {required String userName,
      required String password,
      required int uniqueNumber,
      required String firstname,
      required String surname,
      required Syllabus syllabus}) async {
    IESSystem()
        .getUsersRepository()
        .registerIncomingStudent(
            email: userName,
            password: password,
            uniqueNumber: uniqueNumber,
            firstname: firstname,
            surname: surname,
            syllabus: syllabus)
        .then((registerResponse) => registerResponse.fold(
            (failure) => changeState(const OperationState<RegisteringStateName>(
                stateName: RegisteringStateName.failure)),
            (user) => changeState(const OperationState<RegisteringStateName>(
                stateName: RegisteringStateName.successfullyRegistered))));
  }
}
