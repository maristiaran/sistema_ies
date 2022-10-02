import 'package:sistema_ies/core/model/entities/course.dart';
import 'package:sistema_ies/core/model/entities/syllabus.dart';
import 'package:sistema_ies/core/model/entities/users.dart';

class Student extends UserRole {
  Syllabus syllabus;
  List<Course> courses = [];

  Student({required this.syllabus}) : super();

  @override
  Enum userRoleName() {
    return UserRoleNames.student;
  }
}
