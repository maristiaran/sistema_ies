class Syllabus {
  final String name;
  final String administrativeResolution;
  List<Subject> subjects = [];

  Syllabus({required this.name, required this.administrativeResolution});

  addSubject(Subject newSubject) {
    subjects.add(newSubject);
  }

  @override
  String toString() {
    return "$name ($administrativeResolution)";
  }

  Subject? getSubjectIfAnyByID(int id) {
    if (subjects.length >= id) {
      return subjects[id - 1];
    } else {
      return null;
    }
  }

  int subjectCount() {
    return subjects.length;
  }
}

enum SubjectType { module, workshop, professionalPractice, seminary }

enum SubjectDuration { allYear, firstQuarter, secondQuarter }

// class Subject {
//   //id format: id_syllabus - order_number.For example: 501-DGE-19-02
//   final String id;
//   final int courseYear;
//   final String name;
//   final List<SubjectType> subjectType;
//   final SubjectDuration subjectDuration;
//   final int hoursPerWeek;
//   List<Subject> coursesNeededForCoursing = [];
//   List<Subject> examNeededForExamination = [];

//   Subject(
//       {required this.id,
//       required this.name,
//       required this.subjectType,
//       required this.subjectDuration,
//       required this.hoursPerWeek,
//       required this.courseYear});

//   String get syllabus_id => id.substring(0, id.length - 3);
//   int get order_number => int.parse(id.substring(id.length - 3));
// }

class Subject {
  final int id;
  final int courseYear;
  final String name;
  final List<SubjectType> subjectType;
  final SubjectDuration subjectDuration;
  final int hoursPerWeek;
  List<Subject> coursesNeededForCoursing = [];
  List<Subject> examNeededForExamination = [];

  Subject(
      {required this.id,
      required this.name,
      required this.subjectType,
      required this.subjectDuration,
      required this.hoursPerWeek,
      required this.courseYear});

  @override
  String toString() {
    return name;
  }

  addCourseNeededForCoursing(Subject subjectCourse) {
    coursesNeededForCoursing.add(subjectCourse);
  }

  addExamNeededForExamination(Subject subjectExam) {
    examNeededForExamination.add(subjectExam);
  }
}
