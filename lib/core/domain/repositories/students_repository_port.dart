import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/course.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/repositories/repositories.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

enum FailureName { unknown }

abstract class StudentsRepositoryPort extends RepositoryPort {
  // Either<Failure, IESUser> getStudent(int idUser, Syllabus idSyllabus);
  Either<Failure, Success> updateStudentEducationalRecord(
      IESUser student, Syllabus syllabus, List<Course> updatedCourses);
}
