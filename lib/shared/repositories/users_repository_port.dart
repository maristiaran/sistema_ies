import 'package:either_dart/either.dart';
import 'package:sistema_ies/shared/entities/user_role_operation.dart';
import 'package:sistema_ies/shared/entities/users.dart';
import 'package:sistema_ies/shared/repositories/repositories.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

enum UsersRepositoryFailureName {
  unknown,
  wrongUsernameOrPassword,
  notVerifiedEmail,
  cantResetPassword,
  cantSentVerificationEmail,
  userExists,
}

abstract class UsersRepositoryPort extends RepositoryPort {
  Future<bool> getCurrentUserIsEMailVerified();
  Future<Either<Failure, IESUser>> getIESUserByID({required String idUser});
  Future<Either<Failure, IESUser>> getIESUserByDNI({required int dni});
  Future<Either<Failure, IESUser>> getIESUserByEmail({required String email});
  Future<Either<Failure, Success>> resetPasswordEmail({required String email});
  // Future<Either<Failure, String>> getUserEmail({required int dni});
  Future<Either<Failure, IESUser>> signInUsingEmailAndPassword(
      {String email, String password});
  Future<Either<Failure, IESUser>> registerNewIESUser(
      {required String email,
      required String password,
      required int dni,
      required String firstname,
      required String surname,
      required DateTime birthdate});
  reSendEmailVerification();
  Future<Either<Failure, List<UserRole>>> getUserRoles({IESUser user});
  Future<Either<Failure, List<UserRoleOperation>>> getUserRoleOperations(
      {UserRole userRole});

  Future<Either<Failure, Success>> addUserRole(
      {required IESUser user, required UserRole userRole});

  Future<Either<Failure, Success>> removeUserRole(
      {required IESUser user, required UserRole userRole});
}
