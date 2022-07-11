import 'package:either_dart/either.dart';
import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/application/use_cases/users/auth.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

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

  Future signIn(String userName, String password) async {
    await IESSystem()
        .getUsersRepository()
        .signInUsingEmailAndPassword(email: userName, password: password)
        .then((signInResponse) => signInResponse.fold(
                (failure) => changeState(OperationState(
                    stateName: LoginStateName.failure,
                    changes: {'failure': failure.message})), (user) {
              // IESSystem().setCurrentUser(user);
              changeState(const OperationState(
                  stateName: LoginStateName.successfullySignIn));
            }));
  }

  Future reSendEmailVerification() async {
    Either<Failure, Success> response =
        await IESSystem().getUsersRepository().reSendEmailVerification();
    response.fold(
        (failure) => changeState(OperationState(
            stateName: LoginStateName.failure,
            changes: {'failure': failure.message})),
        (success) => null);
  }

  void startRegisteringIncomingUser() async {
    (parentOperation as AuthUseCase).startRegisteringIncomingUser();
  }

  Future changePassword(String email) async {
    Either<Failure, Success> response =
        await IESSystem().getUsersRepository().resetPasswordEmail(email: email);
    response.fold(
        (failure) => changeState(OperationState(
            stateName: LoginStateName.failure,
            changes: {'failure': failure.message})),
        (success) => null);
  }
}
