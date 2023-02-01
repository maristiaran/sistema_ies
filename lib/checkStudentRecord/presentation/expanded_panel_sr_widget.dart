import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sistema_ies/checkStudentRecord/domain/check_student_record.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/check_student_record_page.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/subject_student_record_details.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class ExpandedPanelStudentRecord extends ConsumerWidget {
  const ExpandedPanelStudentRecord({Key? key, required this.events})
      : super(key: key);
  final List<MovementStudentRecord> events;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //ref.read(panelStateNotifier.notifier).init(events.length);
    return ExpansionPanelList(
      expansionCallback: (panelIndex, isExpanded) {
        ref.read(panelStateNotifier.notifier).toggle(panelIndex);
      },
      children: events.map((MovementStudentRecord value) {
        return ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Text("Cursado ${value.date} ");
            },
            body: Text("Nota: ${value.numericalGradeString()}"),
            isExpanded: ref
                .watch(panelStateNotifier)
                .panelState[events.indexOf(value)]);
      }).toList(),
    );
  }
}

class SubjectsItemSR extends ConsumerWidget {
  const SubjectsItemSR({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(maxWidth: 500.0, minWidth: 300.0),
          width: (MediaQuery.of(context).size.width / 3),
          child: ExpansionPanelList(
            expansionCallback: (index, isExpanded) {
              ref.read(subjectStateNotifier.notifier).update(index);
            },
            children: ref
                .watch(subjectStateNotifier)
                .subjects
                .map((SubjectItemCard value) {
              return ExpansionPanel(
                  headerBuilder: (context, isExpanded) {
                    return Text(value.subjectSR.name);
                  },
                  body: Text("Cuerpo del item"),
                  isExpanded: value.isExpanded);
            }).toList(),
          ),
        ),
      ),
    );
  }
}
