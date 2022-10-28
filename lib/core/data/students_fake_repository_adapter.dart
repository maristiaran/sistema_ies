import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/course.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/repositories/students_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class FakeStudentsRepositoryAdapter implements StudentsRepositoryPort {
  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    return Right(Success('ok'));
  }

  // @override
  // Either<Failure, Student> getStudent(int idUser, Syllabus idSyllabus) {
  //   return Left(Failure(failureName: FailureName.unknown));
  // }

  // @override
  // Either<Failure, Success> updateStudentEducationalRecord(
  //     Student student, List<Course> updatedCourses) {
  //   return Left(Failure(failureName: FailureName.unknown));
  // }

  @override
  Either<Failure, Success> updateStudentEducationalRecord(
      IESUser student, Syllabus syllabus, List<Course> updatedCourses) {
    return Left(Failure(failureName: FailureName.unknown));
  }
}
