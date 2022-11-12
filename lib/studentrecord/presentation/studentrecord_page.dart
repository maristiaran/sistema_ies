import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/studentrecord/domain/student_record.dart';

class StudentRecordPage extends ConsumerWidget {
  const StudentRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentStudentRecordState =
        ref.watch(IESSystem().studentRecordUseCase.stateNotifierProvider);
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          TextButton(
              onPressed: () {
                IESSystem()
                    .studentRecordUseCase
                    .setAsLoading(IESSystem().homeUseCase.currentIESUser);
                print(_currentStudentRecordState.stateName.name);
              },
              child: const Text("Traer studentsRecords")),
          Text(_currentStudentRecordState.stateName.name),
        ],
      )),
    );
  }
}
