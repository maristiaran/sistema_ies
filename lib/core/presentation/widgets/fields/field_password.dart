import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/presentation/widgets/fields/field_names.dart';
import 'package:sistema_ies/registering/domain/registering.dart';
import '../../../domain/utils/value_objects.dart';
import '../pass_check.dart';

final passStateProvider =
    StateNotifierProvider<PasswordHandlerNotifier, PasswordHandler>((ref) {
  return PasswordHandlerNotifier();
});

class PasswordField extends ConsumerWidget {
  final TextEditingController controller;
  final Enum text;
  final BuildContext context;
  const PasswordField(this.controller, this.text, this.context, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        TextFormField(
          controller: controller,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if (value!.isNotEmpty) {
              if (Validator.validateRegisterForm(value, Fields.password)
                  .isRight) {
                return null;
              } else {
                return Validator.validateRegisterForm(value, Fields.password)
                    .left;
              }
            } else {
              return "La contraseña no puede estar vacío";
            }
          },
          obscureText: !ref.watch(passStateProvider).passwordFieldVisibility,
          onChanged: (controller) => ref
              .read(passStateProvider.notifier)
              .verifierCorrectPass(controller),
          decoration: InputDecoration(
            labelText: fieldNames[text],
            labelStyle: Theme.of(context).textTheme.labelMedium,
            suffixIcon: IconButton(
                onPressed: () => {
                      ref
                          .read(passStateProvider.notifier)
                          .switchStatePasswordField()
                    },
                icon: ref.watch(passStateProvider).passwordFieldVisibility
                    ? const Icon(Icons.visibility)
                    : const Icon(Icons.visibility_off)),
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
        ),
        const SizedBox(
          height: 10,
        ),
        // Check if password has eight digits at least
        PassCheck(ref.watch(passStateProvider).passHasEightCharacters,
            "Contiene al menos 8 caracteres"),
        const SizedBox(
          height: 5,
        ),
        // Check if password has one upper case
        PassCheck(ref.watch(passStateProvider).passHasUppercaseKey,
            "Contiene al menos una mayúscula"),
        const SizedBox(
          height: 5,
        ),
        // Check if password has one lower case
        PassCheck(ref.watch(passStateProvider).passHasLowercaseKey,
            "Contiene al menos una minúscula"),
        const SizedBox(
          height: 5,
        ),
        // Check if password has one number
        PassCheck(ref.watch(passStateProvider).passHasAtLeastOneNumber,
            "Contiene al menos un número"),
        const SizedBox(
          height: 5,
        ),
        // Check if password has one special character
        PassCheck(ref.watch(passStateProvider).passHasASpecialCharacter,
            "Contiene al menos un carácter especial")
      ],
    );
  }
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
        return "${fieldNames[text]} no puede estar vacío";
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
