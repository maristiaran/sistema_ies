import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/login/domain/login.dart';
import 'package:sistema_ies/login/presentation/login_page_main.dart';
import 'package:sistema_ies/login/presentation/password_reset_sent.dart';
import 'package:sistema_ies/login/presentation/recovery_pass_page.dart';

class LoginPage extends ConsumerWidget {
  LoginPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _loginStatesProvider =
        ref.watch(IESSystem().loginUseCase.stateNotifierProvider);
    final List<Widget> _widgetOptions = <Widget>[
      LoginPageMain(
          formKey: _formKey,
          emailTextController: _emailTextController,
          passwordTextController: _passwordTextController,
          loginStatesProvider: _loginStatesProvider),
      RecoveryPassPage(),
      passwordResetSent(context)
    ];
    final _elements = {
      LoginStateName.init: 0,
      LoginStateName.recoverypass: 1,
      LoginStateName.emailNotVerifiedFailure: 4,
      LoginStateName.successfullySignIn: 3,
      LoginStateName.passwordResetSent: 2,
      LoginStateName.verificationEmailSent: 5,
      LoginStateName.failure: 6
    };
    //return _widgetOptions.elementAt(_elements[_loginStatesProvider.stateName]!);
    return _widgetOptions.elementAt(0);
  }
}
