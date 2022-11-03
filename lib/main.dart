import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/data/utils/theme_data_system.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/presentation/routes.dart';

main() async {
  await IESSystem().initializeIESSystem();
  runApp(const ProviderScope(child: AdminIESApp()));
}

class AdminIESApp extends ConsumerWidget {
  const AdminIESApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _iesSystemStatesProvider =
        ref.watch(IESSystem().stateNotifierProvider);
    // print(_iesSystemStatesProvider.stateName.name);
    // systemRouter.goNamed(_iesSystemStatesProvider.stateName.name);
    systemRouter.goNamed(_iesSystemStatesProvider.stateName.name);

    return MaterialApp.router(
        title: 'Flutter Authentication',
        routeInformationParser: systemRouter.routeInformationParser,
        routerDelegate: systemRouter.routerDelegate,
        routeInformationProvider: systemRouter.routeInformationProvider,
        debugShowCheckedModeBanner: false,
        theme: ThemeDataSW.themeDataSW);
  }
}
