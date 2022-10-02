import 'package:sistema_ies/core/model/entities/course.dart';
import 'package:sistema_ies/core/model/entities/users.dart';

class Teacher extends UserRole {
  Course course;
  Teacher({required this.course}) : super();

  @override
  Enum userRoleName() {
    return UserRoleNames.teacher;
  }
}
