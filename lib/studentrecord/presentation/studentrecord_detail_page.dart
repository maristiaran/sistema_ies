import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student_record.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
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
            itemBuilder: (context, index) => ListTile(
                title: Text(
                  studentRecord.subjects[index].name,
                ),
                onTap: () {
                  ref.read(todosProvider.notifier).remove();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SubjectDetails(
                              iesUser: IESSystem()
                                  .studentRecordUseCase
                                  .currentIESUser,
                              subjectSR: studentRecord.subjects[index],
                            )),
                  );
                })));
  }
}
