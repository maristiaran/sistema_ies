import 'package:flutter/material.dart';
import 'package:sistema_ies/application/ies_system.dart';

class SelectUserRolePage extends StatelessWidget {
  const SelectUserRolePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: IESSystem()
            .getCurrentIESUserRoles()
            .map((e) =>
                ElevatedButton(onPressed: () => {}, child: Text(e.toString())))
            .toList());
  }
}
