import 'package:either_dart/either.dart';
import 'package:sistema_ies/secondary_adapters/repositories_adapters/students_fake_repository_adapter.dart';
import 'package:sistema_ies/shared/entities/student.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/repositories/students_repository_port.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

FakeStudentsRepositoryAdapter currentStudentsRepositoryAdapter =
    FakeStudentsRepositoryAdapter();

class StudentsRepository implements StudentsRepositoryPort {
  @override
  Either<Failure, Student> getStudent(int idUser, Syllabus syllabus) {
    return currentStudentsRepositoryAdapter.getStudent(idUser, syllabus);
  }

  @override
  Either<Failure, Success> updateStudentEducationalRecord(
      Student student, List<Course> updatedCourses) {
    return currentStudentsRepositoryAdapter.updateStudentEducationalRecord(
        student, updatedCourses);
  }
}

abstract class UsersRepositoryPort {
  Either<Failure, Student> getUser(int idUser);
}
