class Syllabus {
  late String id;
  late String name;
  late String administrativeResolution;
  List<Subject> subjects = [];

  Syllabus(
      {required this.id,
      required this.name,
      required this.administrativeResolution});
  Syllabus.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    administrativeResolution = json['administrativeResolution'];
  }
}

class Subject {
  late String name;
}
