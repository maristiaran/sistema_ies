import 'package:flutter/cupertino.dart';
import 'package:sistema_ies/checkStudentRecord/domain/check_student_record.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';

Color selectColorByState(SubjectItemCard subjects) {
  Color color = const Color.fromARGB(255, 163, 163, 163);
  if (subjects.subjectSR.subjectState == SubjetState.approved) {
    color = const Color.fromARGB(255, 27, 182, 61);
  } else if (subjects.subjectSR.subjectState == SubjetState.regular) {
    color = const Color.fromARGB(255, 81, 126, 240);
  } else if (subjects.subjectSR.subjectState == SubjetState.coursing) {
    color = const Color.fromARGB(255, 240, 232, 81);
  } else if (subjects.subjectSR.subjectState == SubjetState.dessaproved) {
    color = const Color.fromARGB(255, 182, 27, 27);
  }
  return color;
}
