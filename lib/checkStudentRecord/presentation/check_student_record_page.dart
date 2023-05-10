import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/checkStudentRecord/domain/check_student_record.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/widget/user_info_w.dart';
import 'package:sistema_ies/checkStudentRecord/utils/generate_subject_items.dart';

StateNotifierProvider<SubjectStateNotifier, SubjectState> subjectStateNotifier =
    StateNotifierProvider<SubjectStateNotifier, SubjectState>(((ref) =>
        SubjectStateNotifier(
            subjects: generateSubjectItems(IESSystem()
                .checkStudentRecordUseCase
                .studentRole
                .srSubjects))));

class CheckStudentRecordPage extends ConsumerWidget {
  const CheckStudentRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentRecordProvider = ref
        .watch(IESSystem().checkStudentRecordUseCase.stateNotifierProvider)
        ;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => IESSystem()
                .onUserLogged(IESSystem().homeUseCase.currentIESUser),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          automaticallyImplyLeading: false,
        ),
        body: studentRecordProvider.stateName != CheckStudentRecordStateName.loading
            ? Center(
                child: Column(children: [
                userInfoBar(IESSystem().homeUseCase.currentIESUser, context),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: IESSystem()
                          .checkStudentRecordUseCase
                          .studentRole
                          .srSubjects
                          .length,
                      itemBuilder: (context, index) {
                        return TextButton(
                            onPressed: () {
                              print(IESSystem()
                                  .checkStudentRecordUseCase
                                  .studentRole
                                  .srSubjects[index]
                                  .subjectId);
                            },
                            child: Text(IESSystem()
                                .checkStudentRecordUseCase
                                .studentRole
                                .srSubjects[index]
                                .name));
                      }),
                )
              ]))
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
