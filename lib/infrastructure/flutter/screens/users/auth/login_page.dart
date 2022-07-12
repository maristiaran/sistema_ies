import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/application/use_cases/users/login.dart';

class LoginPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  // final  _loginStatesProvider;
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void _showStatusBarIfNecessary() {
      final _loginStatesProvider =
          ref.watch(IESSystem().authUseCase.loginUseCase.stateNotifierProvider);
      if (_loginStatesProvider.stateName == LoginStateName.failure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(_loginStatesProvider.changes!['failure']),
          backgroundColor: Colors.red,
        ));
      } else if (_loginStatesProvider.stateName ==
          LoginStateName.successfullySignIn) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Ingreso exitoso'),
          backgroundColor: Colors.green,
        ));
      } else if (_loginStatesProvider.stateName ==
          LoginStateName.passwordResetSent) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email de recuperación de contraseña enviado'),
          backgroundColor: Colors.green,
        ));
      } else if (_loginStatesProvider.stateName ==
          LoginStateName.verificationEmailSent) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Email de verificación enviado'),
          backgroundColor: Colors.green,
        ));
      }
    }

    return GestureDetector(
        onTap: () {
          _focusEmail.unfocus();
          _focusPassword.unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('IES 9-010 Rosario Vera Peñaloza'),
            ),
            body: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailTextController,
                    focusNode: _focusEmail,
                    validator: (value) => null,
                    decoration: InputDecoration(
                      hintText: "Usuario",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _passwordTextController,
                    focusNode: _focusPassword,
                    obscureText: true,
                    validator: (value) => null,
                    decoration: InputDecoration(
                      hintText: "Contraseña",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () async {
                      _focusEmail.unfocus();
                      _focusPassword.unfocus();
                      IESSystem()
                          .authUseCase
                          .loginUseCase
                          .signIn(_emailTextController.text.trim(),
                              _passwordTextController.text.trim())
                          .whenComplete(() => _showStatusBarIfNecessary());
                    },
                    child: const Text(
                      'Ingresar',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 24.0),
                  ElevatedButton(
                    onPressed: () =>
                        IESSystem().authUseCase.startRegisteringIncomingUser(),
                    child: const Text(
                      'Registrarse',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () => IESSystem()
                        .authUseCase
                        .loginUseCase
                        .changePassword(_emailTextController.text.trim())
                        .whenComplete(() => _showStatusBarIfNecessary()),
                    child: const Text(
                      '¡Perdí la contraseña!',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () => IESSystem()
                        .authUseCase
                        .loginUseCase
                        .reSendEmailVerification()
                        .whenComplete(() => _showStatusBarIfNecessary()),
                    child: const Text(
                      'Reenviar email de verificación',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            )));
  }
}
