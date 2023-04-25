import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/login/domain/login.dart';
import 'package:sistema_ies/login/presentation/widgets/failure.dart';
import 'package:sistema_ies/login/presentation/login_form.dart';

class LoginPageMain extends ConsumerWidget {
  const LoginPageMain({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<Enum, Widget> _widgetElements = {
      LoginStateName.init: LoginForm(),
      LoginStateName.failure: const FlailureLoginPage(),
      LoginStateName.successfullySignIn: const Center(),
      LoginStateName.loading: const Center(
        child: CircularProgressIndicator(),
      )
    };
    ref.listen<OperationState>(IESSystem().loginUseCase.stateNotifierProvider,
        (previous, next) {
      if (previous!.stateName == LoginStateName.failure) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Usuario o contraseña incorrecta")));
      } else if (next.stateName == LoginStateName.emailNotVerifiedFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: const Text(
                "Su email no ha sido verificado aún. Revise si casilla de correos por favor")));
      }
    });
    final body = _widgetElements.keys.firstWhere((element) =>
        element ==
        ref.watch(IESSystem().loginUseCase.stateNotifierProvider).stateName);
    return Scaffold(body: _widgetElements[body]);
  }
}
