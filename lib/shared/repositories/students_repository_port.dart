import 'package:either_dart/either.dart';
import 'package:sistema_ies/shared/entities/student.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

abstract class StudentsRepositoryPort {
  Either<Failure, Student> getStudent(int idUser, Syllabus idSyllabus);
  Either<Failure, Success> updateStudentEducationalRecord(
      Student student, List<Course> updatedCourses);
}
