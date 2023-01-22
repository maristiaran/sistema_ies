import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/repositories/studentrecord_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class StudentFakeDatasource implements StudentRepositoryPort {
  @override
  Future<Either<Failure, List<SubjectSR>>> getStudentRecord(
      {required Student student}) async {
    Syllabus syllabus = student.syllabus;

    List<SubjectSR> srSubjects = [
      for (var i = 1; i <= syllabus.subjectCount(); i++) i
    ]
        .map((x) => SubjectSR(
            subjectId: x, name: syllabus.getSubjectIfAnyByID(x)!.name))
        .toList();

    srSubjects[0].addMovement(MSRFinalExamApproved(
        date: DateTime(2021, 12, 11),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));
    srSubjects[1].addMovement(MSRFinalExamApproved(
        date: DateTime(2021, 12, 9),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));
    srSubjects[2].addMovement(MSRFinalExamApproved(
        date: DateTime(2021, 12, 9),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));
    srSubjects[3].addMovement(MSRFinalExamApproved(
        date: DateTime(2021, 12, 9),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));
    srSubjects[4].addMovement(MSRFinalExamApproved(
        date: DateTime(2021, 12, 9),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));
    srSubjects[5].addMovement(MSRFinalExamApproved(
        date: DateTime(2021, 12, 9),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));

    srSubjects[6].addMovement(MSRFinalExamApproved(
        date: DateTime(2021, 12, 12),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 36));
    srSubjects[7].addMovement(MSRFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 10,
        certificationResolution: '85CO20'));
    srSubjects[8].addMovement(MSRFinalExamApproved(
        date: DateTime(2020, 8, 3),
        numericalGrade: 10,
        bookNumber: 1,
        pageNumber: 1));
    srSubjects[9].addMovement(MSRFinalExamApproved(
        date: DateTime(2020, 12, 16),
        numericalGrade: 8,
        bookNumber: 1,
        pageNumber: 9));

    srSubjects[10].addMovement(MSRFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 9,
        certificationResolution: '85CO20'));

    srSubjects[11].addMovement(MSRFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 9,
        certificationResolution: '85CO20'));

    srSubjects[12].addMovement(MSRFinalExamApprovedByCertification(
        date: DateTime(2021, 10, 21),
        numericalGrade: 9,
        certificationResolution: '35TI'));
    srSubjects[13].addMovement(MSRFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 10),
        numericalGrade: 8,
        certificationResolution: '85CO20'));
    srSubjects[14].addMovement(MSRFinalExamApprovedByCertification(
        date: DateTime(2021, 12, 3),
        numericalGrade: 10,
        certificationResolution: '34TI'));

    srSubjects[15].addMovement(MSRFinalExamApprovedByCertification(
        date: DateTime(2021, 12, 16),
        numericalGrade: 10,
        certificationResolution: '34TI'));

    return Right(srSubjects);
  }

  @override
  Future<Either<Failure, List<MovementStudentRecord>>>
      getStudentRecordMovements(
          {required String userID,
          required String syllabusID,
          required int subjectID}) async {
    return const Right([]);
  }

  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    return Right(Success('ok'));
  }

  // @override
  // Future<Either<Failure, List<StudentRecord>>> getAllStudentRecord() async {
  //   List<StudentRecord> careers = [];
  //   StudentRecord career2 = StudentRecord(
  //       syllabus: Syllabus(
  //           name: "Tecnicatura Superior en Desarrollo de Software",
  //           administrativeResolution: "501-DGE-19"));
  //   StudentRecord career1 = StudentRecord(
  //       syllabus: Syllabus(
  //           name: "Tecnicatura Superior en Computación y Redes",
  //           administrativeResolution: "490-DGE-19"));

  //   SubjectSR subjectCyR1 = SubjectSR(name: "Redes I");
  //   SubjectSR subjectCyR2 = SubjectSR(name: "Sistemas Operativos I");
  //   SubjectSR subjectCyR3 = SubjectSR(name: "Práctica profesionalizante I");

  //   SubjectSR subjectSof1 = SubjectSR(name: "Programación I");
  //   SubjectSR subjectSof2 = SubjectSR(name: "Base de datos I");
  //   SubjectSR subjectSof3 = SubjectSR(name: "Práctica profesionalizante I");

  //   subjectSof1.addMovementsToSubject(
  //       MovementStudentRecord(nota: "4", year: '2022', isApproved: "regular"));
  //   subjectSof1.addMovementsToSubject(
  //       MovementStudentRecord(nota: "8", year: '2021', isApproved: "approved"));
  //   subjectSof2.addMovementsToSubject(MovementStudentRecord(
  //       nota: "10", year: '2022', isApproved: "approved"));
  //   subjectSof3.addMovementsToSubject(MovementStudentRecord(
  //       nota: "3", year: '2022', isApproved: "desapproved"));
  //   subjectCyR1.addMovementsToSubject(
  //       MovementStudentRecord(nota: "5", year: '2020', isApproved: "regular"));
  //   subjectCyR2.addMovementsToSubject(MovementStudentRecord(
  //       nota: "10", year: '2020', isApproved: "approved"));
  //   subjectCyR3.addMovementsToSubject(MovementStudentRecord(
  //       nota: "2", year: '2020', isApproved: "desapproved"));

  //   career1.addSubjects(subjectSof1);
  //   career1.addSubjects(subjectSof2);
  //   career1.addSubjects(subjectSof3);
  //   career2.addSubjects(subjectCyR1);
  //   career2.addSubjects(subjectCyR2);
  //   career2.addSubjects(subjectCyR3);

  //   careers.add(career1);
  //   careers.add(career2);
  //   return Right(careers);
  // }
}
