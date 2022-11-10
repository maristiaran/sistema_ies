import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/studentrecord/domain/student_record.dart';

class StudentRecordPage extends ConsumerWidget {
  const StudentRecordPage({Key? key}) : super(key: key);

  static const String nameRoute = "studentrecord";
  static const String pathRoute = "/$nameRoute";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _currentStudentRecordState =
        ref.watch(IESSystem().studentRecordUseCase.stateNotifierProvider);
    var currentIESUser;
    var syllabusId;
    return Scaffold(
        appBar: AppBar(
          title: const Text("StudentRecord"),
        ),
        body: Column(
          children: [
            _currentStudentRecordState.stateName == StudentRecordStateName.init
                ? Center(
                    child: Text(_currentStudentRecordState.studentRecord != null
                        ? _currentStudentRecordState.studentRecord!.name
                        : "Dio nulo"))
                : const Center(child: Text("StudentRecord Page otro")),
            ElevatedButton(
                onPressed: () => IESSystem()
                    .studentRecordUseCase
                    .getStudentRecords(currentIESUser, syllabusId),
                child: const Text("Traer studentRecords"))
          ],
        ));
  }
}
// _currentStudentRecordState.studentRecord != null? _currentStudentRecordState.studentRecord!.name