import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

enum RegisteringStateName {
  init,
  failure,
  registeredWaitingEmailValidation,
  verificationEmailSent
}

class RegisteringUseCase extends Operation {
  List<Syllabus> syllabuses = [];
  Syllabus? currentSyllabus;
  Timer? _timer;

//Auth Use Case initialization
  RegisteringUseCase()
      : super(const OperationState(stateName: RegisteringStateName.init));

  setCurrentSyllabus(Syllabus? newSyllabus) {
    currentSyllabus = newSyllabus;
    // notifyStateChanges(changes: {"currentSyllabus": currentSyllabus});
  }

  void registerAsIncomingUser(
      {required String firstname,
      required String surname,
      required dni,
      required String email,
      required String password,
      required String confirmPassword,
      required DateTime birthdate}) async {
    //  IESUser newIESUser = IESUser(
    //             firstname: firstname,
    //             surname: surname,
    //             birthdate: birthdate,
    //             dni: dni,
    //             email: email);

    IESSystem()
        .getUsersRepository()
        .registerNewIESUser(
            email: email,
            password: password,
            dni: dni!,
            firstname: firstname,
            surname: surname,
            birthdate: birthdate)
        .then((registerResponse) => registerResponse.fold(
                (failure) => changeState(
                    const OperationState(stateName: RegisteringStateName.failure
                        // ,
                        // changes: {'failure': failure.message}

                        )), (iesUser) {
              _timer = Timer.periodic(const Duration(seconds: 3),
                  (timer) => restartLoginIUserEmailVerified());
              changeState(const OperationState(
                  stateName:
                      RegisteringStateName.registeredWaitingEmailValidation));
            }));
  }

  void initRegistering() {
    changeState(const OperationState(stateName: RegisteringStateName.init));
  }

  returnToLogin() {
    if (_timer != null) {
      _timer!.cancel();
    }
    IESSystem().restartLogin();
  }

  Future reSendEmailVerification() async {
    Either<Failure, Success> response =
        await IESSystem().getUsersRepository().reSendEmailVerification();
    response.fold(
        (failure) => changeState(
            const OperationState(stateName: RegisteringStateName.failure
                // ,
                // changes: {'failure': failure.message}

                )), (success) {
      changeState(const OperationState(
          stateName: RegisteringStateName.verificationEmailSent));
      // changeState(const OperationState(stateName: LoginStateName.init));
    });
  }

  restartLoginIUserEmailVerified() async {
    bool isVerified =
        await IESSystem().getUsersRepository().getCurrentUserIsEMailVerified();
    if (isVerified) {
      _timer!.cancel();
      IESSystem().restartLogin();
    }
  }
}
