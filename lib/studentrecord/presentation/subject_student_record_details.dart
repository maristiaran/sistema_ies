import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student_record.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/studentrecord/presentation/widget/user_info_w.dart';

class PanelStateNotifier extends ChangeNotifier {
  final panelStates = <bool>[false, false, false];

  // Let's allow the UI to add todos.
  void add(bool panelState) {
    panelStates.add(panelState);
    notifyListeners();
  }

  void remove() {
    for (var i = 0; i < panelStates.length; i++) {
      panelStates[i] = false;
    }
    notifyListeners();
  }

  void toggle(int index) {
    for (var i = 0; i < panelStates.length; i++) {
      if (i == index) {
        panelStates[i] = !panelStates[i];
      } else {
        panelStates[i] = false;
      }
    }
    notifyListeners();
  }
}

@immutable
class PanelState {
  final List<bool> panelStates = [];
  PanelState remove() {
    for (var i = 0; i < panelStates.length; i++) {
      panelStates[i] = false;
    }
    return PanelState();
  }

  PanelState add(length) {
    for (var i = 0; i < length; i++) {
      panelStates[i] = false;
    }
    return PanelState();
  }

  PanelState toggle(int index) {
    for (var i = 0; i < panelStates.length; i++) {
      if (i == index) {
        panelStates[i] = !panelStates[i];
      } else {
        panelStates[i] = false;
      }
    }
    return PanelState();
  }
}

class PanelNotifier extends StateNotifier<PanelState> {
  PanelNotifier() : super(PanelState());
}

StateNotifierProvider<PanelNotifier, PanelState> panelStateNotifier =
    StateNotifierProvider<PanelNotifier, PanelState>(
        ((ref) => PanelNotifier()));

final todosProvider = ChangeNotifierProvider<PanelStateNotifier>((ref) {
  return PanelStateNotifier();
});

class SubjectDetails extends ConsumerWidget {
  SubjectDetails({Key? key, required this.iesUser, required this.subjectSR})
      : super(key: key);
  final IESUser iesUser;
  final SubjectSR subjectSR;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectMovements = subjectSR.movements;

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            userInfoBar(iesUser, context),
            Container(
              width: MediaQuery.of(context).size.width / 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("Materia ${subjectSR.name}")],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2),
              child: ExpansionPanelList(
                expansionCallback: (panelIndex, isExpanded) {
                  ref.read(todosProvider.notifier).toggle(panelIndex);
                },
                children: subjectMovements.map((MovementStudentRecord value) {
                  return ExpansionPanel(
                      headerBuilder: (context, isExpanded) {
                        return Text("Cursado ${value.year} ");
                      },
                      body: Text("Nota: ${value.nota}"),
                      isExpanded: ref
                          .watch(todosProvider)
                          .panelStates[subjectMovements.indexOf(value)]);
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
