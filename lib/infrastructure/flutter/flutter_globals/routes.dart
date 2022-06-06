import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/login_page.dart';
import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/register_page.dart';
import 'package:sistema_ies/shared/utils/states.dart';

class AdminIESRouter {
  // 1
  final UseCaseState loginState;
  AdminIESRouter(this.loginState);

  // 2
  late final router = GoRouter(
    // 3
    // refreshListenable: loginState,
    // 4
    debugLogDiagnostics: true,
    // 5
    urlPathStrategy: UrlPathStrategy.path,

    // 6
    routes: [
      GoRoute(
        name: 'rootRouteName',
        path: '/',
        redirect: (state) =>
            // TODO: Change to Home Route
            state.namedLocation('loginRouteName'),
      ),
      GoRoute(
        name: 'loginRouteName',
        path: '/login',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: LoginPage(),
        ),
      ),
      GoRoute(
        name: 'registerRouteName',
        path: '/register',
        pageBuilder: (context, state) => MaterialPage<void>(
          key: state.pageKey,
          child: RegisterIncomingStudentPage(),
        ),
      )
    ],
    // TODO: Add Error Handler
    // TODO Add Redirect
  );
}
