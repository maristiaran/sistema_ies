import 'package:either_dart/either.dart';
import 'package:sistema_ies/shared/entities/users.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

abstract class UsersRepositoryPort {
  Either<Failure, User> getUser(int idUser);
}
