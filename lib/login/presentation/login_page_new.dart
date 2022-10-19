import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/value_objects.dart';
import 'package:sistema_ies/core/presentation/views_utils.dart';
import 'package:sistema_ies/core/presentation/widgets/fields.dart';
import 'package:sistema_ies/login/login.dart';

class LoginPageNew extends ConsumerWidget {
  LoginPageNew({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _loginStatesProvider =
        ref.watch(IESSystem().loginUseCase.stateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ver',
                style: Theme.of(context).textTheme.headline1,
                selectionColor: const Color.fromARGB(255, 63, 63, 63),
              ),
              Text('App', style: Theme.of(context).textTheme.headline2)
            ],
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 198, 198, 198)),
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            width: MediaQuery.of(context).size.width / 0.5,
            child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      fieldEmailDNI(
                          _emailTextController, "Email o DNI", false, context),
                      const SizedBox(height: 10),
                      fieldPassword(_passwordTextController, Fields.password,
                          true, context),
                      const SizedBox(height: 60),
                      Container(
                        width: MediaQuery.of(context).size.width / 0.5,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 36, 110, 221),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              IESSystem().loginUseCase.signIn(
                                  _emailTextController.text.trim(),
                                  _passwordTextController.text.trim());
                            } else {
                              print("Ha ocurrido un error!");
                            }
                          },
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("¿No tienes cuenta?"),
                          TextButton(
                            onPressed: () async {
                              IESSystem().startRegisteringNewUser();
                            },
                            child: Text(
                              'Registrate',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary),
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: () async {
                          IESSystem()
                              .loginUseCase
                              .changePassword(_emailTextController.text.trim());
                        },
                        child: Text(
                          '¿Olvidaste la contraseña?',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      Consumer(builder: (context, ref, child) {
                        if (_loginStatesProvider.stateName ==
                                LoginStateName.failure ||
                            _loginStatesProvider.stateName ==
                                LoginStateName.emailNotVerifiedFailure) {
                          return snackbarLike(
                              text: _loginStatesProvider.stateName.name,
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
                )),
          ),
        ),
      ),
    );
  }
}
