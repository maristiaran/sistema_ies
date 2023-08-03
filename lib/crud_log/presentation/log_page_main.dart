import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/crud_log/domain/crud_log.dart';
import 'package:sistema_ies/crud_log/presentation/logs_page.dart';
import 'package:sistema_ies/crud_log/presentation/widgets/failure.dart';

class LogPageMain extends ConsumerWidget {
  // ignore: prefer_const_constructors_in_immutables
  LogPageMain({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<Enum, Widget> widgetElements = {
      LogStateName.init: const LogsPage(),
      LogStateName.failure: const FailureLogPage(),
      LogStateName.loading: const Center(
        child: CircularProgressIndicator(),
      ),
    };
    final currentBody = widgetElements.keys.firstWhere((element) =>
        element ==
        ref.watch(IESSystem().logUseCase.stateNotifierProvider).stateName);
    return Scaffold(body: widgetElements[currentBody]);
  }
}
