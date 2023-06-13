import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';

import '../../../core/domain/ies_system.dart';
import '../../domain/check_student_record.dart';
import '../check_student_record_page.dart';

class StudentRecordCardExpanded extends ConsumerWidget {
  StudentRecordSubject studentRecordSubject;
  StudentRecordCardExpanded(this.studentRecordSubject, {Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Map<Enum, Widget> widgetElements = {
      CheckStudentRecordStateName.studentRecordExtended: Center(
          child: ListView.builder(
              itemCount: studentRecordSubject.movements.length,
              itemBuilder: (context, index) => Text(studentRecordSubject
                  .movements[index].movementName
                  .toString()))),
      CheckStudentRecordStateName.loading: const CenterCircleProgressBar()
    };
    final currentBody = widgetElements.keys.firstWhere((element) =>
        element ==
        ref
            .watch(IESSystem().checkStudentRecordUseCase.stateNotifierProvider)
            .stateName);
    return Scaffold(appBar: AppBar(), body: widgetElements[currentBody]);
  }
}


// Llamar la función acá dentro ya que le paso el  objeto de la materia, va a tener el Id. Entonces uso el when para que cuando tenga los datos los muestre, sino, muestre un progress bar

/*
ref.watch(studentRecordMovements).isNotEmpty
            ? Center(
                child: ListView.builder(
                    itemCount: ref.watch(studentRecordMovements).length,
                    itemBuilder: (context, index) => Text(ref
                        .watch(studentRecordMovements)[index]
                        .movementName
                        .toString())))
            : Center(
                child: Column(children: [
                  const CircularProgressIndicator(),
                  TextButton(
                      onPressed: () {
                        //print(ref.watch(studentRecordMovements));
                      },
                      child: const Text("data"))
                ]),
              ) */