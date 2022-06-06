import 'package:sistema_ies/shared/entities/syllabus.dart';

abstract class SyllabusRepositoryPort {
  List<Syllabus> getActiveSyllabus();
}
