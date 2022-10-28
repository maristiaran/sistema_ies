import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class RolesAndOperationsRepositoryMemoryAdapter
    implements RolesAndOperationsRepositoryPort {
  late Map<UserRoleTypeName, UserRoleType> _cachedUserRoleTypes;
  late Map<UserRoleOperationName, UserRoleOperation> _cachedUserRoleOperations;

  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    _addCachedUserOperation(
        {required UserRoleOperationName userOperationName,
        required String userOperationTitle}) {
      _cachedUserRoleOperations[userOperationName] =
          UserRoleOperation(name: userOperationName, title: userOperationTitle);
    }

    _addCachedUserRoleType(
        {required UserRoleTypeName roleTypeName,
        required String title,
        required List<ParameretizedUserRoleOperation>
            parameterizedOperations}) {
      _cachedUserRoleTypes[roleTypeName] = UserRoleType(
          name: roleTypeName,
          title: title,
          parameterizedOperations: parameterizedOperations);
    }

    _addCachedUserOperation(
        userOperationName: UserRoleOperationName.registerAsIncomingStudent,
        userOperationTitle: 'Inscribirme a carrera');

    _addCachedUserRoleType(
        roleTypeName: UserRoleTypeName.guest,
        title: 'Invitado',
        parameterizedOperations: []);

    return Right(Success('Ok'));
  }

  @override
  UserRoleType getUserRoleType(UserRoleTypeName userRoleName) {
    return _cachedUserRoleTypes[userRoleName]!;
  }
}
