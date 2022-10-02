class Syllabus {
  late String name;
  late String administrativeResolution;
  List<Subject> subjects = [];

  Syllabus({required this.name, required this.administrativeResolution});
  Syllabus.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    administrativeResolution = json['administrativeResolution'];
  }

  addSubject(Subject newSubject) {
    subjects.add(newSubject);
  }

  // addSubject(
  //     {required int id,
  //     required int year,
  //     required String name,
  //     required List<SubjectType> subjectType,
  //     required SubjectDuration subjectDuration,
  //     required int hoursPerWeek,
  //     required List<int> coursesNeededForCoursingIds,
  //     required List<int> examNeededForExaminationIds}) {
  //   Subject newSubject = Subject(
  //       id: id,
  //       name: name,
  //       subjectType: subjectType,
  //       subjectDuration: subjectDuration,
  //       hoursPerWeek: hoursPerWeek,
  //       courseYear: year);
  //   for (id in coursesNeededForCoursingIds) {
  //     newSubject.addCourseNeededForCoursing(getSubjectIfAnyByID(id)!);
  //   }
  //   for (id in examNeededForExaminationIds) {
  //     newSubject.addExamNeededForExamination(getSubjectIfAnyByID(id)!);
  //   }
  //   subjects.add(newSubject);
  // }

  Subject? getSubjectIfAnyByID(int id) {
    if (subjects.length >= id) {
      return subjects[id - 1];
    } else {
      return null;
    }
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
