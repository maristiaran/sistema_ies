import 'package:sistema_ies/core/domain/entities/student.dart';

List<SubjectSR> filterSubjectsWhereThereAreMovements(List<SubjectSR> subjects) {
  final List<SubjectSR> subjectsFilter = [];
  for (var element in subjects) {
    if (element.movements.isNotEmpty) {
      subjectsFilter.add(element);
    }
  }
  return subjectsFilter;
}
