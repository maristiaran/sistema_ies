import 'package:sistema_ies/core/domain/entities/users.dart';

class Manager extends UserRole {
  Manager() : super();

  @override
  Enum userRoleName() {
    return UserRoleNames.manager;
  }
}
