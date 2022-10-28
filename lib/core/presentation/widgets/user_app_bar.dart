import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class UserAppBar extends AppBar {
  UserAppBar({Key? key}) : super(key: key);

  @override
  _UserAppBarState createState() => _UserAppBarState();
}

class _UserAppBarState extends State<UserAppBar> {
  final UserRole? _selectedRole = null;
  // final UserRole _selectedRole = IESSystem().getCurrentIESUserRoles().first;
  // final UserRole? _selectedRole =
  //     IESSystem().currentIESUserIfAny()!.defaultRole;

  @override
  Widget build(BuildContext context) {
    print(_selectedRole);
    return Row(
      children: [
        const Icon(Icons.account_circle_rounded),
        Text(IESSystem().currentIESUserIfAny()!.firstname),
        const Icon(Icons.heart_broken),
        DropdownButton<UserRole>(
            items: IESSystem()
                .getCurrentIESUserRoles()
                .map((e) => DropdownMenuItem<UserRole>(
                    // child: Text(Random(1000).nextInt(2000).toString())))

                    child: Text(e.userRoleTypeName().name)))
//
                .toList(),
            value: _selectedRole,
            onChanged: _changeCurrentUserRole)
      ],
    );
  }

  _changeCurrentUserRole(UserRole? newRole) {
    if (newRole != null) {
      IESSystem().setCurrentRole(newRole);
    }
  }
}
