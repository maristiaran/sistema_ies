import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/ies_system.dart';

class LoginPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _loginStatesProvider =
        ref.watch(IESSystem().authUseCase.loginUseCase.stateNotifierProvider);
    return GestureDetector(
        onTap: () {
          _focusEmail.unfocus();
          _focusPassword.unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              title: const Text('IES 9-010 Rosario Vera Peñaloza'),
            ),
            body: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: _emailTextController,
                    focusNode: _focusEmail,
                    validator: (value) => null,
                    decoration: InputDecoration(
                      hintText: "Usuario",
                      errorBorder: UnderlineInputBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  TextFormField(
                    controller: _passwordTextController,
                    focusNode: _focusPassword,
                    obscureText: true,
                    validator: (value) => null,
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
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            _focusEmail.unfocus();
                            _focusPassword.unfocus();
                            IESSystem().authUseCase.loginUseCase.signIn(
                                _emailTextController.text.trim(),
                                _passwordTextController.text.trim());
                          },
                          child: const Text(
                            'Ingresar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      const SizedBox(width: 24.0),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => IESSystem()
                              .authUseCase
                              .startRegisteringIncomingUser(),
                          child: const Text(
                            'Registrarse',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return Text(_loginStatesProvider.toString());
                    },
                  )
                ],
              ),
            )));
  }
}
