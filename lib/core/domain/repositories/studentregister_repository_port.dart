import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
// import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/repositories/repositories.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

enum FailureName { unknown }

abstract class StudentsRepositoryPort extends RepositoryPort {
  // Future<Either<Failure, List<Syllabus>>> getActiveSyllabuses();
  Future<Either<Failure, List<StudentRecordSubject>>> getStudentRecord(
      {required String idUser, required String syllabus});
  Future<List<MovementStudentRecord>> getStudentMovements(
      {required String idUser,
      required String syllabusId,
      required int subjectId});
  Future<Either<Failure, List>> getRegistersForExam(
      {required String idUser, required String syllabus});

  Future<Either<Failure, Success>> setRegistersForExam(
      {required String idUser,
      required String syllabus,
      required List registereds});
}
