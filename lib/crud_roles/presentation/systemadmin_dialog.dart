import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';

class AddingManagerDialog extends StatefulWidget {
  final UserRole? newuserRoleIfAny;
  const AddingManagerDialog({Key? key, this.newuserRoleIfAny})
      : super(key: key);

  @override
  State<AddingManagerDialog> createState() => _AddingManagerDialogState();
}

class _AddingManagerDialogState extends State<AddingManagerDialog> {
  late Widget newUserRoleWidget;
  _AddingManagerDialogState();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const SizedBox(
          width: 500, child: Text('Agregar administrador de sistema')),
      content: Scaffold(
        body: SizedBox(
          width: 500,
          child: Column(children: [
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () => {Navigator.of(context).pop(Manager())},
                  child: const SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Center(child: Text('Cancelar')),
                  )),
            ),
            const SizedBox(
              height: 50,
            )
          ]),
        ),
      ),
    );
  }
}
