import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
import 'package:sistema_ies/core/domain/repositories/studentregister_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';
import 'package:sistema_ies/register_for_exam/domain/register_for_exam.dart';
import 'package:sistema_ies/register_for_exam/utils/prints.dart';

class StudentsRegister implements StudentsRepositoryPort {
  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    return Right(Success('ok'));
  }

  /// Get syllabus of current role by administrative resolution
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
      onError: (e) => {prints("Error completing: $e")},
    );
  }

  /// Get list of subjects registereds for exam
  @override
  Future<Either<Failure, List>> getRegistersForExam(
      {required String idUser, required String syllabus}) async {
    List regsExam = [];
    // GET syllabus ID
    Future<String> syllabusId =
        getSyllabusId(idUser: idUser, syllabus: syllabus);

    DocumentSnapshot studentRegisterDocs = (await firestoreInstance
        .collection("iesUsers")
        .doc(idUser)
        .collection('roles')
        .doc(await syllabusId)
        .get());

    bool regDocsExists = studentRegisterDocs.exists;
    if (regDocsExists) {
      regsExam = studentRegisterDocs
          .get("registeredForExams")
          .map((item) => item.toString())
          .toList();
      prints("ifTrue");
    } else {
      Left(Failure(failureName: RegisterForExamStateName.loadnull));
    }
    prints("regsExam: $regsExam");
    prints("String?? ${regsExam[0] is String}");
    return Right(regsExam);
  }

  /// Submit subjects registereds to firestore
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
      prints("Error al subir los datos de inscripción: $e");
      return Left(Failure(
          failureName: RegisterForExamStateName.failure, message: "$e"));
    }
  }
}
