import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/presentation/widgets/fields.dart';
import 'package:sistema_ies/login/domain/login.dart';

class LoginPageMain extends StatelessWidget {
  const LoginPageMain({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailTextController,
    required TextEditingController passwordTextController,
    required LoginState loginStatesProvider,
  })  : _formKey = formKey,
        _emailTextController = emailTextController,
        _passwordTextController = passwordTextController,
        _loginStatesProvider = loginStatesProvider,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailTextController;
  final TextEditingController _passwordTextController;
  final LoginState _loginStatesProvider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Ver',
                style: Theme.of(context).textTheme.headline1,
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
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 10,
                    children: [
                      fieldEmailDNI(
                          _emailTextController, "Email o DNI", false, context),
                      const SizedBox(height: 10),
                      fieldPassword(
                          _passwordTextController, "Contraseña", true, context),
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
                              await IESSystem().loginUseCase.signIn(
                                  _emailTextController.text.trim(),
                                  _passwordTextController.text.trim());
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text("Completa todos los campos")));
                            }
                            /* if (_loginStatesProvider.stateName !=
                                LoginStateName.successfullySignIn) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text("Error")));
                            } */
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
                          IESSystem().loginUseCase.startRecoveryPass();
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
