import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/checkStudentRecord/domain/check_student_record.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/widget/user_info_w.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/widget/student_record_card.dart';

import 'widget/center_circle_progress_bar.dart';

class CheckStudentRecordPage extends ConsumerWidget {
  const CheckStudentRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<Enum, Widget> widgetElements = {
      CheckStudentRecordStateName.success: const StudentRecordExpandedList(),
      CheckStudentRecordStateName.loading: const CenterCircleProgressBar(),
      CheckStudentRecordStateName.studentRecordExtended:
          const StudentRecordExpandedList()
    };

    final currentBody = widgetElements.keys.firstWhere((element) =>
        element ==
        ref
            .watch(IESSystem().checkStudentRecordUseCase.stateNotifierProvider)
            .stateName);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => IESSystem()
                .onUserLogged(IESSystem().homeUseCase.currentIESUser),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          automaticallyImplyLeading: false,
        ),
        body: widgetElements[currentBody]);
  }
}

class StudentRecordExpandedList extends StatelessWidget {
  const StudentRecordExpandedList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      userInfoBar(IESSystem().homeUseCase.currentIESUser, context),
      Expanded(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: IESSystem()
                .checkStudentRecordUseCase
                .studentRole
                .srSubjects
                .length,
            itemBuilder: (context, index) {
              return StudentRecordCard(IESSystem()
                  .checkStudentRecordUseCase
                  .studentRole
                  .srSubjects[index]);
            }),
      )
    ]));
  }
}
