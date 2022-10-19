import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:sistema_ies/core/domain/utils/datetime.dart';
import 'package:sistema_ies/core/domain/utils/value_objects.dart';

final Map fieldNames = {
  Fields.name: "Nombre",
  Fields.lastname: "Apellido",
  Fields.birthday: "Fecha de nacimiento",
  Fields.dni: "DNI",
  Fields.email: "Email",
  Fields.password: "Contraseña",
  Fields.confirmPassword: "Confirmar contraseña"
};

TextFormField fieldEmail(controller, text, obscure, context) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (String? value) {
      if (value!.isNotEmpty) {
        if (Validator.validateEmailDNI(value).isRight) {
          return null;
        } else {
          return Validator.validateEmailDNI(value).left;
        }
      } else {
        return "Ingrese un Email o su DNI";
      }
    },
    decoration: InputDecoration(
      labelText: text,
      filled: true,
      fillColor: Theme.of(context).colorScheme.tertiary,
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    ),
  );
}

TextFormField fieldPassword(controller, text, obscure, context) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (String? value) {
      if (value!.isNotEmpty) {
        return null;
      } else {
        return "El campo contraseña no puede estar vacío";
      }
    },
    decoration: InputDecoration(
      labelText: text,
      filled: true,
      fillColor: Theme.of(context).colorScheme.tertiary,
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    ),
  );
}

TextFormField fieldRegister(controller, text, obscure, context) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value!.isNotEmpty) {
        if (Validator.validateRegisterForm(value, text).isRight) {
          return null;
        } else {
          return Validator.validateRegisterForm(value, text).left;
        }
      } else {
        return "El campo ${fieldNames[text]} no puede estar vacío";
      }
    },
    decoration: InputDecoration(
      labelText: fieldNames[text],
      labelStyle: const TextStyle(color: Color.fromARGB(255, 63, 63, 63)),
      filled: true,
      fillColor: Theme.of(context).colorScheme.tertiary,
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    ),
  );
}

TextFormField fieldConfirmPassword(
    controller, text, oldPassword, obscure, context) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (value) {
      if (value!.isNotEmpty) {
        if (Validator.confirmPassword(value, oldPassword).isRight) {
          return null;
        } else {
          return Validator.confirmPassword(value, oldPassword).left;
        }
      } else {
        return "El campo ${fieldNames[text]} no puede estar vacío";
      }
    },
    decoration: InputDecoration(
      labelText: fieldNames[text],
      labelStyle: const TextStyle(color: Color.fromARGB(255, 63, 63, 63)),
      filled: true,
      fillColor: Theme.of(context).colorScheme.tertiary,
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Colors.red,
        ),
      ),
    ),
  );
}

Widget fieldBirthday(controller, text, context) {
  return DateTimeFormField(
    decoration: InputDecoration(
      labelStyle: const TextStyle(color: Color.fromARGB(255, 63, 63, 63)),
      labelText: fieldNames[text],
      suffixIcon: Icon(
        FontAwesomeIcons.calendarDay,
        color: Theme.of(context).colorScheme.secondary,
      ),
      filled: true,
      fillColor: Theme.of(context).colorScheme.tertiary,
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    ),
    initialValue: DateTime.now(),
    dateFormat: DateFormat("yyyy-MM-dd"),
    mode: DateTimeFieldPickerMode.date,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (DateTime? value) {
      if (Validator.validateBirthdate(value!).isRight) {
        return null;
      } else {
        return Validator.validateBirthdate(value).left;
      }
    },
    onDateSelected: (DateTime value) {
      controller.text = dateToString(value);
    },
  );
}
