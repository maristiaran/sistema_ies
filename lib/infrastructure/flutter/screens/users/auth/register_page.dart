import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/application/use_cases/users/registering.dart';

// import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/init_repository_adapters.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/utils/value_objects.dart';

class RegisterIncomingStudentPage extends ConsumerWidget {
  RegisterIncomingStudentPage({Key? key}) : super(key: key);

  final _registerFormKey = GlobalKey<FormState>();

  final _firstnameTextController = TextEditingController();
  final _surnameTextController = TextEditingController();
  final _dniTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();

  final _focusFirstname = FocusNode();
  final _focusSurname = FocusNode();
  final _focusDNI = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();
  final _focusConfirmPassword = FocusNode();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _registeringStatesProvider = ref.watch(
        IESSystem().authUseCase.registeringUseCase.stateNotifierProvider);
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
          title: const Text('Registro como nuevo estudiante'),
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
                      // const SizedBox(height: 32.0),
                      Consumer(builder: (context, ref, child) {
                        return DropdownButton<Syllabus>(
                            value: IESSystem()
                                .authUseCase
                                .registeringUseCase
                                .currentSyllabus,
                            items: IESSystem()
                                .authUseCase
                                .registeringUseCase
                                .syllabuses
                                .map((e) => DropdownMenuItem(
                                    child: Text(e.name), value: e))
                                .toList(),
                            onChanged: (Syllabus? newValue) {
                              IESSystem()
                                  .authUseCase
                                  .registeringUseCase
                                  .setCurrentSyllabus(newValue);
                            });
                      }),
                      // const SizedBox(height: 32.0),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_registerFormKey.currentState!.validate()) {
                                  IESSystem()
                                      .authUseCase
                                      .registeringUseCase
                                      .registerAsIncomingUser(
                                          firstname: _firstnameTextController
                                              .text
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
                                          syllabus: IESSystem()
                                              .authUseCase
                                              .registeringUseCase
                                              .currentSyllabus);
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
                            if (_registeringStatesProvider.changes == null) {
                              return const Text("Error desconocido");
                            } else {
                              return Text(_registeringStatesProvider
                                  .changes!['failure']);
                            }
                          } else if (_registeringStatesProvider.stateName ==
                              RegisteringStateName.successfullyRegistered) {
                            return const Text(
                                "¡Registro exitoso!.¡No olvides verificar tu email para poder ingresar!");
                          } else {
                            return const Text("");
                          }
                        },
                      ),
                      // Consumer(builder: (context, ref, child) {
                      //   if (_registeringStatesProvider.stateName ==
                      //       RegisteringStateName.failure) {
                      //     return const Text("Error al");
                      //   }
                      //   return const Text("");
                      // }),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    IESSystem().authUseCase.registeringUseCase.returnToLogin();
                    // if (_registerFormKey.currentState!.validate()) {

                    // }
                  },
                  child: const Text(
                    'Regresar a login!',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
