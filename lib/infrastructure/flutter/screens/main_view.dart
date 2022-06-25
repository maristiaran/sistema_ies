import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/auth_views.dart';

class MainView extends ConsumerWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _systemStatesProvider = ref.watch(IESSystem().stateNotifierProvider);

    if (_systemStatesProvider.stateName == IESSystemStateName.iesAuth) {
      return const AuthView();
    } else {
      throw "Why?!!!";
    }
  }
}
