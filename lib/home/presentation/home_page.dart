import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/presentation/widgets/user_app_bar.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sistema_ies/application/ies_system.dart';
// import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/auth_views.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _homeStatesProvider =
        ref.watch(IESSystem().homeUseCase.stateNotifierProvider);
    return Scaffold(appBar: UserAppBar(), body: const Text('Usuario'));
    // body: Text(IESSystem().currentIESUserIfAny()!.firstname));
  }
}
