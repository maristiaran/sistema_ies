import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/repositories/studentrecord_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class StudentBarquesiFakeDatasource implements StudentRepositoryPort {
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

    srSubjects[0].addMovCourseFailedFree(
      date: DateTime(2021, 12, 11),
    );
    srSubjects[1].addMovCourseRegistering(
      date: DateTime(2021, 12, 9),
    );

    // -------------PRIMERO--------------
    // ------Programacion 1
    srSubjects[0].addMovCourseRegistering(date: DateTime(2020, 3, 21));
    srSubjects[0].addMovCourseApproved(date: DateTime(2020, 11, 1));
    srSubjects[0].addMovFinalExamApproved(
        date: DateTime(2021, 12, 10),
        numericalGrade: 10,
        pageNumber: 1,
        bookNumber: 36);
// ------Arquitectura de las computadoras
    srSubjects[1].addMovFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 10,
        pageNumber: 85,
        bookNumber: 3,
        certificationResolution: '85CO20');
    // ------Requerimientos de software
    srSubjects[2].addMovCourseRegistering(date: DateTime(2020, 3, 21));
    srSubjects[2].addMovCourseApproved(date: DateTime(2020, 6, 28));

    srSubjects[2].addMovFinalExamApproved(
        date: DateTime(2020, 8, 3),
        numericalGrade: 10,
        pageNumber: 1,
        bookNumber: 1);
    // ------Algebra
    srSubjects[3].addMovCourseRegistering(date: DateTime(2020, 3, 21));
    srSubjects[3].addMovCourseApproved(date: DateTime(2020, 11, 1));
    srSubjects[3].addMovFinalExamApproved(
        date: DateTime(2020, 12, 16),
        numericalGrade: 8,
        pageNumber: 9,
        bookNumber: 1);
    // ------Ingles técnico I
    srSubjects[4].addMovFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 9,
        pageNumber: 85,
        bookNumber: 3,
        certificationResolution: '85CO20');
// ------Comprension y produccion de textos
    srSubjects[5].addMovFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 9,
        pageNumber: 85,
        bookNumber: 3,
        certificationResolution: '85CO20');
// ------Logica computacional
    srSubjects[6].addMovCourseRegistering(date: DateTime(2020, 3, 21));
    srSubjects[6].addMovCourseApproved(date: DateTime(2020, 11, 1));

    srSubjects[6].addMovFinalExamApproved(
        date: DateTime(2021, 12, 10),
        numericalGrade: 9,
        pageNumber: 35,
        bookNumber: 1);
// ------Problematica sociocultural y de contexto
    srSubjects[7].addMovFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 8,
        pageNumber: 85,
        bookNumber: 3,
        certificationResolution: '85CO20');
// ------Sistemas administrativos aplicados
    srSubjects[8].addMovCourseRegistering(date: DateTime(2020, 3, 21));
    srSubjects[8].addMovCourseApproved(date: DateTime(2020, 11, 1));

    srSubjects[8].addMovFinalExamApproved(
        date: DateTime(2021, 12, 3),
        numericalGrade: 10,
        pageNumber: 34,
        bookNumber: 1);
// ------Practica profesionalizante I
    srSubjects[9].addMovCourseRegistering(date: DateTime(2020, 3, 21));
    srSubjects[9].addMovCourseApproved(date: DateTime(2020, 11, 1));

    srSubjects[9].addMovFinalExamApproved(
        date: DateTime(2021, 12, 16),
        numericalGrade: 10,
        pageNumber: 37,
        bookNumber: 1);
//SEGUNDO

// ------Comunicaciones y redes
    srSubjects[10].addMovFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 8,
        pageNumber: 85,
        bookNumber: 3,
        certificationResolution: '85CO20');
    // ------Programacion 2
    srSubjects[11].addMovCourseRegistering(date: DateTime(2021, 3, 15));
    srSubjects[11].addMovCourseApproved(date: DateTime(2021, 11, 1));
    srSubjects[11].addMovFinalExamApproved(
        date: DateTime(2022, 11, 23),
        numericalGrade: 10,
        pageNumber: 62,
        bookNumber: 1);
// ------Matematica discreta
    srSubjects[12].addMovCourseRegistering(date: DateTime(2021, 3, 15));
    srSubjects[12].addMovCourseApproved(date: DateTime(2021, 11, 1));

    srSubjects[12].addMovFinalExamApproved(
        date: DateTime(2021, 9, 24),
        numericalGrade: 4,
        pageNumber: 22,
        bookNumber: 1);
