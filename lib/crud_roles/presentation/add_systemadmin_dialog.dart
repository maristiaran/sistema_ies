import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';

class AddingSystemAdminDialog extends StatefulWidget {
  final UserRole? newuserRoleIfAny;
  const AddingSystemAdminDialog({Key? key, this.newuserRoleIfAny})
      : super(key: key);

  @override
  State<AddingSystemAdminDialog> createState() =>
      _AddingSystemAdminDialogState();
}

class _AddingSystemAdminDialogState extends State<AddingSystemAdminDialog> {
  late Widget newUserRoleWidget;
  _AddingSystemAdminDialogState();
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
                  onPressed: () => {Navigator.of(context).pop(SystemAdmin())},
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
