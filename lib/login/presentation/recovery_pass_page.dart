import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/presentation/widgets/fields.dart';
import 'package:sistema_ies/login/domain/login.dart';
import 'package:sistema_ies/login/presentation/password_reset_sent.dart';

class RecoveryPassPage extends ConsumerWidget {
  RecoveryPassPage({Key? key}) : super(key: key);
  static String nameRoute = 'recoverypass';
  static String pathRoute = 'recoverypass';
  final _formRecoveryPassKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();
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
                  'Recuperar contraseña',
                  style: Theme.of(context).textTheme.headline1,
                )
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
                  key: _formRecoveryPassKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 150),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        fieldEmailDNI(_emailTextController, "Email o DNI",
                            false, context),
                        const SizedBox(height: 10),
                        Container(
                          width: MediaQuery.of(context).size.width / 0.5,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 36, 110, 221),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: TextButton(
                            onPressed: () async {
                              if (_formRecoveryPassKey.currentState!
                                  .validate()) {
                                IESSystem().loginUseCase.changePassword(
                                    _emailTextController.text.trim());
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Coloca tu correo o contraseña primero")));
                              }
                              if (_loginStatesProvider.stateName ==
                                  LoginStateName.failure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Ha ocurrido un error. Por favor intentelo de nuevo más tarde")));
                              }
                            },
                            child: const Text(
                              'Recuperar contraseña',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
            ))));
  }
}
