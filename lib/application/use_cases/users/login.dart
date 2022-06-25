import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/application/use_cases/users/auth.dart';

//Login states

enum LoginStateName { init, failure, successfullySignIn }

// LOGIN USE CASE
class LoginUseCase extends UseCase {
//Auth Use Case initialization
  LoginUseCase({required AuthUseCase authUseCase})
      : super(parentOperation: authUseCase);

  @override
  initializeUseCase() {
    OperationStateNotifier<OperationState> newStateNotifier =
        OperationStateNotifier<OperationState<LoginStateName>>(
            initialState: OperationState(
                stateName: LoginStateName.init, operation: this));
    stateNotifierProvider = StateNotifierProvider<
        OperationStateNotifier<OperationState>, OperationState>((ref) {
      return newStateNotifier;
    });
    stateNotifier = newStateNotifier;
  }

  void initLogin() {
    changeState(
        OperationState(stateName: LoginStateName.init, operation: this));
  }

  void signIn(String userName, String password) async {
    IESSystem()
        .getUsersRepository()
        .signInUsingEmailAndPassword(email: userName, password: password)
        .then((signInResponse) => signInResponse.fold(
            (failure) => changeState(OperationState(
                stateName: LoginStateName.failure, operation: this)),
            (user) => changeState(OperationState(
                stateName: LoginStateName.successfullySignIn,
                operation: this))));
  }

  void startRegisteringIncomingUser() async {
    (parentOperation as AuthUseCase).startRegisteringIncomingUser();
  }
}
