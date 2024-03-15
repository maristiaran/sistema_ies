import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/studentRecord/domain/student_record.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/studentRecord/presentation/widget/user_info_w.dart';
import 'package:sistema_ies/studentRecord/presentation/widget/student_record_card.dart';

import 'widget/center_circle_progress_bar.dart';

class CheckStudentRecordPage extends ConsumerWidget {
  const CheckStudentRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<Enum, Widget> widgetElements = {
      StudentRecordStateName.success: const StudentRecordExpandedList(),
      StudentRecordStateName.loading: const CenterCircleProgressBar(),
      StudentRecordStateName.studentRecordExtended:
          const StudentRecordExpandedList()
    };

    final currentBody = widgetElements.keys.firstWhere((element) =>
        element ==
        ref
            .watch(IESSystem().studentRecordUseCase.stateNotifierProvider)
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
                .studentRecordUseCase
                .studentRole
                .srSubjects
                .length,
            itemBuilder: (context, index) {
              return StudentRecordCard(IESSystem()
                  .studentRecordUseCase
                  .studentRole
                  .srSubjects[index]);
            }),
      )
    ]));
  }
}
