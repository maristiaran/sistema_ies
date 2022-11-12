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
    IESSystem()
        .startStudentRecordFromHome(IESSystem().homeUseCase.currentIESUser);
    final _elements = {
      StudentRecordStateName.init: 0,
      StudentRecordStateName.loading: 1,
      StudentRecordStateName.failure: 2,
      StudentRecordStateName.studentRecordGetSuccesfully: 3,
    };
    final List<Widget> _widgetOptions = <Widget>[
      StudentRecordPage(),
      const Center(
        child: CircularProgressIndicator(),
      ),
      StudentRecordPage(),
      StudentRecordPage(),
    ];
    final _currentStudentRecordState =
        ref.watch(IESSystem().studentRecordUseCase.stateNotifierProvider);
    return _widgetOptions
        .elementAt(_elements[_currentStudentRecordState.stateName]!);
  }
}
// _currentStudentRecordState.studentRecord != null? _currentStudentRecordState.studentRecord!.name