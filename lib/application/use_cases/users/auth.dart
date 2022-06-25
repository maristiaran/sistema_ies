import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/application/use_cases/users/login.dart';
import 'package:sistema_ies/application/use_cases/users/registering.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';

//Registering states

//Auth State Names
enum AuthState { login, registering }

// AUTORIZATION
class AuthUseCase extends UseCase {
  // Use cases
  late LoginUseCase loginUseCase;
  late RegisteringUseCase registeringUseCase;

  //Accessors
  late List<Syllabus> syllabuses;
  late Syllabus currentSyllabus;

//Auth Use Case initialization
  AuthUseCase({required Operation parentOperation})
      : super(parentOperation: parentOperation);

  @override
  initializeUseCase() async {
    OperationStateNotifier<OperationState> newStateNotifier =
        OperationStateNotifier<OperationState>(
            initialState:
                OperationState(stateName: AuthState.login, operation: this));
    stateNotifierProvider = StateNotifierProvider<
        OperationStateNotifier<OperationState>, OperationState>((ref) {
      return newStateNotifier;
    });
    stateNotifier = newStateNotifier;
  }

  void startLogin() async {
    loginUseCase = LoginUseCase(authUseCase: this);
    await loginUseCase.initializeUseCase();
    changeState(OperationState(stateName: AuthState.login, operation: this));
    loginUseCase.initLogin();
  }

  void startRegisteringIncomingUser() async {
    registeringUseCase = RegisteringUseCase(parentOperation: this);
    await registeringUseCase.initializeUseCase();
    changeState(
        OperationState(stateName: AuthState.registering, operation: this));
    registeringUseCase.initRegistering();
  }
}
