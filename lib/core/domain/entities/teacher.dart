import 'package:sistema_ies/core/domain/entities/course.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';

class Teacher extends UserRole {
  Course course;
  Teacher({required this.course}) : super();

  @override
  Enum userRoleName() {
    return UserRoleNames.teacher;
  }
}
