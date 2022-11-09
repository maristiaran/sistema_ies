import 'package:go_router/go_router.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/home/presentation/home_page.dart';
import 'package:sistema_ies/login/presentation/login_page.dart';
import 'package:sistema_ies/login/presentation/password_reset_sent.dart';
import 'package:sistema_ies/login/presentation/recovery_pass_page.dart';
import 'package:sistema_ies/registering/presentation/register_page.dart';

late final systemRouter = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      name: 'home',
      path: '/',
      builder: (context, state) => HomePage(),
    ),
    GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => LoginPage(),
        routes: [
          GoRoute(
            name: 'registering',
            path: 'registering',
            builder: (context, state) => RegisterPage(),
          ),
          GoRoute(
            name: RecoveryPassPage.nameRoute,
            path: RecoveryPassPage.pathRoute,
            builder: (context, state) => RecoveryPassPage(),
          ),
        ]),
  ],

  redirect: (state) {
    // print(IESSystem().currentIESUserIfAny());
    // print(state.subloc);
    // if (IESSystem().currentIESUserIfAny() == null) {
    //   if ((state.subloc == state.namedLocation('login')) ||
    //       (state.subloc == state.namedLocation('registering'))) {
    //     return null;
    //   } else {
    //     return state.namedLocation('login');
    //   }
    // } else {
    // print(IESSystem().currentState.stateName.name);
    if (state.subloc ==
        state.namedLocation(IESSystem().currentState.stateName.name)) {
      return null;
    } else {
      return state.namedLocation(IESSystem().currentState.stateName.name);
      // }
    }

    // return null;
  },

  // changes on the listenable will cause the router to refresh it's route
  // refreshListenable: loginInfo,
);

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({required this.families, Key? key}) : super(key: key);
//   final List<Family> families;

//   @override
//   Widget build(BuildContext context) {
//     final info = context.read<LoginInfo>();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(App.title),
//         actions: [
//           IconButton(
//             onPressed: info.logout,
//             tooltip: 'Logout: ${info.userName}',
//             icon: const Icon(Icons.logout),
//           )
//         ],
//       ),
//       body: ListView(
//         children: [
//           for (final f in families)
//             ListTile(
//               title: Text(f.name),
//               onTap: () => context.goNamed('family', params: {'fid': f.id}),
//             )
//         ],
//       ),
//     );
//   }
// }
