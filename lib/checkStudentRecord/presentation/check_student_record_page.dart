import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/checkStudentRecord/domain/check_student_record.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/subject_student_record_details.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/widget/user_info_w.dart';

class CheckStudentRecordPage extends ConsumerWidget {
  const CheckStudentRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _checkStudentRecordStatesProvider =
        ref.watch(IESSystem().checkStudentRecordUseCase.stateNotifierProvider);
    String sEventName = "";
    for (MovementStudentRecord studentEvent
        in _checkStudentRecordStatesProvider.currentRole.studentEvents) {
      sEventName = sEventName + "\n" + studentEvent.toString();
      // print(studentEvent);
    }
    final subjects = _checkStudentRecordStatesProvider.currentRole.srSubjects;
    // print(subjects);
    // print(subjects[0].movements);

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
                      itemCount: subjects.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) => subjects.isNotEmpty
                          ? SingleChildScrollView(
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(-5, 6),
                                        spreadRadius: -8,
                                        blurRadius: 12,
                                        color: Color.fromRGBO(74, 144, 226, 1),
                                      )
                                    ],
                                    color: selectColorByState(subjects[index]),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10))),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
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
                                        subjects[index].name,
                                      ),
                                      onTap: () {
                                        ref
                                            .read(panelStateNotifier.notifier)
                                            .init(5);

                                        // .init(
                                        //     (_checkStudentRecordStatesProvider
                                        //             .currentRole as Student)
                                        //         .studentEvents
                                        //         .length);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SubjectDetails(
                                                      iesUser: IESSystem()
                                                          .homeUseCase
                                                          .currentIESUser,
                                                      event: subjects[index])),
                                        );
                                      }),
                                ),
                              ),
                            )
                          : Container())),
            ),
          ],
        ),
      ),
    );
  }
}

// Fuctions needed

// List<MovementStudentRecord> repeatedSubjectFilter(
//     List<MovementStudentRecord> events) {
//   List<MovementStudentRecord> result = [];
//   for (MovementStudentRecord studentEvent in events) {
//     if (result.every((element) => element.subject != studentEvent.subject)) {
//       result.add(studentEvent);
//     }
//   }
//   return result;
// }

Color selectColorByState(SubjectSR state) {
  Color color = const Color.fromARGB(255, 163, 163, 163);
  // if (state.movementName ==
  //         MovementStudentRecordName.finalExamApprovedByCertification ||
  //     state.movementName ==
  //         MovementStudentRecordName.courseApprovedWithAccreditation ||
  //     state.movementName ==
  //         MovementStudentRecordName.finalExamApprovedByCertification) {
  //   color = const Color.fromARGB(255, 27, 182, 61);
  // } else if (state.movementName ==
  //         MovementStudentRecordName.courseFailedNonFree ||
  //     state.movementName == MovementStudentRecordName.finalExamApproved) {
  //   color = const Color.fromARGB(255, 81, 126, 240);
  // } else if (state.movementName ==
  //     MovementStudentRecordName.courseRegistering) {
  //   color = const Color.fromARGB(255, 240, 232, 81);
  // } else if (state.movementName == MovementStudentRecordName.courseFailedFree ||
  //     state.movementName == MovementStudentRecordName.finalExamNonApproved) {
  //   color = const Color.fromARGB(255, 182, 27, 27);
  // }
  return color;
}
