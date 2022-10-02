import 'package:sistema_ies/core/model/entities/users.dart';

class SystemAdmin extends UserRole {
  SystemAdmin() : super();

  @override
  Enum userRoleName() {
    return UserRoleNames.systemAdmin;
  }
}
