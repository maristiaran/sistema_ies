import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/application_services.dart';
import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';

//Registering states

//Auth State Names
enum AuthState { login, registering }

enum LoginState { init, failure, successfullySignIn }

enum RegisteringState {
  init,
  failure,
  successfullyRegistered,
  waitingEmailValidation
}

// AUTORIZATION USE CASE
class AuthUseCase extends Operation {
  //Accessors
  late List<Syllabus> syllabuses;
  late Syllabus currentSyllabus;
//States notifiers
  late OperationStateNotifier<AuthState> authStateNotifier;
  late StateNotifierProvider authStateProvider;

  late OperationStateNotifier<LoginState> loginStateNotifier;
  late StateNotifierProvider loginStateProvider;

  late OperationStateNotifier<RegisteringState> registeringStateNotifier;
  late StateNotifierProvider registeringStateProvider;

//Auth Use Case initialization
  AuthUseCase({required this.syllabuses}) {
    currentSyllabus = syllabuses[0];
  }
  @override
  initializeStateNotifiers() {
    authStateNotifier = OperationStateNotifier(
        initialState: const OperationState(stateName: AuthState.login));
    authStateProvider = StateNotifierProvider<OperationStateNotifier<AuthState>,
        OperationState>((ref) {
      return authStateNotifier;
    });
    loginStateNotifier = OperationStateNotifier(
        initialState: const OperationState(stateName: LoginState.init));
    loginStateProvider = StateNotifierProvider<
        OperationStateNotifier<LoginState>, OperationState>((ref) {
      return loginStateNotifier;
    });
    registeringStateNotifier = OperationStateNotifier(
        initialState: const OperationState(stateName: RegisteringState.init));
    registeringStateProvider = StateNotifierProvider<
        OperationStateNotifier<RegisteringState>, OperationState>((ref) {
      return registeringStateNotifier;
    });
  }

  setCurrentSyllabus(Syllabus newSyllabus) {
    currentSyllabus = newSyllabus;
  }

  void signIn(String userName, String password) async {
    IESSystem()
        .getUsersRepository()
        .signInUsingEmailAndPassword(email: userName, password: password)
        .then((signInResponse) => signInResponse.fold(
            (failure) => loginStateNotifier.changeState(
                const OperationState(stateName: LoginState.failure)),
            (user) => loginStateNotifier.changeState(const OperationState(
                stateName: LoginState.successfullySignIn))));
  }

  void startRegisteringIncomingUser() {
    // print("start reg");
    authStateNotifier
        .changeState(const OperationState(stateName: AuthState.registering));
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
            (failure) => registeringStateNotifier.changeState(
                const OperationState(stateName: RegisteringState.failure)),
            (user) => registeringStateNotifier.changeState(const OperationState(
                stateName: RegisteringState.successfullyRegistered))));
  }
}
