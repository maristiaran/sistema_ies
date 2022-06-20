import 'package:either_dart/either.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/repositories/repositories.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

abstract class SyllabusesRepositoryPort extends RepositoryPort {
  Future<Either<Failure, List<Syllabus>>> getActiveSyllabuses();
}
