import 'dart:async';

import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/repositories/users_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

//Login states

enum LoginStateName {
  init,
  failure,
  emailNotVerifiedFailure,
  successfullySignIn,
  passwordResetSent,
  recoverypass,
  verificationEmailSent
}

class LoginState extends OperationState {
  final IESUser? currentIESUserIfAny;
  // final IESUser? currentIESUserRole;

  const LoginState({required this.currentIESUserIfAny, required stateName})
      : super(stateName: stateName);

  @override
  List<Object?> get props => [];

  LoginState copyChangingState({required LoginStateName newState}) {
    return LoginState(
        currentIESUserIfAny: currentIESUserIfAny, stateName: newState);
  }
}

// LOGIN USE CASE
class LoginUseCase extends Operation<LoginState> {
//Auth Use Case initialization
  LoginUseCase()
      : super(const LoginState(
            currentIESUserIfAny: null, stateName: LoginStateName.init));

  Future signIn(String userDNIOrEmail, String password) async {
    if (userDNIOrEmail == "") {
      changeState(
          currentState.copyChangingState(newState: LoginStateName.failure));
      return null;
    }
    String userEmail = userDNIOrEmail;
    if (!userDNIOrEmail.contains('@')) {
      await IESSystem()
          .getUsersRepository()
          .getIESUserByDNI(dni: int.parse(userDNIOrEmail))
          .then((getIESUserByDNI) => getIESUserByDNI.fold(
                  (failure) => changeState(currentState.copyChangingState(
                      newState: LoginStateName.failure)), (iesUser) {
                userEmail = iesUser.email;
              }));
    }
    await IESSystem()
        .getUsersRepository()
        .signInUsingEmailAndPassword(email: userEmail, password: password)
        .then((signInResponse) => signInResponse.fold((failure) {
              if (failure.failureName ==
                  UsersRepositoryFailureName.notVerifiedEmail) {
                changeState(currentState.copyChangingState(
                    newState: LoginStateName.emailNotVerifiedFailure));
              } else {
                changeState(currentState.copyChangingState(
                    newState: LoginStateName.failure));
              }
            }, (iesUser) {
              changeState(LoginState(
                  currentIESUserIfAny: iesUser,
                  stateName: LoginStateName.successfullySignIn));
              IESSystem().onUserLogged(iesUser);
            }));
  }

  Future reSendEmailVerification() async {
    Either<Failure, Success> response =
        await IESSystem().getUsersRepository().reSendEmailVerification();
    response.fold(
        (failure) => changeState(
            currentState.copyChangingState(newState: LoginStateName.failure)),
        (success) {
      changeState(currentState.copyChangingState(
          newState: LoginStateName.verificationEmailSent));
    });
  }

  void startRegisteringIncomingUser() async {
    IESSystem().startRegisteringNewUser();
  }

  void startRecoveryPass() {
    changeState(
        currentState.copyChangingState(newState: LoginStateName.recoverypass));
  }

  Future changePassword(String email) async {
    Either<Failure, Success> response =
        await IESSystem().getUsersRepository().resetPasswordEmail(email: email);
    response.fold((failure) {
      changeState(
          currentState.copyChangingState(newState: LoginStateName.failure));
    }, (success) {
      changeState(currentState.copyChangingState(
          newState: LoginStateName.passwordResetSent));
    });
  }

  returnToLogin() {
    changeState(currentState.copyChangingState(newState: LoginStateName.init));
  }
}
