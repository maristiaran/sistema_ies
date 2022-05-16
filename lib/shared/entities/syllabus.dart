class Syllabus {
  late String name;
  late String administrativeResolution;
  List<Subject> subjects = [];

  Syllabus({required this.name, required this.administrativeResolution});
}

class Subject {
  late String name;
}
