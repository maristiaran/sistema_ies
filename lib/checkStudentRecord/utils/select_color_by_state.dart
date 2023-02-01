import 'package:flutter/cupertino.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';

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
