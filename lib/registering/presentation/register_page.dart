import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/datetime.dart';
import 'package:sistema_ies/core/domain/utils/value_objects.dart';
import 'package:sistema_ies/core/presentation/views_utils.dart';
import 'package:sistema_ies/registering/domain/registering.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({Key? key}) : super(key: key);

  final _registerFormKey = GlobalKey<FormState>();

  final _firstnameTextController = TextEditingController();
  final _surnameTextController = TextEditingController();
  final _dniTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final _birthDateTextController =
      TextEditingController(text: dateToString(DateTime.now()));

  final _focusFirstname = FocusNode();
  final _focusSurname = FocusNode();
  final _focusDNI = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusConfirmPassword = FocusNode();
  final _focusBirthdate = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _registeringStatesProvider =
        ref.watch(IESSystem().registeringUseCase.stateNotifierProvider);

    return GestureDetector(
      onTap: () {
        _focusFirstname.unfocus();
        _focusSurname.unfocus();
        _focusDNI.unfocus();
        _focusSurname.unfocus();
        _focusPassword.unfocus();
        _focusConfirmPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registro como nuevo usuario'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Form(
                  key: _registerFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _firstnameTextController,
                        focusNode: _focusFirstname,
                        validator: (value) =>
                            Validator.validateUserFirtAndSurname(
                          name: value,
                        ).fold((failure) => failure.message, (right) => null),
                        decoration: InputDecoration(
                          hintText: "Nombre(s)",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _surnameTextController,
                        focusNode: _focusSurname,
                        validator: (value) =>
                            Validator.validateUserFirtAndSurname(
                          name: value,
                        ).fold((failure) => failure.message, (right) => null),
                        decoration: InputDecoration(
                          hintText: "Apellido(s)",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),

                      TextFormField(
                        controller: _dniTextController,
                        focusNode: _focusDNI,
                        validator: (value) =>
                            Validator.validateDNIString(dni: value).fold(
                                (failure) => failure.message, (right) => null),
                        decoration: InputDecoration(
                          hintText: "DNI",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: _birthDateTextController,
                        focusNode: _focusBirthdate,
                        decoration: InputDecoration(
                            hintText: "Fecha de nacimiento",
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(6.0),
                              borderSide: const BorderSide(
                                color: Colors.red,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () async {
                                DateTime? newBirthdate = await showDatePicker(
                                    context: context,
                                    initialDate: stringToDate(
                                        _birthDateTextController.text),
                                    firstDate: DateTime(1900, 1, 1),
                                    lastDate: DateTime.now());
                                if (newBirthdate != null) {
                                  _birthDateTextController.text =
                                      dateToString(newBirthdate);
                                }
                              },
                            )),
                      ),
                      // const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailTextController,
                        focusNode: _focusEmail,
                        validator: (value) =>
                            Validator.validateEmail(email: value).fold(
                                (failure) => failure.message, (right) => null),
                        decoration: InputDecoration(
                          hintText: "Correo electrónico",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordTextController,
                        focusNode: _focusPassword,
                        obscureText: true,
                        validator: (value) =>
                            Validator.validatePassword(password: value).fold(
                                (failure) => failure.message, (right) => null),
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
                      TextFormField(
                        controller: _confirmPasswordTextController,
                        focusNode: _focusConfirmPassword,
                        obscureText: true,
                        validator: (value) =>
                            Validator.validateConfirmedPassword(
                                    firstPassword: _passwordTextController.text,
                                    confirmedPassword: value)
                                .fold((failure) => failure.message,
                                    (right) => null),
                        decoration: InputDecoration(
                          hintText: "Confirma contraseña",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
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
                                          email:
                                              _emailTextController.text.trim(),
                                          password: _passwordTextController.text
                                              .trim(),
                                          confirmPassword:
                                              _confirmPasswordTextController
                                                  .text
                                                  .trim(),
                                          birthdate: stringToDate(
                                              _birthDateTextController.text));
                                }
                              },
                              child: const Text(
                                'Registrarme!',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Consumer(
                        builder: (context, ref, child) {
                          if (_registeringStatesProvider.stateName ==
                              RegisteringStateName.failure) {
                            return Text(
                                _registeringStatesProvider.stateName.name
                                // .changes!['failure']

                                );
                          } else if (_registeringStatesProvider.stateName ==
                              RegisteringStateName
                                  .registeredWaitingEmailValidation) {
                            return const Text(
                                "¡Registro exitoso!.¡No olvides verificar tu email para poder ingresar!");
                          } else {
                            return const Text("");
                          }
                        },
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    IESSystem().registeringUseCase.returnToLogin();
                    // if (_registerFormKey.currentState!.validate()) {

                    // }
                  },
                  child: const Text(
                    'Regresar a login!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Consumer(builder: (context, ref, child) {
                  if (_registeringStatesProvider.stateName ==
                      RegisteringStateName.registeredWaitingEmailValidation) {
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
                      RegisteringStateName.registeredWaitingEmailValidation) {
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
    );
  }
}
