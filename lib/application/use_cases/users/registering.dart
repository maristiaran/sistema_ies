import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/application/use_cases/users/auth.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/repositories/users_repository_port.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

enum RegisteringStateName {
  init,
  failure,
  registeredWaitingEmailValidation,
  verificationEmailSent
}

class RegisteringUseCase extends UseCase {
  List<Syllabus> syllabuses = [];
  Syllabus? currentSyllabus;
  Timer? _timer;

//Auth Use Case initialization
  RegisteringUseCase({required parentOperation})
      : super(parentOperation: parentOperation);

  @override
  OperationState initialState() {
    return const OperationState(stateName: RegisteringStateName.init);
  }

  @override
  Future<void> initializeRepositories() async {
    (await IESSystem().getSyllabusesRepository().getActiveSyllabuses())
        .fold((left) => syllabuses = [], (right) => syllabuses = right);
  }

  setCurrentSyllabus(Syllabus? newSyllabus) {
    currentSyllabus = newSyllabus;
    notifyStateChanges(changes: {"currentSyllabus": currentSyllabus});
  }

  void registerAsIncomingUser(
      {required String firstname,
      required String surname,
      required dni,
      required String email,
      required String password,
      required String confirmPassword,
      required DateTime birthdate}) async {
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
                (failure) => changeState(OperationState(
                    stateName: RegisteringStateName.failure,
                    changes: {'failure': failure.message})), (iesUser) {
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
    (parentOperation as AuthUseCase).restartLogin();
  }

  Future reSendEmailVerification() async {
    Either<Failure, Success> response =
        await IESSystem().getUsersRepository().reSendEmailVerification();
    response.fold(
        (failure) => changeState(OperationState(
            stateName: RegisteringStateName.failure,
            changes: {'failure': failure.message})), (success) {
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
      (parentOperation as AuthUseCase).restartLogin();
    }
  }
}
