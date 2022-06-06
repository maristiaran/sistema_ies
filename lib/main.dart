import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/firebase_options.dart';
import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/login_page.dart';
import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/register_page.dart';
// import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/register.dart';

void main() async {
  await initFirestore();
  runApp(ProviderScope(child: AdminIESApp()));
}

Future<void> initFirestore() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class AdminIESApp extends StatelessWidget {
  AdminIESApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routeInformationParser: _router.routeInformationParser,
        routerDelegate: _router.routerDelegate,
        title: 'IES 9-010',
      );

  final GoRouter _router = GoRouter(
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) => LoginPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (BuildContext context, GoRouterState state) =>
            RegisterIncomingStudentPage(),
      ),
    ],
  );
}
