import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student_record.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/studentrecord/presentation/widget/expanded_panel_sr_widget.dart';
import 'package:sistema_ies/studentrecord/presentation/widget/user_info_w.dart';

class SubjectDetails extends ConsumerWidget {
  const SubjectDetails(
      {Key? key, required this.iesUser, required this.subjectSR})
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
              width: (MediaQuery.of(context).size.width / 3) * 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text("Materia ${subjectSR.name}")],
              ),
            ),
            Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width / 2),
              child: ExpandedPanelStudentRecord(
                  subjectMovements: subjectMovements),
            )
          ],
        ),
      ),
    );
  }
}
