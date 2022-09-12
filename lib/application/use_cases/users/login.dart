import 'package:either_dart/either.dart';
import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/shared/repositories/users_repository_port.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

//Login states

enum LoginStateName {
  init,
  failure,
  emailNotVerifiedFailure,
  successfullySignIn,
  passwordResetSent,
  verificationEmailSent
}

// LOGIN USE CASE
class LoginUseCase extends UseCase {
//Auth Use Case initialization
  LoginUseCase() : super();

  @override
  OperationState initialState() {
    return const OperationState(stateName: LoginStateName.init);
  }

  void initLogin() {
    changeState(const OperationState(stateName: LoginStateName.init));
  }

  Future signIn(String userDNIOrEmail, String password) async {
    if (userDNIOrEmail == "") {
      changeState(const OperationState(
          stateName: LoginStateName.failure,
          changes: {'failure': 'El dni o email no puede ser un texto vacio'}));
      return null;
    }
    String userEmail = userDNIOrEmail;
    if (!userDNIOrEmail.contains('@')) {
      await IESSystem()
          .getUsersRepository()
          .getIESUserByDNI(dni: int.parse(userDNIOrEmail))
          .then((getIESUserByDNI) => getIESUserByDNI.fold(
                  (failure) => changeState(OperationState(
                      stateName: LoginStateName.failure,
                      changes: {'failure': failure.message})), (iesUser) {
                userEmail = iesUser.email;
              }));
    }
    await IESSystem()
        .getUsersRepository()
        .signInUsingEmailAndPassword(email: userEmail, password: password)
        .then((signInResponse) => signInResponse.fold((failure) {
              if (failure.failureName ==
                  UsersRepositoryFailureName.notVerifiedEmail) {
                changeState(OperationState(
                    stateName: LoginStateName.emailNotVerifiedFailure,
                    changes: {'failure': failure.message}));
              } else {
                changeState(OperationState(
                    stateName: LoginStateName.failure,
                    changes: {'failure': failure.message}));
              }
            }, (iesUser) {
              IESSystem().setCurrentIESUserIfAny(iesUser);
              changeState(const OperationState(
                  stateName: LoginStateName.successfullySignIn));
              // TODO: default role;
              // if (iesUser.roles.length > 1) {
              //   (parentOperation as HomeUseCase).startSelectingUserRole();
              // } else {
              //   (parentOperation as HomeUseCase)
              //       .startSelectingUserRoleOperation();
              // }
            }));
  }

  Future reSendEmailVerification() async {
    Either<Failure, Success> response =
        await IESSystem().getUsersRepository().reSendEmailVerification();
    response.fold(
        (failure) => changeState(OperationState(
            stateName: LoginStateName.failure,
            changes: {'failure': failure.message})), (success) {
      changeState(const OperationState(
          stateName: LoginStateName.verificationEmailSent));
      // changeState(const OperationState(stateName: LoginStateName.init));
    });
  }

  void startRegisteringIncomingUser() async {
    IESSystem().startRegisteringNewUser();
  }

  Future changePassword(String email) async {
    Either<Failure, Success> response =
        await IESSystem().getUsersRepository().resetPasswordEmail(email: email);
    response.fold((failure) {
      changeState(OperationState(
          stateName: LoginStateName.failure,
          changes: {'failure': failure.message}));
      // changeState(const OperationState(stateName: LoginStateName.init));
    }, (success) {
      changeState(
          const OperationState(stateName: LoginStateName.passwordResetSent));
      // changeState(const OperationState(stateName: LoginStateName.init));
    });
  }
}
