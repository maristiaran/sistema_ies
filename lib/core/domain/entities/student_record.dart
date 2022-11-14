import 'package:sistema_ies/core/domain/entities/syllabus.dart';

class StudentRecord {
  String name;
  List<SubjectSR> subjects = [];
  StudentRecord({required this.name});

  addSubjects(SubjectSR subject) {
    if (!subjects.contains(subject)) {
      subjects = [...subjects, subject];
    }
  }
}

class SubjectSR {
  List<MovementStudentRecord> movements = [];
  String name;
  SubjectSR({required this.name});
  addMovementsToSubject(MovementStudentRecord movementStudentRecord) {
    if (!movements.contains(movementStudentRecord)) {
      movements = [...movements, movementStudentRecord];
    }
  }
}

class MovementStudentRecord {
  String nota;
  String year;
  MovementStudentRecord({required this.nota, required this.year});
}
