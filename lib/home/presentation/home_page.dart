import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sistema_ies/checkStudentRecord/presentation/check_student_record_page.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sistema_ies/application/ies_system.dart';
// import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/auth_views.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);
  // final List operations =
  //     IESSystem().getCurrentUserRoleParameterizedOperations();
  final _currentIndex = StateProvider((ref) => 0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeStatesProvider =
        ref.watch(IESSystem().homeUseCase.stateNotifierProvider);

    final userName = IESSystem().homeUseCase.currentIESUser.firstname;

    final List<Widget> widgetOptions = <Widget>[
      const Text("Home"),
      const Text("StudentRecord"),
      const Text(
        'Index 2: Calendario',
      ),
      ListView.builder(
          itemCount: homeStatesProvider.getCurrentUserRoleOperations().length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: TextButton(
                onPressed: () async {
                  IESSystem().onHomeSelectedOperation(
                      homeStatesProvider.getCurrentUserRoleOperations()[index]);
                },
                child: Text(
                  homeStatesProvider
                      .getCurrentUserRoleOperations()[index]
                      .title,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            );
          }),
    ];
    return Scaffold(
      appBar: AppBar(
          // leadingWidth: 160,
          leading: CircleAvatar(
              // maxRadius: 13,
              child: Text(userName[0])),
          title: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                "Hola $userName",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const Spacer(),
              Text(
                IESSystem()
                    .getRolesAndOperationsRepository()
                    .getUserRoleType(
                        homeStatesProvider.currentRole.userRoleTypeName())
                    .title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.change_circle_rounded),
              tooltip: 'Cambiar rol',
              onPressed: () {
                IESSystem().homeUseCase.startSelectingUserRole();
              },
            ), //IconButton
            //IconButton
          ]),
      body: widgetOptions.elementAt(ref.watch(_currentIndex)),
      bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme:
              const IconThemeData(color: Color.fromARGB(255, 108, 145, 199)),
          selectedItemColor: const Color.fromARGB(255, 108, 145, 199),
          onTap: (int value) {
            ref.read(_currentIndex.notifier).state = value;
          },
          backgroundColor: Colors.white,
          currentIndex: ref.watch(_currentIndex),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(FontAwesomeIcons.house,
                  color: Color.fromARGB(255, 108, 145, 199)),
            ),
            BottomNavigationBarItem(
                label: "Tray. Est",
                icon: Icon(FontAwesomeIcons.idCard,
                    color: Color.fromARGB(255, 108, 145, 199))),
            BottomNavigationBarItem(
                label: "Calendar",
                icon: Icon(FontAwesomeIcons.calendarDays,
                    color: Color.fromARGB(255, 108, 145, 199))),
            BottomNavigationBarItem(
                label: "Menu",
                icon: Icon(FontAwesomeIcons.bars,
                    color: Color.fromARGB(255, 108, 145, 199)))
          ]),
    );
  }
}
