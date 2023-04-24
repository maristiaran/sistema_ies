import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/utils/value_objects.dart';
import 'package:sistema_ies/core/presentation/widgets/fields/field_names.dart';
import 'package:sistema_ies/registering/domain/registering.dart';

final passStateProvider =
    StateNotifierProvider<PasswordHandlerNotifier, PasswordHandler>((ref) {
  return PasswordHandlerNotifier();
});

class ConfirmPasswordField extends ConsumerWidget {
  final TextEditingController controller;
  final TextEditingController oldPassword;
  final Enum text;
  final BuildContext context;
  const ConfirmPasswordField(
      this.controller, this.text, this.context, this.oldPassword,
      {Key? key})
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
              if (Validator.confirmPassword(value, oldPassword).isRight) {
                return null;
              } else {
                return Validator.confirmPassword(value, oldPassword).left;
              }
            } else {
              return "${fieldNames[text]} no puede estar vacío";
            }
          },
          obscureText: !ref.watch(passStateProvider).confirmFieldVisibility,
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
                          .switchStatePasswordConfirmField()
                    },
                icon: ref.watch(passStateProvider).confirmFieldVisibility
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
      ],
    );
  }
}
