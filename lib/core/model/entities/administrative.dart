import 'package:sistema_ies/core/model/entities/syllabus.dart';
import 'package:sistema_ies/core/model/entities/users.dart';

class Administrative extends UserRole {
  Syllabus syllabus;

  Administrative({required this.syllabus}) : super();

  @override
  Enum userRoleName() {
    return UserRoleNames.administrative;
  }
}
