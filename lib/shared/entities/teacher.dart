import 'package:sistema_ies/shared/entities/course.dart';
import 'package:sistema_ies/shared/entities/users.dart';

class Teacher extends UserRole {
  Course course;
  Teacher({required user, required this.course}) : super(user: user);

  @override
  Enum userRoleName() {
    return UserRoleNames.teacher;
  }
}
