import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/repositories/teachers_repository.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class TeachersMemoryRepositoryAdapter implements TeachersRepositoryPort {
  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    return Right(Success("Ok"));
  }

  @override
  Future<Either<Failure, Success>> pairSubjectTeacher(
      IESUser teacher, Subject subject, DateTime date) async {
    return Right(Success("Ok"));
  }
}
