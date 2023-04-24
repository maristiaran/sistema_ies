import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/presentation/widgets/fields/field_names.dart';
import '../../domain/login.dart';

final passVisibilityStateProvider = StateNotifierProvider<
    PasswordVisibilityHandlerNotifier, PasswordVisibilityHandler>((ref) {
  return PasswordVisibilityHandlerNotifier();
});

class FieldLoginPass extends ConsumerWidget {
  final TextEditingController controller;
  final Enum text;
  final BuildContext context;
  const FieldLoginPass(this.controller, this.text, this.context, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextFormField(
      controller: controller,
      obscureText: !ref.watch(passVisibilityStateProvider).visibility,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value!.isNotEmpty) {
          return null;
        } else {
          return 'El campo de la contraseña  no puede estar vacío';
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
        suffixIcon: IconButton(
            onPressed: () =>
                {ref.read(passVisibilityStateProvider.notifier).switchState()},
            icon: ref.watch(passVisibilityStateProvider).visibility
                ? const Icon(Icons.visibility)
                : const Icon(Icons.visibility_off)),
        errorBorder: UnderlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
