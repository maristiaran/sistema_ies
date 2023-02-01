import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/checkStudentRecord/domain/check_student_record.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/expanded_panel_sr_widget.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/widget/user_info_w.dart';

class CheckStudentRecordPage extends ConsumerWidget {
  const CheckStudentRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _data = ref.watch(subjectStateNotifier).subjects;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => IESSystem()
                .onUserLogged(IESSystem().homeUseCase.currentIESUser),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Center(
            child: Column(children: [
          userInfoBar(IESSystem().homeUseCase.currentIESUser, context),
          Container(child: SubjectsItemSR())
        ])));
  }
}

