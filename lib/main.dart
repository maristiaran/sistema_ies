import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/application_services.dart';
import 'package:sistema_ies/firebase_options.dart';
import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/auth_views.dart';

void main() {
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
        home: FutureBuilder(
            future: initializeApp(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return const AuthView();
              } else {
                return const CircularProgressIndicator();
              }
            })));
  }
}

Future initializeApp() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await IESSystem().startLogin();
}
// class AdminIESApp extends StatelessWidget {
//   AdminIESApp({Key? key}) : super(key: key);


  // @override
  // Widget build(BuildContext context) => MaterialApp.router(
  //       routeInformationParser: _router.routeInformationParser,
  //       routerDelegate: _router.routerDelegate,
  //       title: 'IES 9-010',
  //     );

  // final GoRouter _router = GoRouter(
  //   routes: <GoRoute>[
  //     GoRoute(
  //       path: '/',
  //       builder: (BuildContext context, GoRouterState state) =>
  //           const AuthView(),
  //     ),
  //     GoRoute(
  //       path: '/register',
  //       builder: (BuildContext context, GoRouterState state) =>
  //           RegisterIncomingStudentPage(),
  //     ),
  //   ],
  // );
// }
