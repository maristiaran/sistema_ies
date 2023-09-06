import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
import 'package:sistema_ies/core/data/utils/string_to_movement_name.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/repositories/studentregister_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';
import 'package:sistema_ies/register_for_exam/domain/register_for_exam.dart';

import '../domain/utils/datetime.dart';

class StudentsRegister implements StudentsRepositoryPort {
  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    return Right(Success('ok'));
  }

  Future<String> getSyllabusId(
      {required String idUser, required String syllabus}) async {
    return firestoreInstance
        .collection("iesUsers")
        .doc(idUser)
        .collection('roles')
        .where("syllabus", isEqualTo: syllabus)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          return docSnapshot.id;
        }
        return "";
      },
      onError: (e) => {print("Error completing: $e")},
    );
  }

  Future<String> getSubjectId(
      {required String userID,
      required String syllabusID,
      required int subjectID}) async {
    return firestoreInstance
        .collection("iesUsers")
        .doc(userID)
        .collection('roles')
        .doc(syllabusID)
        .collection("subjects")
        .where("id", isEqualTo: subjectID)
        .get()
        .then(
      (querySnapshot) {
        for (var docSnapshot in querySnapshot.docs) {
          return docSnapshot.id;
        }
        return "";
      },
      onError: (e) => {print("Error completing: $e")},
    );
  }

  @override
  Future<Either<Failure, List<StudentRecordSubject>>> getStudentRecord(
      {required String idUser, required String syllabus}) async {
    List<StudentRecordSubject> srSubjects = [];
    // GET syllabus ID
    Future<String> syllabusId =
        getSyllabusId(idUser: idUser, syllabus: syllabus);
// GET student records
    List<Map<String, dynamic>> studentRecordsDocs = ((await firestoreInstance
            .collection("iesUsers")
            .doc(idUser)
            .collection('roles')
            .doc(await syllabusId)
            .collection("subjects")
            .get())
        .docs
        .map((e) => e.data())
        .toList());
    srSubjects = studentRecordsDocs
        .map((e) => StudentRecordSubject(subjectId: e['id'], name: "name"))
        .toList();
    // Get student record movements
    /* for (var studentRecord in srSubjects) {
      List<MovementStudentRecord> movements = await getStudentRecordMovements(
          idUser: idUser,
          subjectId: studentRecord.subjectId,
          syllabusId: syllabus);
      studentRecord.movements = movements;
    } */
    return Right(srSubjects);
  }

  @override
  Future<Either<Failure, List>> getRegistersForExam(
      {required String idUser, required String syllabus}) async {
    // List<StudentRecordSubject> srSubjects = [];
    List regsExam = [];
    // GET syllabus ID
    Future<String> syllabusId =
        getSyllabusId(idUser: idUser, syllabus: syllabus);
    DocumentSnapshot<Map<String, dynamic>> listaRegs = (await firestoreInstance
        .collection("iesUsers")
        .doc(idUser)
        .collection('roles')
        .doc(await syllabusId)
        .get());
// GET student records
    DocumentSnapshot studentRegisterDocs = (await firestoreInstance
        .collection("iesUsers")
        .doc('RZccG88VMgH40PyeZGoc')
        .collection('roles')
        .doc('5vTGoOXTiV3cBV5Nlahz')
        .get());
    // .get("registeredForExams"));
    // .map((e) => e.data())
    // .toList());
    // srSubjects = studentRecordsDocs
    //     .map((e) => StudentRecordSubject(subjectId: e['id'], name: "name"))
    //     .toList();
    bool regDocsExists = studentRegisterDocs.exists;
    if (regDocsExists) {
      regsExam = studentRegisterDocs
          .get("registeredForExams")
          .map((item) => item.toString())
          .toList();
      print("ifTrue");
      // regsExam =
      //     List<String>.from(studentRegisterDocs.data());
    } else {
      Left(Failure(failureName: RegisterForExamStateName.loadnull));
    }
    print(listaRegs);
    print("regsExam: ${regsExam}");
    print("String?? ${regsExam[0] is String}");
    // regsExam.add(studentRegisterDocs.toString());
    // regsExam = studentRegisterDocs.cast<String>();

    // print(srSubjects);
    // Get student record movements
    /* for (var studentRecord in srSubjects) {
      List<MovementStudentRecord> movements = await getStudentRecordMovements(
          idUser: idUser,
          subjectId: studentRecord.subjectId,
          syllabusId: syllabus);
      studentRecord.movements = movements;
    } */
    return Right(regsExam);
  }

  @override
  Future<Either<Failure, Success>> setRegistersForExam(
      {required String idUser,
      required String syllabus,
      required List registereds}) async {
    // GET syllabus ID
    Future<String> syllabusId =
        getSyllabusId(idUser: idUser, syllabus: syllabus);
    // try to submit the list
    try {
      await firestoreInstance
          .collection("iesUsers")
          .doc(idUser)
          .collection("roles")
          .doc(await syllabusId)
          .update({'registeredForExams': registereds});
      return Right(Success("Ok"));
    } catch (e) {
      print("Error al subir los datos de inscripción: $e");
      return Left(Failure(
          failureName: RegisterForExamStateName.failure, message: "$e"));
    }
  }

  @override
  Future<List<MovementStudentRecord>> getStudentMovements(
      {required String idUser,
      required String syllabusId,
      required int subjectId}) async {
    List<MovementStudentRecord> movements = [];
    List<Map<String, dynamic>> studentRecordsDocs = [];
    studentRecordsDocs = ((await firestoreInstance
            .collection("iesUsers")
            .doc(idUser)
            .collection('roles')
            .doc(await getSyllabusId(idUser: idUser, syllabus: syllabusId))
            .collection("subjects")
            .doc(await getSubjectId(
                subjectID: subjectId,
                syllabusID:
                    await getSyllabusId(idUser: idUser, syllabus: syllabusId),
                userID: idUser))
            .collection('movements')
            .get())
        .docs
        .map((e) => e.data())
        .toList());

    movements = studentRecordsDocs
        .map((e) => MovementStudentRecord(
            movementName: stringToSRMovementName(e['name']),
            date: timestampToDate(e['date'])))
        .toList();

    return movements;
  }
}
