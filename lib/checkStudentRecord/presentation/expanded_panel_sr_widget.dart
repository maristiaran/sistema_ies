import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sistema_ies/checkStudentRecord/domain/check_student_record.dart';
import 'package:sistema_ies/core/domain/entities/student_record_entries.dart';

class ExpandedPanelStudentRecord extends ConsumerWidget {
  const ExpandedPanelStudentRecord({Key? key, required this.events})
      : super(key: key);
  final List<StudentEvent> events;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.read(panelStateNotifier.notifier).init(events.length);
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        ref.read(panelStateNotifier.notifier).toggle(panelIndex);
      },
      children: events.map((StudentEvent value) {
        return ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Text("Cursado ${value.date} ");
            },
            body: Text("Nota: ${value.numericalGrade}"),
            isExpanded: ref
                .watch(panelStateNotifier)
                .panelState[events.indexOf(value)]);
      }).toList(),
    );
  }
}
