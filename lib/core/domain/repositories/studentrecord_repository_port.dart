import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
// import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/repositories/repositories.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

abstract class StudentRepositoryPort extends RepositoryPort {
  // Future<Either<Failure, StudentRecord>> getStudentRecord();
  Future<Either<Failure, List<SubjectSR>>> getStudentRecord(
      {required Student student});
  Future<Either<Failure, List<MovementStudentRecord>>>
      getStudentRecordMovements(
          {required String userID,
          required String syllabusID,
          required int subjectID});

  // Future<Either<Failure, List<StudentRecord>>> getAllStudentRecord();
}
