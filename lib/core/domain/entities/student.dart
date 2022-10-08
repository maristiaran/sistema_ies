import 'package:sistema_ies/core/domain/entities/course.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';

class Student extends UserRole {
  Syllabus syllabus;
  List<Course> courses = [];

  Student({required this.syllabus}) : super();

  @override
  Enum userRoleName() {
    return UserRoleNames.student;
  }
}
