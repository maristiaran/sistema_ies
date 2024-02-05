import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
import 'package:sistema_ies/core/data/utils/filter_movement_student_record_by_more_recent.dart';
import 'package:sistema_ies/core/data/utils/string_to_movement_name.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/repositories/student_repository.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';
import 'package:sistema_ies/register_for_exam/utils/prints.dart';

import '../domain/utils/datetime.dart';

class StudentDatasource implements StudentRepositoryPort {
  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    return Right(Success('ok'));
  }

  // getUserIfHasStudentRole

  // This function gets an Id from a Syllabus [required String idUser | required String syllabus]
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

// This function gets an Id from a Subject [required String idUser | required String syllabus]
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
      onError: (e) => {prints("Error completing: $e")},
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

  @override
  Future<Either<Failure, List<Object>>> getSubjects(
      {required String idUser, required String syllabusId}) async {
    List<MovementStudentRecord> movements = [];
    List<Map> subjectsDocs = [];
    subjectsDocs = (await firestoreInstance
            .collection("iesUsers")
            .doc(idUser)
            .collection('roles')
            .doc(await getSyllabusId(idUser: idUser, syllabus: syllabusId))
            .collection("subjects")
            .get())
        .docs
        .map((e) => e.data())
        .toList();
    /* for (var subject in subjectsDocs) {
      movements = await getStudentRecordMovements(
          idUser: idUser, syllabusId: syllabusId, subjectId: subject['id']);
      if (movements.isNotEmpty) {
        //subject['movements'] = movements;
        prints(movements);
      }
    }  */
    for (var subject in subjectsDocs) {
      movements = await getStudentRecordMovements(
          idUser: idUser, subjectId: subject['id'], syllabusId: syllabusId);
      List<MovementStudentRecord> movementsNecessaries = [];
      List<MovementStudentRecord> courseRegistering = [];
      List<MovementStudentRecord> finalExamNonApproved = [];
      for (MovementStudentRecord movement in movements) {
        if (movement.movementName ==
            MovementStudentRecordName.courseRegistering) {
          courseRegistering.add(movement);
        }
        if (movement.movementName ==
            MovementStudentRecordName.finalExamNonApproved) {
          finalExamNonApproved.add(movement);
        }
      }
      if (courseRegistering.isNotEmpty) {
        movementsNecessaries
            .add(filterMovementStudentRecordByMoreRecent(courseRegistering)!);
      }
      if (finalExamNonApproved.isNotEmpty) {
        movementsNecessaries.add(
            filterMovementStudentRecordByMoreRecent(finalExamNonApproved)!);
      }
      subject['movements'] = movementsNecessaries;
    }

    prints(subjectsDocs);
    prints("Done!");
    return Right(subjectsDocs);
  }
}
