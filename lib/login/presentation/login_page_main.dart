import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/login/domain/login.dart';
import 'package:sistema_ies/login/presentation/login_page.dart';
import 'package:sistema_ies/login/presentation/password_reset_sent.dart';
import 'package:sistema_ies/login/presentation/recovery_pass_page.dart';

class LoginPageMain extends ConsumerWidget {
  const LoginPageMain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _loginStatesProvider =
        ref.watch(IESSystem().loginUseCase.stateNotifierProvider);
    print(_loginStatesProvider.stateName.name);
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
      LoginStateName.recoverypass: 1,
      LoginStateName.passwordResetSent: 2,
      LoginStateName.successfullySignIn: 3,
      LoginStateName.emailNotVerifiedFailure: 5,
      LoginStateName.verificationEmailSent: 6,
      LoginStateName.failure: 0,
    };
    return _widgetOptions.elementAt(_elements[_loginStatesProvider.stateName]!);
  }
}
