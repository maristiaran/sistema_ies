import 'package:either_dart/either.dart';

import '../../presentation/widgets/fields/field_names.dart';

enum FailureName { unknown }

class Validator {
  //***************** VALIDATORS FOR LOGIN **********************//

  static Either<String, bool> validateEmailDNI(String valueEmailDNI) {
    bool hasOnlyNumbers = RegExp('^[0-9]*\$').hasMatch(
        valueEmailDNI); // First we verified if the input is Email or DNI
    if (hasOnlyNumbers) {
      // if it has just numbers it should be a DNI so:
      bool isDocumentCorrect = RegExp('^[0-9]*^.{5,12}\$').hasMatch(
          valueEmailDNI); // we verified if the document meets the requirements
      if (isDocumentCorrect) {
        // if it meets the requirements, we'll response with true in Right side, else response with error in Left side
        return Right(isDocumentCorrect);
      } else {
        return const Left("El DNI ingresado no es correcto");
      }
    } else {
      bool isEmailCorrect = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+") // if input is Email, we verified it meets the format, example:'name@email.com'
          .hasMatch(valueEmailDNI);
      if (isEmailCorrect) {
        // if email is correct, we'll response with true in Right side, else response with error in Left side
        return Right(isEmailCorrect);
      } else {
        return const Left("El email ingresado no es correcto");
      }
    }
  }

  //***************** VALIDATORS FOR REGISTER **********************//

  static Either<String, bool> validateRegisterForm(String value, Enum type) {
    switch (type) {
      // NAME
      case Fields.name:
        bool isNameCorrect =
            RegExp(r'[^!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value);
        if (isNameCorrect) {
          return Right(isNameCorrect);
        } else {
          return const Left("El nombre no es válido");
        }
      // LASTNAME
      case Fields.lastname:
        bool isLastnameCorrect =
            RegExp(r'[^!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value);
        if (isLastnameCorrect) {
          return Right(isLastnameCorrect);
        } else {
          return const Left("El apellido no es válido");
        }
      // DNI
      case Fields.dni:
        return validateEmailDNI(value);
      // EMAIL
      case Fields.email:
        return validateEmailDNI(value);
      /* // BIRTHDAY
      case Fields.birthday:
        return const Right(true); */
      // PASSWORD
      case Fields.password:
        if (RegExp(r'\s').hasMatch(value)) {
          return const Left('La contraseña no puede contener espacios');
        } else {
          if (RegExp(
                  r'^(?=.*\d)(?=^\S+$)(?=.+[0-9])(?=.+[@"#%&/\(\)=¿*$?¡\-_!])(?=.*[a-z])(?=.*[A-Z])(?=.+[a-zA-Z]).{8,}$')
              .hasMatch(value)) {
            return const Right(true);
          } else {
            return const Left("La contraseña no es válida. Pruebe con otra");
          }
        }
      default:
        return const Left("Algo ha salido mal");
    }
  }

  static Either<String, bool> confirmPassword(String value, password) {
    if (value == password.text) {
      return Right(value == password);
    } else {
      return const Left("Las contraseñas no coinciden");
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
}
