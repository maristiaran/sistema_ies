import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/exam_table.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/repositories/examtables_repository.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class ExamTablesRepositoryFirestoreAdapter implements ExamTablesRepositoryPort {
  @override
  Future<Either<Failure, List<ExamTable>>> getLastCallExamTablesOfTeacher(
      Teacher teacher) async {
    return const Right([]);
  }

  @override
  Future<Either<Failure, List<ExamTable>>> getLastCallExamTablesOfStudent(
      Student student) async {
    return const Right([]);
  }

  @override
  initRepositoryCaches() {
    // TODO: implement initRepositoryCaches
    throw UnimplementedError();
  }
}
