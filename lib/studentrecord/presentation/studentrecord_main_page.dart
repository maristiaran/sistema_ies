import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/studentrecord/domain/student_record.dart';
import 'package:sistema_ies/studentrecord/presentation/studentrecord_page.dart';

class StudentRecordMainPage extends ConsumerWidget {
  const StudentRecordMainPage({Key? key}) : super(key: key);

  static const String nameRoute = "studentrecord";
  static const String pathRoute = "/$nameRoute";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _elements = {
      StudentRecordStateName.init: 0,
      StudentRecordStateName.loading: 1,
      StudentRecordStateName.studentRecordGetSuccesfully: 0,
      StudentRecordStateName.failure: 2,
    };
    final List<Widget> _widgetOptions = <Widget>[
      const StudentRecordPage(),
      const Center(
        child: CircularProgressIndicator(),
      ),
    ];
    final _currentStudentRecordState =
        ref.watch(IESSystem().studentRecordUseCase.stateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => IESSystem().studentRecordUseCase.returnToHome(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: _widgetOptions
          .elementAt(_elements[_currentStudentRecordState.stateName]!),
    );
  }
}
// _currentStudentRecordState.studentRecord != null? _currentStudentRecordState.studentRecord!.name