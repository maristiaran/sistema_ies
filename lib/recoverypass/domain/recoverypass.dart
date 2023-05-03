import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

enum RecoveryStateName {
  init,
  failure,
  successfull,
  recoverypass,
  loading,
  passwordResetSent
}

class RecoveryPassUseCase extends Operation {
  RecoveryPassUseCase()
      : super(const OperationState(stateName: RecoveryStateName.init));

  Future changePassword(String email) async {
    changeState(const OperationState(stateName: RecoveryStateName.loading));
    Either<Failure, Success> response =
        await IESSystem().getUsersRepository().resetPasswordEmail(email: email);
    response.fold(
        (failure) => changeState(
            const OperationState(stateName: RecoveryStateName.failure)),
        (success) {
      changeState(
          const OperationState(stateName: RecoveryStateName.passwordResetSent));
    });
  }

  returnToLogin() {
    IESSystem().restartLogin();
  }
}
