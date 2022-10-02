import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/model/ies_system.dart';
import 'package:sistema_ies/core/pages/widgets/user_app_bar.dart';

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
