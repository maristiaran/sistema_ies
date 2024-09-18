import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
import 'package:sistema_ies/core/data/utils/sort_movements.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/repositories/student_repository.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';
import 'package:sistema_ies/core/domain/utils/prints.dart';

class StudentDatasource implements StudentRepositoryPort {
  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    return Right(Success('ok'));
  }

  // Function POST to add a new Student record movement in database
  @override
  void addStudentRecordMovement(
      {required MovementStudentRecord newMovement,
      required String idUser,
      required String syllabusId,
      required int subjectId}) {
    // TODO: implement addStudentRecordMovement
    try {
      firestoreInstance
          .collection("iesUsers")
          .doc(idUser)
          .collection('roles')
          .doc("syllabus")
          .collection("subject")
          .add(newMovement.toMap(newMovement));
    } catch (e) {
      prints(e);
    }
  }

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
    // srSubjects is equal to a list of StudentRecordSubject build with studentRecordsDocs
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

    movements = sortMovements(studentRecordsDocs);

    return movements;
  }

  @override
  Future<Either<Failure, List<StudentRecordSubject2>>> getSubjects(
      {required String idUser, required String syllabusId}) async {
    List<StudentRecordSubject2> subjects = [];
    List<Map> subjectsDocs = [];
    prints("Started!");
    try {
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
      for (var subject in subjectsDocs) {
        prints(subject);
        subjects.add(StudentRecordSubject2.fromJson(subject));
      }
    } catch (e) {
      prints(e);
    }
    prints("Done!");
    return Right(subjects);
  }
}
