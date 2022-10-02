import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/model/entities/course.dart';
import 'package:sistema_ies/core/model/entities/student.dart';
import 'package:sistema_ies/core/model/entities/syllabus.dart';
import 'package:sistema_ies/core/model/repositories/students_repository_port.dart';
import 'package:sistema_ies/core/model/utils/responses.dart';

class FakeStudentsRepositoryAdapter implements StudentsRepositoryPort {
  // @override
  // Future<Either<Failure, Success>> initRepositoryCaches() async {
  //   return Right(Success('ok'));
  // }

  @override
  Either<Failure, Student> getStudent(int idUser, Syllabus idSyllabus) {
    return Left(Failure(failureName: FailureName.unknown));
  }

  @override
  Either<Failure, Success> updateStudentEducationalRecord(
      Student student, List<Course> updatedCourses) {
    return Left(Failure(failureName: FailureName.unknown));
  }
}
