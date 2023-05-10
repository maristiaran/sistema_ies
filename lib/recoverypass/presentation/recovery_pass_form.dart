import 'package:flutter/material.dart';
import '../../core/domain/ies_system.dart';
import '../../core/presentation/widgets/fields/field_email_dni.dart';

class RecoveryPassForm extends StatelessWidget {
  RecoveryPassForm({
    Key? key,
  }) : super(key: key);
  final _formRecoveryPassKey = GlobalKey<FormState>();
  final _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Center(
            child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          width: MediaQuery.of(context).size.width / 0.5,
          child: Form(
              key: _formRecoveryPassKey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    fieldEmailDNI(_emailTextController, "Email o DNI", context),
                    const SizedBox(height: 10),
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 0.5,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10))),
                          child: TextButton(
                            onPressed: () async {
                              if (_formRecoveryPassKey.currentState!
                                  .validate()) {
                                IESSystem().recoveryPassUseCase.changePassword(
                                    _emailTextController.text.trim());
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "Coloca un correo electrónico correcto primero")));
                              }
                            },
                            child: Text(
                              'Recuperar contraseña',
                              style: Theme.of(context).textTheme.displaySmall,
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () => IESSystem().restartLogin(),
                            child: const Text("Cancelar"))
                      ],
                    ),
                  ],
                ),
              )),
        )));
  }
}
