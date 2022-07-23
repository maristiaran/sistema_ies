import 'package:sistema_ies/shared/entities/course.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/entities/users.dart';

class Student extends UserRole {
  late List<Syllabus> syllabuses;
  List<Course> courses = [];

  Student({required user}) : super(user: user);

  @override
  Enum userRoleName() {
    return UserRoleNames.student;
  }
}
