import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/repositories/studentrecord_repository_port.dart';

DropdownButton<StudentRecord> dropDownButtonStudentRecord(
    studentRecordItems, WidgetRef ref, dropDownValueProvider) {
  return DropdownButton<StudentRecord>(
      value: ref.watch(dropDownValueProvider),
      onChanged: (StudentRecord? value) {
        ref.read(dropDownValueProvider.notifier).state = value!;
      },
      items: studentRecordItems);
}
