import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/repositories/repositories.dart';

abstract class RolesAndOperationsRepositoryPort extends RepositoryPort {
  UserRoleType getUserRoleType(UserRoleTypeName userRoleName);
  List<UserRoleOperation> getUserRoleOperations(
      UserRoleTypeName userRoleOperation);
}
