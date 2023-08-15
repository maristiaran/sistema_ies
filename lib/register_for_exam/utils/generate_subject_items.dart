import 'package:sistema_ies/register_for_exam/domain/register_for_exam.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';

List<SubjectICard> genSubjectItems(List<StudentRecordSubject> subjects) {
  List<SubjectICard> result = [];
  for (var i = 0; i < subjects.length; i++) {
    result.add(SubjectICard(subjectSR: subjects[i]));
  }
  return result;
}
