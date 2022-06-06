import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sistema_ies/application/users/login.dart';
import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/init_repository_adapters.dart';
import 'package:sistema_ies/shared/utils/states.dart';

class LoginPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  final _focusEmail = FocusNode();
  final _focusPassword = FocusNode();

  final LoginUseCase _loginUseCase =
      LoginUseCase(usersRepository: usersRepository);

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginProvider =
        StateNotifierProvider<LoginUseCase, List<UseCaseState>>((ref) {
      return _loginUseCase;
    });
    final _loginResultProvider = ref.watch(loginProvider);
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
                            _loginUseCase.signIn(
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
                          onPressed: () => GoRouter.of(context).go('/register'),
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
                      return Text(_loginResultProvider.last.displayName);
                    },
                  )
                ],
              ),
            )));
  }
}
