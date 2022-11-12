import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/repositories/studentrecord_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class StudentRecordFakeDatasource implements StudentRecordRepositoryPort {
  @override
  Future<Either<Failure, StudentRecord>> getStudentRecord(
      currentIESUser, syllabusId) async {
    return Right(StudentRecord(name: "Brian"));
  }

  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    return Right(Success('ok'));
  }

  @override
  Future<Either<Failure, List<StudentRecord>>> getAllStudentRecord() async {
    List<StudentRecord> careers = [
      StudentRecord(name: "Computacion y redes"),
      StudentRecord(name: "Desarrollo de software")
    ];
    return Right(careers);
  }
}
