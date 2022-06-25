import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/ies_system.dart';

// import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/init_repository_adapters.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/utils/value_objects.dart';

class RegisterIncomingStudentPage extends ConsumerWidget {
  RegisterIncomingStudentPage({Key? key}) : super(key: key);

  final _registerFormKey = GlobalKey<FormState>();

  final _usernameTextController = TextEditingController();
  final _firstnameTextController = TextEditingController();
  final _surnameTextController = TextEditingController();
  final _dniTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusUsername = FocusNode();
  final _focusFirstname = FocusNode();
  final _focusSurname = FocusNode();
  final _focusDNI = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  // late Syllabus currentSyllabus;
  // late var _registerStatesProvider;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _registerStatesProvider = ref.watch(
        IESSystem().authUseCase.registeringUseCase.stateNotifierProvider);
    // selectedSyllabus = IESSystem().authUseCase.currentSyllabus;
    return GestureDetector(
      onTap: () {
        _focusUsername.unfocus();
        _focusFirstname.unfocus();
        _focusSurname.unfocus();
        _focusDNI.unfocus();
        _focusSurname.unfocus();
        _focusPassword.unfocus();
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
                        controller: _usernameTextController,
                        focusNode: _focusUsername,
                        validator: (value) => Validator.validateName(
                          name: value,
                        ),
                        decoration: InputDecoration(
                          hintText: "Nombre de usuario",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      TextFormField(
                        controller: _firstnameTextController,
                        focusNode: _focusFirstname,
                        validator: (value) => Validator.validateName(
                          name: value,
                        ),
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
                        validator: (value) => Validator.validateName(
                          name: value,
                        ),
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
                        validator: (value) => Validator.validateName(
                          name: value,
                        ),
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

                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _emailTextController,
                        focusNode: _focusEmail,
                        validator: (value) => Validator.validateEmail(
                          email: value,
                        ),
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
                      const SizedBox(height: 16.0),
                      TextFormField(
                        controller: _passwordTextController,
                        focusNode: _focusPassword,
                        obscureText: true,
                        validator: (value) => Validator.validatePassword(
                          password: value,
                        ),
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
                      const SizedBox(height: 32.0),
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
                      const SizedBox(height: 32.0),
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
                                          userName:
                                              _emailTextController.text.trim(),
                                          password: _passwordTextController.text
                                              .trim(),
                                          uniqueNumber: int.parse(
                                              _dniTextController.text.trim()),
                                          firstname: 'Juan',
                                          surname: 'Perez',
                                          syllabus: IESSystem()
                                              .authUseCase
                                              .registeringUseCase
                                              .currentSyllabus!);
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
                      // Consumer(
                      //   builder: (context, ref, child) {
                      //     return Text(_registerIncomingStudentUseCase.last.displayName);
                      //   },
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // List<DropdownMenuItem> _getSyllabusItems() {
  //   List<DropdownMenuItem> newSyllabusItems = [];
  //   if (usecase)
  //   (_registerStatesProvider as RegisteringUseCaseState)
  //       .getActiveSyllabuses()
  //       .map((e) => DropdownMenuItem(child: Text(e.name), value: e))
  //       .toList();
  // }
}
