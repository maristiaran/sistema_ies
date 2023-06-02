import 'package:sistema_ies/checkStudentRecord/domain/check_student_record.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';

List<SubjectItemCard> generateSubjectItems(List<StudentRecordSubject> subjects) {
  List<SubjectItemCard> result = [];
  for (var i = 0; i < subjects.length; i++) {
    result.add(SubjectItemCard(subjectSR: subjects[i]));
  }
  return result;
}
