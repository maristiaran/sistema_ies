import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/model/entities/syllabus.dart';
import 'package:sistema_ies/core/model/repositories/repositories.dart';
import 'package:sistema_ies/core/model/utils/responses.dart';

enum FailureName { unknown }

abstract class SyllabusesRepositoryPort extends RepositoryPort {
  Future<Either<Failure, List<Syllabus>>> getActiveSyllabuses();
  Future<Either<Failure, Syllabus>> getSyllabusByAdministrativeResolution(
      {required String administrativeResolution});
}
