import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/login/domain/login.dart';
import 'package:sistema_ies/login/presentation/login_page.dart';

class LoginPageMain extends ConsumerWidget {
  const LoginPageMain({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
    return Scaffold(
      body:
          LoginPage() /* _widgetOptions.elementAt(_elements[_loginStatesProvider.stateName]!) */,
    );
  }
}
