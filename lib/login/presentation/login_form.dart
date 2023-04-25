import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/login/presentation/widgets/field_password.dart';
import '../../core/presentation/widgets/fields/field_email_dni.dart';
import '../../core/presentation/widgets/fields/field_names.dart';

class LoginForm extends ConsumerWidget {
  LoginForm({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ver',
                style: Theme.of(context).textTheme.displayLarge,
              ),
              Text('App', style: Theme.of(context).textTheme.displayMedium)
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
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      fieldEmailDNI(
                          _emailTextController, "Email o DNI", context),
                      const SizedBox(height: 10),
                      FieldLoginPass(
                          _passwordTextController, Fields.password, context),
                      const SizedBox(height: 60),
                      Container(
                        width: MediaQuery.of(context).size.width / 0.5,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10))),
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await IESSystem().loginUseCase.signIn(
                                  _emailTextController.text.trim(),
                                  _passwordTextController.text.trim());
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
                              IESSystem()
                                  .loginUseCase
                                  .startRegisteringIncomingUser();
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
                          IESSystem().startRecoveryPass();
                        },
                        child: Text(
                          '¿Olvidaste la contraseña?',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
