import 'package:either_dart/either.dart';
import 'package:sistema_ies/shared/entities/student.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/repositories/students_repository_port.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

class FakeStudentsRepositoryAdapter implements StudentsRepositoryPort {
  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    return Right(Success('ok'));
  }

  @override
  Either<Failure, Student> getStudent(int idUser, Syllabus idSyllabus) {
    return Left(Failure(''));
  }

  @override
  Either<Failure, Success> updateStudentEducationalRecord(
      Student student, List<Course> updatedCourses) {
    return Left(Failure(''));
  }
}
