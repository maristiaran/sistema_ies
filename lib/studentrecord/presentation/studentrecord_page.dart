import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/entities/student_record.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/studentrecord/presentation/studentrecord_detail_page.dart';
import 'package:sistema_ies/studentrecord/presentation/widget/dropdown_button_studentrecord_w.dart';
import 'package:sistema_ies/studentrecord/presentation/widget/user_info_w.dart';

final studentRecords = IESSystem().studentRecordUseCase.currentStudentRecords;
final studentRecordItems =
    studentRecords.map<DropdownMenuItem<StudentRecord>>((StudentRecord value) {
  return DropdownMenuItem<StudentRecord>(
    value: value,
    child: Text(value.name),
  );
}).toList();
final dropDownValueProvider = StateProvider((ref) => studentRecords[0]);

class StudentRecordPage extends ConsumerWidget {
  const StudentRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _studentRecordStatesProvider =
        ref.watch(IESSystem().studentRecordUseCase.stateNotifierProvider);
    // DropDown //

    return Scaffold(
      body: Center(
          child: Column(
        children: [
          userInfoBar(IESSystem().studentRecordUseCase.currentIESUser, context),
          dropDownButtonStudentRecord(
              studentRecordItems, ref, dropDownValueProvider),
          StudentRecordDetailsPage(
            studentRecord: ref.watch(dropDownValueProvider),
          )
        ],
      )),
    );
  }
}
