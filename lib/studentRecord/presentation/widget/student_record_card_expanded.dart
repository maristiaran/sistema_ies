import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';

import '../../../core/domain/ies_system.dart';
import '../../domain/student_record.dart';
import 'center_circle_progress_bar.dart';
import 'details_student_record.dart';

class StudentRecordCardExpanded extends ConsumerWidget {
  StudentRecordSubject studentRecordSubject;
  StudentRecordCardExpanded(this.studentRecordSubject, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<Enum, Widget> widgetElements = {
      StudentRecordStateName.studentRecordExtended: Center(
          child: ListView.builder(
              itemCount: studentRecordSubject.movements.length,
              itemBuilder: (context, index) => DetailsStudentRecordCard(
                  studentRecordSubject.movements[index]))),
      StudentRecordStateName.loading: const CenterCircleProgressBar()
    };
    final currentBody = widgetElements.keys.firstWhere((element) =>
        element ==
        ref
            .watch(IESSystem().studentRecordUseCase.stateNotifierProvider)
            .stateName);
    return Scaffold(appBar: AppBar(), body: widgetElements[currentBody]);
  }
}
