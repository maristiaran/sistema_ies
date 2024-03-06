import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/repositories/repositories.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

abstract class StudentRepositoryPort extends RepositoryPort {
  // This function gets Subjects from a student [required String idUser, required String syllabus]
  Future<Either<Failure, List<Object>>> getSubjects(
      {required String idUser, required String syllabusId});
  // This function gets Student Records [required String idUser, required String syllabus]
  Future<Either<Failure, List<StudentRecordSubject>>> getStudentRecord(
      {required String idUser, required String syllabus});
  // This function gets Movements from a Student Record [required String idUser,required String syllabusId, required int subjectId]
  Future<List<MovementStudentRecord>> getStudentRecordMovements(
      {required String idUser,
      required String syllabusId,
      required int subjectId});

  // This is a function POST to create a new register of Student record in database
  void addStudentRecordMovement(
      {required MovementStudentRecord newMovement,
      required String idUser,
      required String syllabusId,
      required int subjectId});
}
/* class StudenSubject {
  DateTime? dateOfLastRegister;
  DateTime? dateOfLastRegularState;
  DateTime? dateOfLastFinalExam;
  int? timesDisapprovedFinalTest;
} */
