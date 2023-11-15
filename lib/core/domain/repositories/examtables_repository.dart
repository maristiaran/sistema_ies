import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/exam_table.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/repositories/repositories.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

abstract class ExamTablesRepositoryPort extends RepositoryPort {
  Future<Either<Failure, List<ExamTable>>> getLastCallExamTablesOfTeacher(
      Teacher teacher);
  Future<Either<Failure, List<ExamTable>>> getLastCallExamTablesOfStudent(
      Student student);
}
