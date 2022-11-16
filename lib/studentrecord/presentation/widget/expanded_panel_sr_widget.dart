import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student_record.dart';
import 'package:flutter/material.dart';
import 'package:sistema_ies/studentrecord/domain/student_record.dart';

class ExpandedPanelStudentRecord extends ConsumerWidget {
  const ExpandedPanelStudentRecord({Key? key, required this.subjectMovements})
      : super(key: key);
  final List<MovementStudentRecord> subjectMovements;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        ref.read(panelStateNotifier.notifier).toggle(panelIndex);
      },
      children: subjectMovements.map((MovementStudentRecord value) {
        return ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Text("Cursado ${value.year} ");
            },
            body: Text("Nota: ${value.nota}"),
            isExpanded: ref
                .watch(panelStateNotifier)
                .panelState[subjectMovements.indexOf(value)]);
      }).toList(),
    );
  }
}
