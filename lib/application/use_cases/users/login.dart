import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/application/use_cases/users/auth.dart';

//Login states

enum LoginStateName { init, failure, successfullySignIn }

// LOGIN USE CASE
class LoginUseCase extends UseCase<LoginStateName> {
//Auth Use Case initialization
  LoginUseCase({required AuthUseCase authUseCase})
      : super(parentOperation: authUseCase);

  @override
  OperationState<LoginStateName> initialState() {
    return const OperationState(stateName: LoginStateName.init);
  }

  void initLogin() {
    changeState(const OperationState(stateName: LoginStateName.init));
  }

  void signIn(String userName, String password) async {
    IESSystem()
        .getUsersRepository()
        .signInUsingEmailAndPassword(email: userName, password: password)
        .then((signInResponse) => signInResponse.fold(
            (failure) => changeState(
                const OperationState(stateName: LoginStateName.failure)),
            (user) => changeState(const OperationState(
                stateName: LoginStateName.successfullySignIn))));
  }

  void startRegisteringIncomingUser() async {
    (parentOperation as AuthUseCase).startRegisteringIncomingUser();
  }
}
