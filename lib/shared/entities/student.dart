import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/entities/users.dart';

class Student extends UserRole {
  late Syllabus syllabus;
  List<Course> courses = [];

  Student({required user, required this.syllabus}) : super(user: user);
}

class Course {
  // Un curso tiene varios procesos
}
