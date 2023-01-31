import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/checkStudentRecord/domain/check_student_record.dart';
// import 'package:sistema_ies/checkStudentRecord/presentation/expanded_panel_sr_widget.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/subject_student_record_details.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/widget/user_info_w.dart';

class CheckStudentRecordPage extends ConsumerWidget {
  const CheckStudentRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkStudentRecordStatesProvider =
        ref.watch(IESSystem().checkStudentRecordUseCase.stateNotifierProvider);

    final List<SubjectSR> subjects =
        checkStudentRecordStatesProvider.currentRole.srSubjects;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              IESSystem().onUserLogged(IESSystem().homeUseCase.currentIESUser),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          children: [
            userInfoBar(IESSystem().homeUseCase.currentIESUser, context),
            Expanded(
              child: Container(
                  constraints: BoxConstraints(
                      maxWidth: (MediaQuery.of(context).size.width / 10) * 3),
                  child: ListView.builder(
                      itemCount:
                          filterSubjectsWhereThereAreMovements(subjects).length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          filterSubjectsWhereThereAreMovements(subjects)
                                  .isNotEmpty
                              ? SingleChildScrollView(
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            offset: Offset(-5, 6),
                                            spreadRadius: -8,
                                            blurRadius: 12,
                                            color:
                                                Color.fromRGBO(74, 144, 226, 1),
                                          )
                                        ],
                                        color: selectColorByState(
                                            filterSubjectsWhereThereAreMovements(
                                                subjects)[index]),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(10))),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: ListTile(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 10, horizontal: 10),
                                          title: Text(
                                            filterSubjectsWhereThereAreMovements(
                                                    subjects)[index]
                                                .name,
                                          ),
                                          onTap: () {
                                            ref
                                                .read(
                                                    panelStateNotifier.notifier)
                                                .init(
                                                    filterSubjectsWhereThereAreMovements(
                                                            subjects)[index]
                                                        .movements
                                                        .length);

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SubjectDetails(
                                                          iesUser: IESSystem()
                                                              .homeUseCase
                                                              .currentIESUser,
                                                          event:
                                                              filterSubjectsWhereThereAreMovements(
                                                                      subjects)[
                                                                  index])),
                                            );
                                          }),
                                    ),
                                  ),
                                )
                              /* ExpandedPanelStudentRecordCard(
                                          subjects: subjects)) */
                              : Container())),
            ),
          ],
        ),
      ),
    );
  }
}

// Fuctions needed

List<SubjectSR> filterSubjectsWhereThereAreMovements(List<SubjectSR> subjects) {
  final List<SubjectSR> subjectsFilter = [];
  for (var element in subjects) {
    if (element.movements.isNotEmpty) {
      subjectsFilter.add(element);
    }
  }
  return subjectsFilter;
}

Color selectColorByState(SubjectSR subjects) {
  Color color = const Color.fromARGB(255, 163, 163, 163);
  if (subjects.subjectState == SubjetState.approved) {
    color = const Color.fromARGB(255, 27, 182, 61);
  } else if (subjects.subjectState == SubjetState.regular) {
    color = const Color.fromARGB(255, 81, 126, 240);
  } else if (subjects.subjectState == SubjetState.coursing) {
    color = const Color.fromARGB(255, 240, 232, 81);
  } else if (subjects.subjectState == SubjetState.dessaproved) {
    color = const Color.fromARGB(255, 182, 27, 27);
  }
  return color;
}
