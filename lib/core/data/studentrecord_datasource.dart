import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
import 'package:sistema_ies/core/data/utils/string_to_movement_name.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/repositories/studentrecord_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

import '../domain/utils/datetime.dart';

class StudentDatasource implements StudentRepositoryPort {
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
    return await firestoreInstance
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

    return Right(srSubjects);
  }

  @override
  Future<List<MovementStudentRecord>> getStudentRecordMovements(
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
            // I should review the function that get subjectId
            .doc("0NTl6E4AJOeLVpLmv5IJ")
            .collection('movements')
            .get())
        .docs
        .map((e) => e.data())
        .toList());
    movements = studentRecordsDocs
        .map((e) =>
            MovementStudentRecord(movementName: stringToSRMovementName(e['name']), date: timestampToDate(e['date'])))
        .toList();
    return movements;
  }
}
