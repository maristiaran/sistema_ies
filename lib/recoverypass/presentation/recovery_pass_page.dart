import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/recoverypass/presentation/recovery_pass_form.dart';
import '../domain/recoverypass.dart';

class RecoveryPassPage extends ConsumerWidget {
  RecoveryPassPage({Key? key}) : super(key: key);
  static String nameRoute = 'recoverypass';
  static String pathRoute = 'recoverypass';
  final Map<Enum, Widget> _widgetElements = {
    RecoveryStateName.init: RecoveryPassForm(),
    RecoveryStateName.loading: const Center(
      child: CircularProgressIndicator(),
    ),
    RecoveryStateName.passwordResetSent: const Center()
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<OperationState>(
        IESSystem().recoveryPassUseCase.stateNotifierProvider,
        (previous, next) {
      if (next.stateName == RecoveryStateName.failure) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Ha ocurrido un error, inténtelo de nuevo más tarde")));
      } else if (next.stateName == RecoveryStateName.passwordResetSent) {
        IESSystem().recoveryPassUseCase.returnToLogin() <
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                content: const Text(
                    "Se ha enviado a tu correo un email para que puedas recurperar tu contraseña")));
      }
    });

    final body = _widgetElements.keys.firstWhere((element) =>
        element ==
        ref
            .watch(IESSystem().recoveryPassUseCase.stateNotifierProvider)
            .stateName);
    return Scaffold(
        appBar: AppBar(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Recuperar contraseña',
                  style: Theme.of(context).textTheme.displayLarge,
                )
              ],
            ),
            centerTitle: true,
            backgroundColor: const Color.fromARGB(255, 198, 198, 198)),
        body: _widgetElements[body]);
  }
}
