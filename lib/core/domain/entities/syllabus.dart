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
