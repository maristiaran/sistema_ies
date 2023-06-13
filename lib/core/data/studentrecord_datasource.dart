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
