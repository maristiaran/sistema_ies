import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
// import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/repositories/repositories.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

abstract class StudentRepositoryPort extends RepositoryPort {
  // Future<Either<Failure, StudentRecord>> getStudentRecord();
  Future<Either<Failure, List<StudentRecordSubject>>> getStudentRecord(
      {required String idUser, required String syllabus});
  Future<List<MovementStudentRecord>> getStudentRecordMovements(
      {required String idUser,
      required String syllabusId,
      required int subjectId});
}
