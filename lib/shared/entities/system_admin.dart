import 'package:sistema_ies/shared/entities/users.dart';

class SystemAdmin extends UserRole {
  SystemAdmin({required user}) : super(user: user);

  @override
  Enum userRoleName() {
    return UserRoleNames.systemAdmin;
  }
}
