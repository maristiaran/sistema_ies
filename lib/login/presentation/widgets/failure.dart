import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class FlailureLoginPage extends StatelessWidget {
  const FlailureLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Oh no! Ha ocurrido un problema"),
            const SizedBox(
              height: 10,
            ),
            const Icon(Icons.error),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () => IESSystem().loginUseCase.returnToLogin(),
                child: const Text("Volver"))
          ],
        ),
      ),
    );
  }
}
