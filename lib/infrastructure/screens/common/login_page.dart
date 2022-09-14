import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/application/use_cases/users/login.dart';
import 'package:sistema_ies/infrastructure/screens/views_utils.dart';
import 'package:sistema_ies/shared/utils/value_objects.dart';

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
    final _loginStatesProvider =
        ref.watch(IESSystem().loginUseCase.stateNotifierProvider);
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
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      controller: _emailTextController,
                      focusNode: _focusEmail,
                      validator: (value) =>
                          Validator.validateDNIOrEmail(dniOrEmail: value).fold(
                              (failure) => failure.message, (right) => null),
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
                        IESSystem().loginUseCase.signIn(
                            _emailTextController.text.trim(),
                            _passwordTextController.text.trim());
                      },
                      child: const Text(
                        'Ingresar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 24.0),
                    ElevatedButton(
                      onPressed: () async {
                        _focusEmail.unfocus();
                        _focusPassword.unfocus();
                        IESSystem().startRegisteringNewUser();
                      },
                      child: const Text(
                        '¡Quiero registrarme!',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    ElevatedButton(
                      onPressed: () async {
                        _focusEmail.unfocus();
                        _focusPassword.unfocus();
                        IESSystem()
                            .loginUseCase
                            .changePassword(_emailTextController.text.trim());
                      },
                      child: const Text(
                        'Perdí la contraseña',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Consumer(builder: (context, ref, child) {
                      if (_loginStatesProvider.stateName ==
                          LoginStateName.emailNotVerifiedFailure) {
                        return GestureDetector(
                            child: Text(
                              'Reenviar verificación de email',
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  fontSize: 16),
                            ),
                            onTap: () => IESSystem()
                                .loginUseCase
                                .reSendEmailVerification());
                      } else {
                        return const Text('');
                      }
                    }),
                    Consumer(builder: (context, ref, child) {
                      if (_loginStatesProvider.stateName ==
                              LoginStateName.failure ||
                          _loginStatesProvider.stateName ==
                              LoginStateName.emailNotVerifiedFailure) {
                        return snackbarLike(
                            text: _loginStatesProvider.changes!['failure'],
                            isFailure: true);
                      } else if (_loginStatesProvider.stateName ==
                          LoginStateName.successfullySignIn) {
                        return snackbarLike(
                            text: 'Ingreso exitoso', isFailure: false);
                      } else if (_loginStatesProvider.stateName ==
                          LoginStateName.passwordResetSent) {
                        return snackbarLike(
                            text:
                                'Email de recuperación de contraseña enviado a: ${_emailTextController.text}',
                            isFailure: false);
                      } else if (_loginStatesProvider.stateName ==
                          LoginStateName.verificationEmailSent) {
                        return snackbarLike(
                            text: 'Email de verificación enviado',
                            isFailure: false);
                      }

                      return const Text('');
                    })
                  ],
                ),
              ),
            )));
  }
}
