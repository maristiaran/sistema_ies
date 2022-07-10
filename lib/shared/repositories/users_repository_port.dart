import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/entities/users.dart';
import 'package:sistema_ies/shared/repositories/repositories.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

enum FailureName { unknown, wrongUsernameOrPassword, notVerifiedEmail }

abstract class UsersRepositoryPort extends RepositoryPort {
  Future<bool> getCurrentUserIsEMailVerified();
  Future<Either<Failure, String>> getUserEmail({required int dni});
  Future<Either<Failure, IESUser>> signInUsingEmailAndPassword(
      {String email, String password});
  Future<Either<Failure, User>> registerIncomingStudent(
      {required String email,
      required String password,
      required int dni,
      required String firstname,
      required String surname,
      required Syllabus syllabus});
  reSendEmailVerification();
  Future<Either<Failure, List<UserRole>>> getUserRoles({IESUser user});
  Future<Either<Failure, List<UserRoleOperation>>> getUserRoleOperations(
      {UserRole userRole});
}
