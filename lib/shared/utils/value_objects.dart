import 'package:either_dart/either.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

enum FailureName { unknown }

class Validator {
  static Either<Failure, String> validateEmail({required String? email}) {
    if (email == null) {
      return (Left(Failure(
          failureName: FailureName.unknown,
          message: "Dirección de email no válida")));
    }
    String trimmedEmailString = email.trim();
    List<String> validExtensions = [
      '@gmail.com',
      '@yahoo.com',
      '@yahoo.com.ar',
      '@hotmail.com',
      '@mendoza.edu.ar'
    ];

    if ((trimmedEmailString == '') ||
        !((validExtensions.any((ext) => trimmedEmailString.endsWith(ext))))) {
      return (Left(Failure(
          failureName: FailureName.unknown,
          message: "Dirección de email no válida")));
    } else {
      return (Right(email));
    }
  }

  static Either<Failure, String> validatePassword({required String? password}) {
    if (password == null) {
      return (Left(Failure(
          failureName: FailureName.unknown,
          message: "Dirección de email no válida")));
    }
    String trimmedPasswordString = password.trim();

    if (trimmedPasswordString == '') {
      return (Left(Failure(
          failureName: FailureName.unknown, message: 'Contraseña no válida')));
    } else {
      return (Right(password));
    }
  }

  static Either<Failure, String> validateConfirmedPassword(
      {required String firstPassword, required String? confirmedPassword}) {
    if (confirmedPassword == null) {
      return (Left(Failure(
          failureName: FailureName.unknown, message: "Contraseña no válida")));
    }
    if (firstPassword.trim() != confirmedPassword.trim()) {
      return (Left(Failure(
          failureName: FailureName.unknown, message: 'Contraseña no válida')));
    } else {
      return (Right(confirmedPassword));
    }
  }

  static Either<Failure, String> validateUserFirtAndSurname(
      {required String? name}) {
    if (name == null) {
      return (Left(Failure(
          failureName: FailureName.unknown, message: "Nombre no válido")));
    }
    String trimmedEmailString = name.trim();
    if (trimmedEmailString == '') {
      return (Left(Failure(
          failureName: FailureName.unknown, message: "Nombre no válido")));
    } else {
      return (Right(name));
    }
  }

  static Either<Failure, String> validateDNIString({required String? dni}) {
    if (dni == null) {
      return (Left(
          Failure(failureName: FailureName.unknown, message: "DNI no válido")));
    }
    if (dni == '') {
      return (Left(
          Failure(failureName: FailureName.unknown, message: "DNI no válido")));
    } else {
      return (Right(dni));
    }
  }
}
