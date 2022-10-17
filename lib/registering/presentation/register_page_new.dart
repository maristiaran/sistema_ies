import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/datetime.dart';
import 'package:sistema_ies/core/presentation/views_utils.dart';
import 'package:sistema_ies/core/presentation/widgets/fields.dart';
import 'package:sistema_ies/registering/domain/registering.dart';

class RegisterPageNew extends ConsumerWidget {
  RegisterPageNew({Key? key}) : super(key: key);

  final _registerFormKey = GlobalKey<FormState>();

  final _firstnameTextController = TextEditingController();
  final _surnameTextController = TextEditingController();
  final _dniTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final _birthDateTextController =
      TextEditingController(text: dateToString(DateTime.now()));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _registeringStatesProvider =
        ref.watch(IESSystem().registeringUseCase.stateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Registro',
          style: Theme.of(context).textTheme.headline1,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 198, 198, 198),
      ),
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            width: MediaQuery.of(context).size.width / 0.5,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Center(
                child: Form(
                  key: _registerFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 6.5,
                            child: registerField(
                                _firstnameTextController, 'Nombre', false),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 6.5,
                            child: registerField(
                                _surnameTextController, 'Apellido', false),
                          )
                        ],
                      ),
                      registerField(_emailTextController, "Email", false),
                      registerField(_dniTextController, "DNI", false),
                      registerField(_birthDateTextController,
                          "Fecha de nacimiento", false),
                      fieldPassword(
                          _passwordTextController, "Contraseña", true, context),
                      fieldPassword(_confirmPasswordTextController,
                          "Confirmar contraseña", true, context),
                      const SizedBox(height: 60),
                      Container(
                        width: MediaQuery.of(context).size.width / 1,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 36, 110, 221),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                          onPressed: () async {
                            if (_registerFormKey.currentState!.validate()) {
                              IESSystem()
                                  .registeringUseCase
                                  .registerAsIncomingUser(
                                      firstname: _firstnameTextController.text
                                          .trim(),
                                      surname: _surnameTextController.text
                                          .trim(),
                                      dni: int.parse(
                                          _dniTextController.text.trim()),
                                      email: _emailTextController.text.trim(),
                                      password: _passwordTextController.text
                                          .trim(),
                                      confirmPassword:
                                          _confirmPasswordTextController.text
                                              .trim(),
                                      birthdate: stringToDate(
                                          _birthDateTextController.text));
                            }
                          },
                          child: const Text(
                            'Registrarse',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 0.5,
                        height: 50,
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 198, 198, 198),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                          onPressed: () {
                            IESSystem().registeringUseCase.returnToLogin();
                            // if (_registerFormKey.currentState!.validate()) {

                            // }
                          },
                          child: const Text(
                            'Cancelar',
                            style: TextStyle(
                                color: Color.fromARGB(255, 63, 63, 63)),
                          ),
                        ),
                      ),
                      Consumer(builder: (context, ref, child) {
                        if (_registeringStatesProvider.stateName ==
                            RegisteringStateName
                                .registeredWaitingEmailValidation) {
                          return ElevatedButton(
                              onPressed: () {
                                IESSystem()
                                    .registeringUseCase
                                    .reSendEmailVerification();
                              },
                              child: const Text(
                                'Reenviar email de verificación',
                                style: TextStyle(color: Colors.white),
                              ));
                        } else {
                          return const Text('');
                        }
                      }),
                      Consumer(builder: (context, ref, child) {
                        if (_registeringStatesProvider.stateName ==
                            RegisteringStateName.failure) {
                          return snackbarLike(
                              text: _registeringStatesProvider.stateName.name,
                              isFailure: true);
                        } else if (_registeringStatesProvider.stateName ==
                            RegisteringStateName
                                .registeredWaitingEmailValidation) {
                          return snackbarLike(
                              text:
                                  '¡Ya estás registrado! Deberás ingresar en el enlace enviado a tu email para poder ingresar',
                              isFailure: false);
                        } else if (_registeringStatesProvider.stateName ==
                            RegisteringStateName.verificationEmailSent) {
                          return snackbarLike(
                              text:
                                  'Email de recuperación de contraseña enviado a: ${_emailTextController.text}',
                              isFailure: false);
                        }

                        return const Text('');
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
