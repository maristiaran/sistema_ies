import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student_record.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/studentrecord/domain/student_record.dart';
import 'package:sistema_ies/studentrecord/presentation/subject_student_record_details.dart';

class StudentRecordDetailsPage extends ConsumerWidget {
  const StudentRecordDetailsPage({Key? key, required this.studentRecord})
      : super(key: key);
  final StudentRecord studentRecord;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
        child: ListView.builder(
            itemCount: studentRecord.subjects.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => studentRecord
                    .subjects[index].movements.isNotEmpty
                ? Container(
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
                        color: selectColorByState(
                            studentRecord.subjects[index].movements[0]),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10))),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          title: Text(
                            studentRecord.subjects[index].name,
                          ),
                          onTap: () {
                            ref.read(panelStateNotifier.notifier).init(
                                studentRecord.subjects[index].movements.length);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SubjectDetails(
                                        iesUser: IESSystem()
                                            .studentRecordUseCase
                                            .currentIESUser,
                                        subjectSR:
                                            studentRecord.subjects[index],
                                      )),
                            );
                          }),
                    ),
                  )
                : Container()));
  }
}

Color selectColorByState(MovementStudentRecord state) {
  Color color = const Color.fromARGB(255, 255, 255, 255);

  if (state.isApproved == "approved") {
    color = const Color.fromARGB(255, 27, 182, 61);
  } else if (state.isApproved == "regular") {
    color = const Color.fromARGB(255, 81, 126, 240);
  } else if (state.isApproved == "desapproved") {
    color = const Color.fromARGB(255, 182, 27, 27);
  }

  return color;
}
