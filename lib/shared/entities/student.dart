import 'package:sistema_ies/shared/entities/course.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/entities/users.dart';

class Student extends UserRole {
  Syllabus syllabus;
  List<Course> courses = [];

  Student({required user, required this.syllabus}) : super(user: user);

  @override
  Enum userRoleName() {
    return UserRoleNames.student;
  }
}
