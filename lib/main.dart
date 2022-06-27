// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/ies_system.dart';
// import 'package:sistema_ies/firebase_options.dart';
import 'package:sistema_ies/infrastructure/flutter/screens/main_view.dart';

main() async {
  await IESSystem().initializeIESSystem();
  runApp(const ProviderScope(child: AdminIESApp()));
}

class AdminIESApp extends ConsumerWidget {
  const AdminIESApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        title: 'Flutter Authentication',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(
                fontSize: 24.0,
              ),
              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
            ),
          ),
          textTheme: TextTheme(
            headline1: TextStyle(
              fontSize: 46.0,
              color: Colors.blue.shade700,
              fontWeight: FontWeight.w500,
            ),
            bodyText1: const TextStyle(fontSize: 18.0),
          ),
        ),
        home: const MainView());

    // FutureBuilder(
    //     future: IESSystem().initializeIESSystem(),
    //     builder: ((context, snapshot) {
    //       if (snapshot.connectionState == ConnectionState.done) {
    //         return const MainView();
    //       } else {
    //         return const CircularProgressIndicator();
    //       }
    //     })));
  }
}
