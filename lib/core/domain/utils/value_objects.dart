import 'package:either_dart/either.dart';

enum FailureName { unknown }

enum Fields { name, lastname, birthday, dni, email, password, confirmPassword }

class Validator {
  //***************** VALIDATORS FOR LOGIN **********************//

  static Either<String, bool> validateEmailDNI(String valueEmailDNI) {
    bool hasOnlyNumbers = RegExp('^[0-9]*\$').hasMatch(valueEmailDNI);
    if (hasOnlyNumbers) {
      // should be a DNI, so:
      bool isItCorrect = validateByDNI(valueEmailDNI);
      if (isItCorrect) {
        return Right(isItCorrect);
      } else {
        return const Left("El DNI ingresado no es correcto");
      }
    } else {
      bool isItCorrect = validateByEmail(valueEmailDNI);
      if (isItCorrect) {
        return Right(isItCorrect);
      } else {
        return const Left("El email ingresado no es correcto");
      }
    }
  }

  static bool validateByDNI(String valueDNI) {
    bool itIsCorrect = RegExp('^[0-9]*^.{5,12}\$').hasMatch(valueDNI);

    return itIsCorrect;
  }

  static bool validateByEmail(String valueEmail) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(valueEmail);
  }
  //***************** VALIDATORS FOR REGISTER **********************//

  static Either<String, bool> validateRegisterForm(String value, Enum type) {
    switch (type) {
      case Fields.name:
        bool isItCorrect =
            RegExp(r'[^!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value);
        if (isItCorrect) {
          return Right(isItCorrect);
        } else {
          return const Left("Ingrese un nombre correcto");
        }
      case Fields.lastname:
        bool isItCorrect =
            RegExp(r'[^!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value);
        if (isItCorrect) {
          return Right(isItCorrect);
        } else {
          return const Left(
              "El apellido no es válido. Intente ingresarlo correctamente");
        }
      case Fields.dni:
        return validateEmailDNI(value);
      case Fields.email:
        return validateEmailDNI(value);
      case Fields.birthday:
        return const Right(true);
      case Fields.password:
        bool isItCorrect = RegExp(
                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(value);
        if (isItCorrect) {
          return Right(isItCorrect);
        } else {
          // return const Right(true);

          return const Left("La contraseña no es válida. Pruebe con otra");
        }
      default:
        return const Left("Algo ha salido mal");
    }
  }

  static Either<String, bool> validateBirthdate(DateTime value) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - value.year;

    if (currentDate.month < value.month ||
        (currentDate.month == value.month && currentDate.day < value.day)) {
      age--;
    }
    bool isOlder = RegExp(r'^(?:1[01][0-9]|120|1[7-9]|[2-9][0-9])$')
        .hasMatch(age.toString());

    if (isOlder) {
      return Right(isOlder);
    } else {
      return const Left("Tienes que ser mayor de 17 años para inscribirte");
    }
  }

  static Either<String, bool> confirmPassword(String value, password) {
    if (value == password.text) {
      return Right(value == password);
    } else {
      return const Left("Las contraseñas no coinciden");
    }
  }
}
