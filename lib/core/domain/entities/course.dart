import 'package:sistema_ies/core/domain/entities/users.dart';

class StudentCourseGrade {
  IESUser student;
  double grade;
  bool isPassingGrade;
  StudentCourseGrade(
      {required this.student,
      required this.grade,
      required this.isPassingGrade});
}

class Course {}
