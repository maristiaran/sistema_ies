import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/entities/users.dart';

class Student extends UserRole {
  late Syllabus syllabus;
  List<Course> courses = [];

  Student({required this.syllabus});
}

class Course {}
