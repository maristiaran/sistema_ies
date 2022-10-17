import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/utils/value_objects.dart';

TextFormField fieldEmail(controller, text, obscure, context) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    validator: (String? value) {
      return (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value!))
          ? "El email ingresado NO es válido"
          : null;
    },
    decoration: InputDecoration(
      labelText: text,
      filled: true,
      fillColor: Theme.of(context).colorScheme.tertiary,
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 198, 198, 198),
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
      return (!RegExp(
                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
              .hasMatch(value!))
          ? "Debe contener: 1 may, 1 min, 1 car. esp ( ! @ # \$ & * ~ )"
          : null;
    },
    decoration: InputDecoration(
      labelText: text,
      filled: true,
      fillColor: Theme.of(context).colorScheme.tertiary,
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 198, 198, 198),
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

TextFormField registerField(controller, text, obscure) {
  return TextFormField(
    controller: controller,
    obscureText: obscure,
    validator: (value) => Validator.validateDNIOrEmail(dniOrEmail: value)
        .fold((failure) => failure.message, (right) => null),
    decoration: InputDecoration(
      labelText: text,
      labelStyle: const TextStyle(color: Color.fromARGB(255, 63, 63, 63)),
      filled: true,
      fillColor: const Color.fromARGB(255, 198, 198, 198),
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          color: Color.fromARGB(255, 198, 198, 198),
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
