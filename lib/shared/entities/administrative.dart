import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/entities/users.dart';

class Administrative extends UserRole {
  Syllabus syllabus;

  Administrative({required user, required this.syllabus}) : super(user: user);

  @override
  Enum userRoleName() {
    return UserRoleNames.administrative;
  }
}
