import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sistema_ies/core/domain/ies_system.dart';

class CRUDRolesView extends ConsumerWidget {
  const CRUDRolesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final _crudStatesProvider =
    //     ref.watch(IESSystem().crudRolesUseCase.stateNotifierProvider);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Asignación de roles'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Row(
                    children: [
                      const Text('Usuario: '),
                      DropdownButton<String>(items: const [
                        DropdownMenuItem(child: Text('rol1')),
                        DropdownMenuItem(child: Text('rol2'))
                      ], onChanged: (value) => value)
                    ],
                  )
                ]))));
  }
}
