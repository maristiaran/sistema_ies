import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/repositories/repositories.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

enum FailureName { unknown }

abstract class TeachersRepositoryPort extends RepositoryPort {
  // Future<Either<Failure, List<Syllabus>>> getActiveSyllabuses();
  Future<Either<Failure, Success>> pairSubjectTeacher(
      IESUser teacher, Subject subject, DateTime date);
}
