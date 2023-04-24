import 'package:flutter/material.dart';

import '../../../domain/utils/value_objects.dart';

TextFormField fieldEmailDNI(controller, text, context) {
  return TextFormField(
    controller: controller,
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
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error,
        ),
      ),
    ),
  );
}
