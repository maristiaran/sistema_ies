import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/login/domain/login.dart';
import 'package:sistema_ies/login/presentation/login_page.dart';
import 'package:sistema_ies/login/presentation/password_reset_sent.dart';
import 'package:sistema_ies/login/presentation/recovery_pass_page.dart';

class LoginPageMain extends ConsumerWidget {
  LoginPageMain({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Widget> _widgetOptions = <Widget>[
      LoginPage(),
      RecoveryPassPage(),
      passwordResetSent(context),
      const Center(
        child: CircularProgressIndicator(),
      ),
    ];
    final _elements = {
      LoginStateName.init: 0,
      LoginStateName.failure: 0,
      LoginStateName.recoverypass: 1,
      LoginStateName.passwordResetSent: 2,
      LoginStateName.loading: 3,
      LoginStateName.successfullySignIn: 3,
      LoginStateName.emailNotVerifiedFailure: 5,
      LoginStateName.verificationEmailSent: 6,
    };
    final _loginStatesProvider =
        ref.watch(IESSystem().loginUseCase.stateNotifierProvider);

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
          _widgetOptions.elementAt(_elements[_loginStatesProvider.stateName]!),
    );
  }
}
