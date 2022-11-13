import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/repositories/studentrecord_repository_port.dart';
import 'package:sistema_ies/studentrecord/presentation/studentrecord_detail_page.dart';

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
          DropdownButton<StudentRecord>(
              value: ref.watch(dropDownValueProvider),
              onChanged: (StudentRecord? value) {
                ref.read(dropDownValueProvider.notifier).state = value!;
              },
              items: studentRecordItems),
          StudentRecordDetailsPage(
            studentRecord: ref.watch(dropDownValueProvider),
          )
        ],
      )),
    );
  }
}

Widget dropDownButon(ref, dropDownValueProvider, items) {
  return DropdownButton<StudentRecord>(
      value: ref.watch(dropDownValueProvider),
      onChanged: (value) =>
          ref.read(dropDownValueProvider.notifier).state = value!,
      items: items);
}
