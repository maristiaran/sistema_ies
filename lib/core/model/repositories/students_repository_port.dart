import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/model/entities/course.dart';
import 'package:sistema_ies/core/model/entities/student.dart';
import 'package:sistema_ies/core/model/entities/syllabus.dart';
import 'package:sistema_ies/core/model/repositories/repositories.dart';
import 'package:sistema_ies/core/model/utils/responses.dart';

enum FailureName { unknown }

abstract class StudentsRepositoryPort extends RepositoryPort {
  Either<Failure, Student> getStudent(int idUser, Syllabus idSyllabus);
  Either<Failure, Success> updateStudentEducationalRecord(
      Student student, List<Course> updatedCourses);
}
