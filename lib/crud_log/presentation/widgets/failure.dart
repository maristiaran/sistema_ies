import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class FailureLogPage extends StatelessWidget {
  const FailureLogPage({Key? key}) : super(key: key);

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
            const Icon(Icons.restore),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {
                  IESSystem().logUseCase.getLogsAsync();
                },
                child: const Text("Recargar"))
          ],
        ),
      ),
    );
  }
}
