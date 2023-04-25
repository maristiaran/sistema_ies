import 'dart:async';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

import '../presentation/register_form.dart';

enum RegisteringStateName {
  init,
  failure,
  registeredWaitingEmailValidation,
  verificationEmailSent,
  loading,
  success
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
    changeState(const OperationState(stateName: RegisteringStateName.loading));
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
                (failure) => changeState(const OperationState(
                    stateName: RegisteringStateName.failure)), (iesUser) {
              _timer = Timer.periodic(const Duration(seconds: 3),
                  (timer) => restartLoginIUserEmailVerified());
              changeState(const OperationState(
                  stateName: RegisteringStateName.success));
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

// Pasword Handler
class PasswordHandler {
  PasswordHandler(
      this.passwordFieldVisibility,
      this.confirmFieldVisibility,
      this.passHasEightCharacters,
      this.passHasAtLeastOneNumber,
      this.passHasUppercaseKey,
      this.passHasLowercaseKey,
      this.passHasASpecialCharacter);
  final bool passwordFieldVisibility;
  final bool confirmFieldVisibility;
  final bool passHasEightCharacters;
  final bool passHasAtLeastOneNumber;
  final bool passHasUppercaseKey;
  final bool passHasLowercaseKey;
  final bool passHasASpecialCharacter;
}

class PasswordHandlerNotifier extends StateNotifier<PasswordHandler> {
  PasswordHandlerNotifier()
      : super(PasswordHandler(false, false, false, false, false, false, false));

  PasswordHandler passState() {
    return state;
  }

  void switchStatePasswordField() {
    state = PasswordHandler(
        !passState().passwordFieldVisibility,
        passState().confirmFieldVisibility,
        passState().passHasEightCharacters,
        passState().passHasAtLeastOneNumber,
        passState().passHasUppercaseKey,
        passState().passHasLowercaseKey,
        passState().passHasASpecialCharacter);
  }

  void switchStatePasswordConfirmField() {
    state = PasswordHandler(
        passState().passwordFieldVisibility,
        !passState().confirmFieldVisibility,
        passState().passHasEightCharacters,
        passState().passHasAtLeastOneNumber,
        passState().passHasUppercaseKey,
        passState().passHasLowercaseKey,
        passState().passHasASpecialCharacter);
  }

  void verifierCorrectPass(String pass) {
    final numericRegex = RegExp(r'[0-9]+');
    final uppercaseRegex = RegExp(r'[A-Z]+');
    final lowercaseRegex = RegExp(r'[a-z]+');
    final passLengthRegex = RegExp(r'^.{8,}$');
    final specialCharacterRegex = RegExp(r'([@"#%&/\(\)=¿*$?¡\-_!])+');
    // If pass has more than 8 characters
    state = passLengthRegex.hasMatch(pass)
        ? PasswordHandler(
            passState().passwordFieldVisibility,
            passState().confirmFieldVisibility,
            true,
            passState().passHasAtLeastOneNumber,
            passState().passHasUppercaseKey,
            passState().passHasLowercaseKey,
            passState().passHasASpecialCharacter)
        : PasswordHandler(
            passState().passwordFieldVisibility,
            passState().confirmFieldVisibility,
            false,
            passState().passHasAtLeastOneNumber,
            passState().passHasUppercaseKey,
            passState().passHasLowercaseKey,
            passState().passHasASpecialCharacter);

    // If pass has at least one number
    state = numericRegex.hasMatch(pass)
        ? PasswordHandler(
            passState().passwordFieldVisibility,
            passState().confirmFieldVisibility,
            passState().passHasEightCharacters,
            true,
            passState().passHasUppercaseKey,
            passState().passHasLowercaseKey,
            passState().passHasASpecialCharacter)
        : PasswordHandler(
            passState().passwordFieldVisibility,
            passState().confirmFieldVisibility,
            passState().passHasEightCharacters,
            false,
            passState().passHasUppercaseKey,
            passState().passHasLowercaseKey,
            passState().passHasASpecialCharacter);
    // If pass has at least one capital letter
    state = uppercaseRegex.hasMatch(pass)
        ? PasswordHandler(
            passState().passwordFieldVisibility,
            passState().confirmFieldVisibility,
            passState().passHasEightCharacters,
            passState().passHasAtLeastOneNumber,
            true,
            passState().passHasLowercaseKey,
            passState().passHasASpecialCharacter)
        : PasswordHandler(
            passState().passwordFieldVisibility,
            passState().confirmFieldVisibility,
            passState().passHasEightCharacters,
            passState().passHasAtLeastOneNumber,
            false,
            passState().passHasLowercaseKey,
            passState().passHasASpecialCharacter);

    // If pass has at least one lower case
    state = lowercaseRegex.hasMatch(pass)
        ? PasswordHandler(
            passState().passwordFieldVisibility,
            passState().confirmFieldVisibility,
            passState().passHasEightCharacters,
            passState().passHasAtLeastOneNumber,
            passState().passHasUppercaseKey,
            true,
            passState().passHasASpecialCharacter)
        : PasswordHandler(
            passState().passwordFieldVisibility,
            passState().confirmFieldVisibility,
            passState().passHasEightCharacters,
            passState().passHasAtLeastOneNumber,
            passState().passHasUppercaseKey,
            false,
            passState().passHasASpecialCharacter);

    // If pass has at least one capital letter
    state = specialCharacterRegex.hasMatch(pass)
        ? PasswordHandler(
            passState().passwordFieldVisibility,
            passState().confirmFieldVisibility,
            passState().passHasEightCharacters,
            passState().passHasAtLeastOneNumber,
            passState().passHasUppercaseKey,
            passState().passHasLowercaseKey,
            true)
        : PasswordHandler(
            passState().passwordFieldVisibility,
            passState().confirmFieldVisibility,
            passState().passHasEightCharacters,
            passState().passHasAtLeastOneNumber,
            passState().passHasUppercaseKey,
            passState().passHasLowercaseKey,
            false);
  }
}

