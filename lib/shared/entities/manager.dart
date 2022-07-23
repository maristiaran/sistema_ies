import 'package:sistema_ies/shared/entities/users.dart';

class Manager extends UserRole {
  Manager({required user}) : super(user: user);

  @override
  Enum userRoleName() {
    return UserRoleNames.manager;
  }
}
