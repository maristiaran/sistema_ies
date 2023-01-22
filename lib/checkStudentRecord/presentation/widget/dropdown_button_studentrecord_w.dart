import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';

DropdownButton<MovementStudentRecord> dropDownButtonStudentRecord(
    studentRecordItems, WidgetRef ref, dropDownValueProvider) {
  return DropdownButton<MovementStudentRecord>(
      value: ref.watch(dropDownValueProvider),
      onChanged: (MovementStudentRecord? value) {
        ref.read(dropDownValueProvider.notifier).state = value!;
      },
      items: studentRecordItems);
}
