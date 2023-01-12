import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student_record_entries.dart';

DropdownButton<StudentEvent> dropDownButtonStudentRecord(
    studentRecordItems, WidgetRef ref, dropDownValueProvider) {
  return DropdownButton<StudentEvent>(
      value: ref.watch(dropDownValueProvider),
      onChanged: (StudentEvent? value) {
        ref.read(dropDownValueProvider.notifier).state = value!;
      },
      items: studentRecordItems);
}
