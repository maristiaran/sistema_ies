import 'package:hooks_riverpod/hooks_riverpod.dart';
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

class RegisteringState<RegisteringStateName> extends OperationState {
  const RegisteringState(
      {required stateName, required RegisteringUseCase registeringUseCase})
      : super(stateName: stateName, operation: registeringUseCase);

  selectedSyllabus() {
    return (operation as RegisteringUseCase).currentSyllabus;
  }
}

// LOGIN USE CASE
class RegisteringUseCase extends UseCase {
  List<Syllabus> syllabuses = [];
  Syllabus? currentSyllabus;

  setCurrentSyllabus(Syllabus? newSyllabus) {
    currentSyllabus = newSyllabus;
    notifyCurrentState();
  }

  //States notifiers
  // late OperationStateNotifier<LoginStateName> loginStateNotifier;
  // late StateNotifierProvider loginStateProvider;

//Auth Use Case initialization
  RegisteringUseCase({required parentOperation})
      : super(parentOperation: parentOperation);

  @override
  initializeUseCase() async {
    OperationStateNotifier<RegisteringState> newStateNotifier =
        OperationStateNotifier<RegisteringState<RegisteringStateName>>(
            initialState: RegisteringState<RegisteringStateName>(
                stateName: RegisteringStateName.init,
                registeringUseCase: this));
    stateNotifierProvider = StateNotifierProvider<
        OperationStateNotifier<RegisteringState>, RegisteringState>((ref) {
      return newStateNotifier;
    });
    stateNotifier = newStateNotifier;
    // await IESSystem().initializeSyllabusesRepository();
    (await IESSystem().getSyllabusesRepository().getActiveSyllabuses())
        .fold((left) => syllabuses = [], (right) => syllabuses = right);

    // currentSyllabus = syllabuses[0];
  }

  void initRegistering() {
    changeState(RegisteringState<RegisteringStateName>(
        stateName: RegisteringStateName.failure, registeringUseCase: this));
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
            (failure) => changeState(RegisteringState<RegisteringStateName>(
                stateName: RegisteringStateName.failure,
                registeringUseCase: this)),
            (user) => changeState(RegisteringState<RegisteringStateName>(
                stateName: RegisteringStateName.successfullyRegistered,
                registeringUseCase: this))));
  }
}
