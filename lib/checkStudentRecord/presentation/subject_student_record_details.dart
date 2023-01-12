import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/expanded_panel_sr_widget.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/widget/user_info_w.dart';
import 'package:sistema_ies/core/domain/entities/student_record_entries.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class SubjectDetails extends ConsumerWidget {
  const SubjectDetails({Key? key, required this.iesUser, required this.event})
      : super(key: key);
  final IESUser iesUser;
  final StudentEvent event;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _checkStudentRecordStatesProvider =
        ref.watch(IESSystem().checkStudentRecordUseCase.stateNotifierProvider);
    final subjectMovements = getAllStudentEventBySubject(
        (_checkStudentRecordStatesProvider.currentRole as Student)
            .studentEvents,
        event);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            userInfoBar(iesUser, context),
            Container(
              width: (MediaQuery.of(context).size.width / 3) * 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("Materia ${event.subject.name}")],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2),
              child: ExpandedPanelStudentRecord(events: subjectMovements),
            )
          ],
        ),
      ),
    );
  }
}

/* ExpandedPanelStudentRecord(
                  subjectMovements: subjectMovements) */
List<StudentEvent> getAllStudentEventBySubject(
    List<StudentEvent> studentEvents, StudentEvent event) {
  List<StudentEvent> result = [];
  for (var element in studentEvents) {
    if (element.subject == event.subject) {
      result.add(element);
    }
  }
  return result;
}
