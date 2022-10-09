import 'package:sistema_ies/core/domain/entities/syllabus.dart';

Syllabus fromJsonToSyllabus(Map<String, dynamic> json) {
  return Syllabus(
      name: json['name'],
      administrativeResolution: json['administrativeResolution']);
}
