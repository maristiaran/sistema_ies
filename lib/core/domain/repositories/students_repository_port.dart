import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/course.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/repositories/repositories.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

enum FailureName { unknown }

abstract class StudentsRepositoryPort extends RepositoryPort {
  Either<Failure, Student> getStudent(int idUser, Syllabus idSyllabus);
  Either<Failure, Success> updateStudentEducationalRecord(
      Student student, List<Course> updatedCourses);
}
