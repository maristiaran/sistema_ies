import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/student_record.dart';
import 'package:sistema_ies/core/domain/repositories/studentrecord_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class StudentRecordFakeDatasource implements StudentRecordRepositoryPort {
  @override
  Future<Either<Failure, StudentRecord>> getStudentRecord() async {
    return Right(StudentRecord(name: "Brian"));
  }

  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    return Right(Success('ok'));
  }

  @override
  Future<Either<Failure, List<StudentRecord>>> getAllStudentRecord() async {
    List<StudentRecord> careers = [];
    StudentRecord career2 = StudentRecord(name: "Computacion y redes");
    StudentRecord career1 = StudentRecord(name: "Desarrollo de software");

    SubjectSR subjectCyR1 = SubjectSR(name: "Redes I");
    SubjectSR subjectCyR2 = SubjectSR(name: "Sistemas Operativos I");
    SubjectSR subjectCyR3 = SubjectSR(name: "Práctica profesionalizante I");

    SubjectSR subjectSof1 = SubjectSR(name: "Programación I");
    SubjectSR subjectSof2 = SubjectSR(name: "Base de datos I");
    SubjectSR subjectSof3 = SubjectSR(name: "Práctica profesionalizante I");

    subjectSof1.addMovementsToSubject(
        MovementStudentRecord(nota: "4", year: '2022', isApproved: "regular"));
    subjectSof1.addMovementsToSubject(
        MovementStudentRecord(nota: "8", year: '2021', isApproved: "approved"));
    subjectSof2.addMovementsToSubject(MovementStudentRecord(
        nota: "10", year: '2022', isApproved: "approved"));
    subjectSof3.addMovementsToSubject(MovementStudentRecord(
        nota: "3", year: '2022', isApproved: "desapproved"));
    subjectCyR1.addMovementsToSubject(
        MovementStudentRecord(nota: "5", year: '2020', isApproved: "regular"));
    subjectCyR2.addMovementsToSubject(MovementStudentRecord(
        nota: "10", year: '2020', isApproved: "approved"));
    subjectCyR3.addMovementsToSubject(MovementStudentRecord(
        nota: "2", year: '2020', isApproved: "desapproved"));

    career1.addSubjects(subjectSof1);
    career1.addSubjects(subjectSof2);
    career1.addSubjects(subjectSof3);
    career2.addSubjects(subjectCyR1);
    career2.addSubjects(subjectCyR2);
    career2.addSubjects(subjectCyR3);

    careers.add(career1);
    careers.add(career2);
    return Right(careers);
  }
}
