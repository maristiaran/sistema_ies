import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/expanded_panel_sr_widget.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/widget/user_info_w.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
// import 'package:sistema_ies/core/domain/ies_system.dart';

class SubjectDetails extends ConsumerWidget {
  const SubjectDetails({Key? key, required this.iesUser, required this.event})
      : super(key: key);
  final IESUser iesUser;
  final SubjectSR event;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final checkStudentRecordStatesProvider =
    //     ref.watch(IESSystem().checkStudentRecordUseCase.stateNotifierProvider);
    // final subjectMovements =
    //     _checkStudentRecordStatesProvider.currentRole.studentEvents;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            userInfoBar(iesUser, context),
            SizedBox(
              width: (MediaQuery.of(context).size.width / 3) * 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("Materia ${event.name}")],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2),
              child: ExpandedPanelStudentRecord(events: event.movements),
            )
          ],
        ),
      ),
    );
  }
}

/* ExpandedPanelStudentRecord(
                  subjectMovements: subjectMovements) */
// List<MovementStudentRecord> getAllStudentEventBySubject(
//     List<MovementStudentRecord> studentEvents, MovementStudentRecord event) {
//   List<MovementStudentRecord> result = [];
//   for (var element in studentEvents) {
//     if (element.subject == event.subject) {
//       result.add(element);
//     }
//   }
//   return result;
// }
