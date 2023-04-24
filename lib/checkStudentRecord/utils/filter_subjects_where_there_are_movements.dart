import 'package:sistema_ies/checkStudentRecord/domain/check_student_record.dart';

List<SubjectItemCard> filterSubjectsWhereThereAreMovements(
    List<SubjectItemCard> subjects) {
  final List<SubjectItemCard> subjectsFilter = [];
  for (var element in subjects) {
    if (element.subjectSR.movements.isNotEmpty) {
      subjectsFilter.add(element);
    }
  }
  return subjectsFilter;
}
