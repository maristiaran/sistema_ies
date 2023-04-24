import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sistema_ies/checkStudentRecord/domain/check_student_record.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/checkStudentRecord/utils/select_color_by_state.dart';
import 'package:sistema_ies/checkStudentRecord/utils/filter_subjects_where_there_are_movements.dart';

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
        child: ExpansionPanelList(
          expansionCallback: (index, isExpanded) {
            ref.read(subjectStateNotifier.notifier).update(index);
          },
          children: filterSubjectsWhereThereAreMovements(
                  ref.watch(subjectStateNotifier).subjects)
              .map((SubjectItemCard value) {
            return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return Container(
                      width: (MediaQuery.of(context).size.width / 3),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      constraints: const BoxConstraints(
                          minHeight: 50.0, maxWidth: 500.0, minWidth: 300.0),
                      decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              offset: Offset(-5, 6),
                              spreadRadius: -8,
                              blurRadius: 12,
                              color: Color.fromRGBO(74, 144, 226, 1),
                            )
                          ],
                          color: selectColorByState(
                              filterSubjectsWhereThereAreMovements(
                                      ref.watch(subjectStateNotifier).subjects)[
                                  ref
                                      .watch(subjectStateNotifier)
                                      .subjects
                                      .indexOf(value)]),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                          width: (MediaQuery.of(context).size.width / 3),
                          alignment: Alignment.centerLeft,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Text('  ${value.subjectSR.name}')));
                },
                body: const Text("Cuerpo del item"),
                isExpanded: value.isExpanded);
          }).toList(),
        ),
      ),
    );
  }
}


/* SingleChildScrollView(
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(-5, 6),
                                            spreadRadius: -8,
                                            blurRadius: 12,
                                            color:
                                                Color.fromRGBO(74, 144, 226, 1),
                                          )
                                        ],
                                        color: selectColorByState(
                                            filterSubjectsWhereThereAreMovements(
                                                subjects)[index]),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: */