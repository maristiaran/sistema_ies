import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/application/use_cases/users/auth.dart';
import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/login_page.dart';
import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/register_page.dart';
import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/select_role_page.dart';
import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/select_user_role_operation.dart';

class AuthView extends ConsumerWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authStatesProvider =
        ref.watch(IESSystem().authUseCase.stateNotifierProvider);

    if (_authStatesProvider.stateName == AuthState.login) {
      return LoginPage();
    } else if (_authStatesProvider.stateName ==
        AuthState.registeringAsNewUser) {
      RegisterIncomingStudentPage registeringPage =
          RegisterIncomingStudentPage();
      // Navigator.push(
      //         context, MaterialPageRoute(builder: (context) => registeringPage))
      //     .then((value) {
      //   return this;
      // });
      return registeringPage;
    } else if (_authStatesProvider.stateName == AuthState.selectingRole) {
      return const SelectUserRolePage();
    } else {
      return const SelectUserRoleOperationPage();
    }
  }
}
