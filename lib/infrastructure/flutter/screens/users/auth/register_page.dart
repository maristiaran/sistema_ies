import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/users/register_incoming_students.dart';
import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/init_repository_adapters.dart';
import 'package:sistema_ies/shared/utils/value_objects.dart';

class RegisterIncomingStudentPage extends ConsumerWidget {
  RegisterIncomingStudentPage({Key? key}) : super(key: key);

  final _registerFormKey = GlobalKey<FormState>();

  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusName = FocusNode();
  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  final RegisterIncomingStudentUseCase _registerIncomingStudentUseCase =
      RegisterIncomingStudentUseCase(
          usersRepository: usersRepository,
          syllabusRepository: syllabusRepository);
  //  final registerIncomingStudentsProvider =
  //       StateNotifierProvider<Re, List<UseCaseState>>((ref) {
  //     return _loginUseCase;
  //   });
  //   final _loginResultProvider = ref.watch(loginProvider);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        _focusName.unfocus();
        _focusEmail.unfocus();
        _focusPassword.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
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
                        controller: _nameTextController,
                        focusNode: _focusName,
                        validator: (value) => Validator.validateName(
                          name: value,
                        ),
                        decoration: InputDecoration(
                          hintText: "Name",
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
                          hintText: "Email",
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
                          hintText: "Password",
                          errorBorder: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_registerFormKey.currentState!.validate()) {
                                  _registerIncomingStudentUseCase
                                      .registerAsIncomingUser(
                                          userName:
                                              _emailTextController.text.trim(),
                                          password: _passwordTextController.text
                                              .trim(),
                                          uniqueNumber: 1,
                                          firstname: 'Juan',
                                          surname: 'Perez',
                                          syllabus: syllabusRepository
                                              .getActiveSyllabus()[0]);
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
}
