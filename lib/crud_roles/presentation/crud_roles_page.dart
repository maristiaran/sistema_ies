import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sistema_ies/core/domain/ies_system.dart';

class CRUDRolesPage extends ConsumerWidget {
  const CRUDRolesPage({Key? key}) : super(key: key);

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
                  SizedBox(
                    height: 50,
                    width: 150,
                    child: Row(
                      children: [
                        const Text('Usuario: '),
                        DropdownButton<String>(
                            isExpanded: true,
                            items: const [
                              DropdownMenuItem(child: Text('rol1')),
                              DropdownMenuItem(child: Text('rol2'))
                            ],
                            onChanged: (value) => value)
                      ],
                    ),
                  )
                ]))));
  }
}
