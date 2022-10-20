import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sistema_ies/application/ies_system.dart';
// import 'package:sistema_ies/infrastructure/flutter/screens/users/auth/auth_views.dart';

class HomePage extends ConsumerWidget {
  HomePage({Key? key}) : super(key: key);
  final _currentIndex = StateProvider((ref) => 0);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
    ),
    Text(
      'Index 1: Trayecto estudiantil',
    ),
    Text(
      'Index 2: Calendario',
    ),
    Text(
      'Index 3: Menu',
    ),
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userName = IESSystem().currentIESUserIfAny()!.firstname;
    final _homeStatesProvider =
        ref.watch(IESSystem().homeUseCase.stateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 160,
        leading: Builder(
          builder: (BuildContext context) {
            return TextButton(
              onPressed: () {},
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(child: Text(userName[0]), maxRadius: 13),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      "Hola $userName",
                      overflow: TextOverflow.clip,
                      maxLines: 1,
                      softWrap: false,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: Theme.of(context).colorScheme.background,
                  )
                ],
              ),
            );
          },
        ),
      ),
      body: _widgetOptions.elementAt(ref.watch(_currentIndex)),
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
    // body: Text(IESSystem().currentIESUserIfAny()!.firstname));
  }
}
