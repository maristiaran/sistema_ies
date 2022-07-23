import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/entities/users.dart';

class Administrative extends UserRole {
  List<Syllabus> syllabuses = [];

  Administrative({required user}) : super(user: user);

  @override
  Enum userRoleName() {
    return UserRoleNames.administrative;
  }
}
