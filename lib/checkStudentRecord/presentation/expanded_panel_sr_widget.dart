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

StateNotifierProvider<PanelNotifier, PanelState> subjectCardNotifier =
    StateNotifierProvider<PanelNotifier, PanelState>(
        ((ref) => PanelNotifier().init(30)));

class ExpandedPanelStudentRecordCard extends ConsumerWidget {
  const ExpandedPanelStudentRecordCard({Key? key, required this.subjects})
      : super(key: key);
  final List<SubjectSR> subjects;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExpansionPanelList(
      expansionCallback: (subjectCardNotifier, isExpanded) {
        ref.read(panelStateNotifier.notifier).toggle(subjectCardNotifier);
      },
      children: subjects.map((SubjectSR value) {
        return ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return Text("Cursado ${value.name} ");
            },
            body: Column(
              children: [
                Text("Estado: ${value.coursing ? "Cursando" : "Nada"}"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubjectDetails(
                                  iesUser:
                                      IESSystem().homeUseCase.currentIESUser,
                                  event: filterSubjectsWhereThereAreMovements(
                                      subjects)[subjects.indexOf(value)])));
                    },
                    child: const Text("Ver más"))
              ],
            ),
            isExpanded: ref
                .watch(panelStateNotifier)
                .panelState[subjects.indexOf(value)]);
      }).toList(),
    );
  }
}
