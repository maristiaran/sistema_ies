import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/repositories/syllabus_repository_port.dart';

class SyllabusRepositoryFakeAdapter implements SyllabusRepositoryPort {
  @override
  List<Syllabus> getActiveSyllabus() {
    return [
      Syllabus(
          name: 'Tecnicatura Superior en Desarrollo de Software',
          administrativeResolution: '501-DGE-19')
    ];
  }
}
