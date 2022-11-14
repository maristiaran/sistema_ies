import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/student_record.dart';
import 'package:sistema_ies/core/domain/repositories/repositories.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

abstract class StudentRecordRepositoryPort extends RepositoryPort {
  Future<Either<Failure, StudentRecord>> getStudentRecord();
  Future<Either<Failure, List<StudentRecord>>> getAllStudentRecord();
}