// ------Analisis matemático
    srSubjects[13].addMovCourseRegistering(date: DateTime(2021, 3, 15));
    srSubjects[13].addMovCourseApproved(date: DateTime(2021, 11, 1));
    srSubjects[13].addMovFinalExamNonApproved(
        date: DateTime(2021, 11, 29), numericalGrade: 2);
    srSubjects[13].addMovFinalExamApproved(
        date: DateTime(2021, 12, 3),
        numericalGrade: 9,
        pageNumber: 32,
        bookNumber: 1);
    // ------Ingles técnico II

    srSubjects[14].addMovFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 7,
        pageNumber: 85,
        bookNumber: 3,
        certificationResolution: '85CO20');
    // ------Modelado de software
    srSubjects[15].addMovCourseRegistering(date: DateTime(2021, 3, 15));
    srSubjects[15].addMovFinalExamApproved(
        date: DateTime(2022, 12, 15),
        numericalGrade: 10,
        pageNumber: 88,
        bookNumber: 1);
    // ------Base de datos I (Inventado)
    srSubjects[16].addMovCourseRegistering(date: DateTime(2021, 3, 15));
    srSubjects[16].addMovCourseApproved(date: DateTime(2021, 10, 24));
    srSubjects[16].addMovFinalExamApproved(
        date: DateTime(2023, 12, 15),
        numericalGrade: 10,
        pageNumber: 100,
        bookNumber: 1);
    // ------Sistemas operativos
    srSubjects[17].addMovFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 9,
        pageNumber: 85,
        bookNumber: 3,
        certificationResolution: '85CO20');
    // ------Practica profesionalizante II
    srSubjects[18].addMovCourseRegistering(date: DateTime(2021, 3, 15));
    srSubjects[18].addMovCourseApproved(date: DateTime(2021, 10, 29));
    srSubjects[18].addMovFinalExamApproved(
        date: DateTime(2022, 12, 15),
        numericalGrade: 10,
        pageNumber: 89,
        bookNumber: 1);
    // TERCERO
    // ------Programacion 3
    srSubjects[19].addMovCourseRegistering(date: DateTime(2022, 3, 25));
    srSubjects[19].addMovCourseApproved(date: DateTime(2022, 10, 29));
    srSubjects[19].addMovFinalExamNonApproved(
        date: DateTime(2023, 2, 28), numericalGrade: 2);
    srSubjects[19].addMovFinalExamApproved(
        date: DateTime(2023, 11, 23),
        numericalGrade: 10,
        pageNumber: 113,
        bookNumber: 1);
    // ------Arquitectura y diseño de interfaces
    srSubjects[20].addMovCourseRegistering(date: DateTime(2022, 3, 25));
    srSubjects[20].addMovCourseApproved(date: DateTime(2022, 10, 26));
    srSubjects[20].addMovFinalExamApproved(
        date: DateTime(2023, 12, 15),
        numericalGrade: 10,
        pageNumber: 106,
        bookNumber: 1);
    // ------Auditoria de sistemas (Inventado)
    srSubjects[19].addMovCourseRegistering(date: DateTime(2022, 3, 25));
    srSubjects[20].addMovCourseApproved(date: DateTime(2022, 11, 2));
    srSubjects[21].addMovFinalExamApproved(
        date: DateTime(2023, 12, 15),
        numericalGrade: 8,
        pageNumber: 107,
        bookNumber: 1);
    // ------Seguridad informática

    srSubjects[22].addMovFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 10,
        pageNumber: 85,
        bookNumber: 3,
        certificationResolution: '85CO20');
    // ------Ingles tecnico III
    srSubjects[23].addMovCourseRegistering(date: DateTime(2022, 3, 25));
    srSubjects[23].addMovCourseApproved(date: DateTime(2022, 11, 4));
    srSubjects[23].addMovFinalExamApproved(
        date: DateTime(2022, 12, 2),
        numericalGrade: 10,
        pageNumber: 1,
        bookNumber: 83);
    // ------Base de datos II
    srSubjects[24].addMovCourseRegistering(date: DateTime(2022, 3, 25));
    srSubjects[24].addMovCourseApproved(date: DateTime(2022, 11, 5));
    srSubjects[24].addMovFinalExamApproved(
        date: DateTime(2022, 12, 14),
        numericalGrade: 10,
        pageNumber: 86,
        bookNumber: 1);
// ------Probabilidades y estadistica
    srSubjects[25].addMovCourseRegistering(date: DateTime(2022, 3, 25));
    srSubjects[25].addMovCourseFailedNonFree(date: DateTime(2022, 8, 20));
    srSubjects[25].addMovCourseRegistering(date: DateTime(2023, 3, 15));
    srSubjects[24].addMovCourseApproved(date: DateTime(2023, 11, 5));
    srSubjects[25].addMovFinalExamApproved(
        date: DateTime(2023, 12, 4),
        numericalGrade: 9,
        pageNumber: 107,
        bookNumber: 1);
// ------Legislación informática
    srSubjects[26].addMovFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 10,
        pageNumber: 85,
        bookNumber: 3,
        certificationResolution: '85CO20');
// ------Etica profesional
    srSubjects[27].addMovFinalExamApprovedByCertification(
        date: DateTime(2020, 12, 9),
        numericalGrade: 8,
        pageNumber: 85,
        bookNumber: 3,
        certificationResolution: '85CO20');
    // ------Gestion de proyectos de software
    srSubjects[28].addMovCourseRegistering(date: DateTime(2022, 3, 25));
    srSubjects[28].addMovCourseFailedNonFree(date: DateTime(2022, 9, 20));
    srSubjects[28].addMovCourseRegistering(date: DateTime(2023, 3, 15));
    srSubjects[28].addMovCourseApproved(date: DateTime(2023, 10, 25));
    srSubjects[28].addMovFinalExamApproved(
        date: DateTime(2023, 11, 4),
        numericalGrade: 9,
        pageNumber: 112,
        bookNumber: 1);
    // ------Practica profesionalizante III
    srSubjects[29].addMovCourseRegistering(date: DateTime(2022, 3, 25));
    srSubjects[29].addMovCourseApproved(date: DateTime(2022, 10, 28));
    srSubjects[29].addMovFinalExamApproved(
        date: DateTime(2023, 3, 15),
        numericalGrade: 10,
        pageNumber: 125,
        bookNumber: 1);

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
