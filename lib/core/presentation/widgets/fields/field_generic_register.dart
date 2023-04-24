import 'package:flutter/material.dart';

import '../../../domain/utils/value_objects.dart';
import 'field_names.dart';

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
        return "${fieldNames[text]} no puede estar vacío";
      }
    },
    decoration: InputDecoration(
      labelText: fieldNames[text],
      labelStyle: Theme.of(context).textTheme.labelMedium,
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
