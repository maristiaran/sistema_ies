import 'package:sistema_ies/core/model/entities/users.dart';

class Manager extends UserRole {
  Manager() : super();

  @override
  Enum userRoleName() {
    return UserRoleNames.manager;
  }
}
