import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/datetime.dart';
import 'package:sistema_ies/core/domain/utils/value_objects.dart';
import 'package:sistema_ies/core/presentation/widgets/fields.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({Key? key}) : super(key: key);

  final _registerFormKey = GlobalKey<FormState>();

  final _firstnameTextController = TextEditingController();
  final _surnameTextController = TextEditingController();
  final _dniTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  final _birthDateTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _registeringStatesProvider =
        ref.watch(IESSystem().registeringUseCase.stateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 15,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            constraints: const BoxConstraints(
                                maxWidth: 170, minWidth: 100),
                            width: MediaQuery.of(context).size.width / 6.5,
                            child: fieldRegister(_firstnameTextController,
                                Fields.name, false, context),
                          ),
                          Container(
                            constraints: const BoxConstraints(
                                maxWidth: 170, minWidth: 170),
                            width: MediaQuery.of(context).size.width / 6.5,
                            child: fieldRegister(_surnameTextController,
                                Fields.lastname, false, context),
                          )
                        ],
                      ),
                      fieldRegister(
                          _emailTextController, Fields.email, false, context),
                      fieldRegister(
                          _dniTextController, Fields.dni, false, context),
                      fieldBirthday(
                          _birthDateTextController, Fields.birthday, context),
                      fieldRegister(_passwordTextController, Fields.password,
                          true, context),
                      fieldConfirmPassword(
                          _confirmPasswordTextController,
                          Fields.confirmPassword,
                          _passwordTextController,
                          true,
                          context),
                      const SizedBox(height: 40),
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
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          "Corrija todos los campos invalidos antes")));
                            }
                          },
                          child: const Text(
                            'Registrarse',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      TextButton(
                          onPressed: () =>
                              IESSystem().registeringUseCase.returnToLogin(),
                          child: const Text("Cancelar")),
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
