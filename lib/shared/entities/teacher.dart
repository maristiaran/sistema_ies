import 'package:sistema_ies/shared/entities/course.dart';
import 'package:sistema_ies/shared/entities/users.dart';

class Teacher extends UserRole {
  List<Course> courses = [];
  Teacher({required user}) : super(user: user);

  @override
  Enum userRoleName() {
    return UserRoleNames.teacher;
  }
}
