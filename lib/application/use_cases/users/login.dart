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
  OperationState initialState() {
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
                (failure) => changeState(OperationState(
                    stateName: LoginStateName.failure,
                    changes: {'failure': failure.message})), (user) {
              return changeState(const OperationState(
                  stateName: LoginStateName.successfullySignIn));
            }));
  }

  void startRegisteringIncomingUser() async {
    (parentOperation as AuthUseCase).startRegisteringIncomingUser();
  }
}
