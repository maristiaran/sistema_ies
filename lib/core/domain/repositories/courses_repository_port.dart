import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/course.dart';
import 'package:sistema_ies/core/domain/repositories/repositories.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

enum FailureName { unknown }

abstract class CoursesRepositoryPort extends RepositoryPort {
  Future<Either<Failure, Success>> registerInCourse(
      syllabus, year, subject, student, asFreeStudent);

  Future<Either<Failure, Success>> registerCourseGrade(
      syllabus, year, subject, studentCourseGrades);

  Future<List<StudentCourseGrade>> studentsCourseGrades(
      syllabus, year, subject);
}
