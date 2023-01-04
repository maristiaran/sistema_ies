import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student_record_entries.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class CheckStudentRecordPage extends ConsumerWidget {
  const CheckStudentRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _checkStudentRecordStatesProvider =
        ref.watch(IESSystem().checkStudentRecordUseCase.stateNotifierProvider);
    String sEventName = "";
    for (StudentEvent studentEvent
        in (_checkStudentRecordStatesProvider.currentRole as Student)
            .studentEvents) {
      sEventName = sEventName + "\n" + studentEvent.toString();
      // print(studentEvent);
    }
    return Text('Check Student Record \n $sEventName ',
        style: const TextStyle(color: Colors.black, fontSize: 14));
  }
}
