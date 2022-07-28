import 'package:either_dart/either.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

class SyllabusesRepositoryMemoryAdapter implements SyllabusesRepositoryPort {
  List<Syllabus>? _cachedSyllabuses;

  @override
  Future<Either<Failure, List<Syllabus>>> getActiveSyllabuses() async {
    Syllabus _buildSyllabusFromJson(Map<String, dynamic> json) {
      Syllabus newSyllabus =
          Syllabus(name: json['name'], administrativeResolution: '490-DGE-19');
      for (Map<String, dynamic> subjectJson in json['subjects']) {
        Subject newSubject = Subject(
            id: subjectJson['id'],
            courseYear: subjectJson['year'],
            name: subjectJson['name'],
            subjectType: subjectJson['subjectType'],
            subjectDuration: subjectJson['subjectDuration'],
            hoursPerWeek: subjectJson['hoursPerWeek']);
        for (int courseId in subjectJson['coursesNeededForCoursingIds']) {
          newSubject.addCourseNeededForCoursing(
              newSyllabus.getSubjectIfAnyByID(courseId)!);
        }
        for (int courseId in subjectJson['examNeededForExaminationIds']) {
          newSubject.addExamNeededForExamination(
              newSyllabus.getSubjectIfAnyByID(courseId)!);
        }
        newSyllabus.addSubject(newSubject);
      }
      return newSyllabus;
    }

    Syllabus _buildSyllabus490DGE19() {
      Map<String, dynamic> newJson = {
        'name': 'Tecnicatura Superior en Computación y Redes',
        'administrativeResolution': '490-DGE-19',
        'subjects': [
          {
            'id': 1,
            'year': 1,
            'name': 'Inglés técnico I',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 2,
            'year': 1,
            'name': 'Matemática I',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 3,
            'year': 1,
            'name': 'Tecnología de la información I',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 4,
            'year': 1,
            'name': 'Sistemas operativos I',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 5,
            'year': 1,
            'name': 'Lógica computacional',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 6,
            'year': 1,
            'name': 'Comprensión y producción de textos',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 7,
            'year': 1,
            'name': 'Fundamentos de electrónica',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 8,
            'year': 1,
            'name': 'Arquitectura de computadoras',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 9,
            'year': 1,
            'name': 'Problemática sociocultural y el contexto',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 10,
            'year': 1,
            'name': 'Electrónica aplicada',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [7],
            'examNeededForExaminationIds': [7]
          },
          {
            'id': 11,
            'year': 1,
            'name': 'Práctica profesionalizante I',
            'subjectType': [SubjectType.professionalPractice],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': [3, 4, 5, 7, 8]
          },
          {
            'id': 12,
            'year': 2,
            'name': 'Inglés técnico II',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [1],
            'examNeededForExaminationIds': [1]
          },
          {
            'id': 13,
            'year': 2,
            'name': 'Matemática II',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [2],
            'examNeededForExaminationIds': [2]
          },
          {
            'id': 14,
            'year': 2,
            'name': 'Sistemas operativos II',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [4],
            'examNeededForExaminationIds': [4]
          },
          {
            'id': 15,
            'year': 2,
            'name': 'Fundamentos de programación II',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [3, 5],
            'examNeededForExaminationIds': [3, 5]
          },
          {
            'id': 16,
            'year': 2,
            'name': 'Ética profesional',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 2,
            'coursesNeededForCoursingIds': [9],
            'examNeededForExaminationIds': [9]
          },
          {
            'id': 17,
            'year': 2,
            'name': 'Soporte de infraestructura I',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [8, 11],
            'examNeededForExaminationIds': [11]
          },
          {
            'id': 18,
            'year': 2,
            'name': 'Comunicaciones y redes',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 8,
            'coursesNeededForCoursingIds': [3],
            'examNeededForExaminationIds': [3]
          },
          {
            'id': 19,
            'year': 2,
            'name': 'Sistemas administrativos aplicados',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 20,
            'year': 2,
            'name': 'Redes aplicadas I',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 8,
            'coursesNeededForCoursingIds': [7, 18],
            'examNeededForExaminationIds': [7, 18]
          },
          {
            'id': 21,
            'year': 2,
            'name': 'Práctica profesionalizante II',
            'subjectType': [SubjectType.professionalPractice],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [11],
            'examNeededForExaminationIds': [11, 17, 20]
          },
          {
            'id': 22,
            'year': 3,
            'name': 'Estadistica aplicada',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 2,
            'coursesNeededForCoursingIds': [13],
            'examNeededForExaminationIds': [13]
          },
          {
            'id': 23,
            'year': 3,
            'name': 'Soporte de infraestructura II',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [17],
            'examNeededForExaminationIds': [17]
          },
          {
            'id': 24,
            'year': 3,
            'name': 'Sistemas de telefonía y videoseguridad',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [20],
            'examNeededForExaminationIds': [20]
          },
          {
            'id': 25,
            'year': 3,
            'name': 'Gestión de base de datos',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 6,
            'coursesNeededForCoursingIds': [15],
            'examNeededForExaminationIds': [15]
          },
          {
            'id': 26,
            'year': 3,
            'name': 'Legislación informática',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [16],
            'examNeededForExaminationIds': [16]
          },
          {
            'id': 27,
            'year': 3,
            'name': 'Seguridad en redes',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 7,
            'coursesNeededForCoursingIds': [20],
            'examNeededForExaminationIds': [20]
          },
          {
            'id': 28,
            'year': 3,
            'name': 'Programación de scripts y embebidos',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 6,
            'coursesNeededForCoursingIds': [15],
            'examNeededForExaminationIds': [15]
          },
          {
            'id': 29,
            'year': 3,
            'name': 'Gestión de emprendimientos',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [19],
            'examNeededForExaminationIds': [19]
          },
          {
            'id': 30,
            'year': 3,
            'name': 'Redes aplicadas II',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 7,
            'coursesNeededForCoursingIds': [20],
            'examNeededForExaminationIds': [20]
          },
          {
            'id': 31,
            'year': 3,
            'name': 'Práctica profesionalizante III',
            'subjectType': [SubjectType.professionalPractice],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [for (var i = 12; i <= 21; i++) i],
            'examNeededForExaminationIds': [for (var i = 1; i <= 30; i++) i]
          },
        ]
      };
      return _buildSyllabusFromJson(newJson);
    }

    Syllabus _buildSyllabus501DGE19() {
      Map<String, dynamic> newJson = {
        'name': 'Tecnicatura Superior en Desarrollo de Software',
        'administrativeResolution': '501-DGE-19',
        'subjects': [
          {
            'id': 1,
            'year': 1,
            'name': 'Programación I',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 8,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 2,
            'year': 1,
            'name': 'Arquitectura de las computadoras',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 3,
            'year': 1,
            'name': 'Requerimientos de software',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 4,
            'year': 1,
            'name': 'Álgebra',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 5,
            'year': 1,
            'name': 'Inglés técnico I',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 6,
            'year': 1,
            'name': 'Comprensión y producción de textos',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 7,
            'year': 1,
            'name': 'Lógica computacional',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 8,
            'year': 1,
            'name': 'Problematica sociocultural y del trabajo',
            'subjectType': [SubjectType.seminary],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 9,
            'year': 1,
            'name': 'Sistemas administrativos aplicados',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 10,
            'year': 1,
            'name': 'Práctica profesionalizante I',
            'subjectType': [SubjectType.professionalPractice],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': [1, 3, 7, 9]
          },
          {
            'id': 11,
            'year': 2,
            'name': 'Comunicaciones y redes',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [2],
            'examNeededForExaminationIds': [2]
          },
          {
            'id': 12,
            'year': 2,
            'name': 'Programación II',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 6,
            'coursesNeededForCoursingIds': [1],
            'examNeededForExaminationIds': [1]
          },
          {
            'id': 13,
            'year': 2,
            'name': 'Matemática discreta',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [4],
            'examNeededForExaminationIds': [4]
          },
          {
            'id': 14,
            'year': 2,
            'name': 'Análisis matemático',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 5,
            'coursesNeededForCoursingIds': [13],
            'examNeededForExaminationIds': [13]
          },
          {
            'id': 15,
            'year': 2,
            'name': 'Inglés técnico II',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [5],
            'examNeededForExaminationIds': [5]
          },
          {
            'id': 16,
            'year': 2,
            'name': 'Modelado de software',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [3],
            'examNeededForExaminationIds': [3]
          },
          {
            'id': 17,
            'year': 2,
            'name': 'Base de datos I',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [2, 7],
            'examNeededForExaminationIds': [7]
          },
          {
            'id': 18,
            'year': 2,
            'name': 'Sistemas operativos',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [2],
            'examNeededForExaminationIds': [2]
          },
          {
            'id': 19,
            'year': 2,
            'name': 'Práctica profesionalizante II',
            'subjectType': [SubjectType.professionalPractice],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [10],
            'examNeededForExaminationIds': [11, 12, 16, 17, 9]
          },
          {
            'id': 20,
            'year': 3,
            'name': 'Programación III',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [12],
            'examNeededForExaminationIds': [12]
          },
          {
            'id': 21,
            'year': 3,
            'name': 'Arquitectura y diseño de interfaces',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [16],
            'examNeededForExaminationIds': [16]
          },
          {
            'id': 22,
            'year': 3,
            'name': 'Auditoria y calidad de sistemas',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [9, 16],
            'examNeededForExaminationIds': [16]
          },
          {
            'id': 23,
            'year': 3,
            'name': 'Seguridad informática',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [22],
            'examNeededForExaminationIds': [22]
          },
          {
            'id': 24,
            'year': 3,
            'name': 'Inglés técnico III',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 2,
            'coursesNeededForCoursingIds': [15],
            'examNeededForExaminationIds': [15]
          },
          {
            'id': 25,
            'year': 3,
            'name': 'Base de datos II',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [17],
            'examNeededForExaminationIds': [17]
          },
          {
            'id': 26,
            'year': 3,
            'name': 'Probabilidad y estadística',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [14],
            'examNeededForExaminationIds': [14]
          },
          {
            'id': 27,
            'year': 3,
            'name': 'Legislación informática',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 2,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': 28,
            'year': 3,
            'name': 'Ética profesional',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 2,
            'coursesNeededForCoursingIds': [27],
            'examNeededForExaminationIds': [27]
          },
          {
            'id': 29,
            'year': 3,
            'name': 'Gestión de proyectos de software',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [16],
            'examNeededForExaminationIds': [16]
          },
          {
            'id': 30,
            'year': 3,
            'name': 'Práctica profesionalizante III',
            'subjectType': [SubjectType.professionalPractice],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
        ]
      };
      return _buildSyllabusFromJson(newJson);
    }

    if (_cachedSyllabuses == null) {
      _cachedSyllabuses = [];
      _cachedSyllabuses!.add(_buildSyllabus490DGE19());
      _cachedSyllabuses!.add(_buildSyllabus501DGE19());
    }

    return Right(_cachedSyllabuses!);
  }
}
