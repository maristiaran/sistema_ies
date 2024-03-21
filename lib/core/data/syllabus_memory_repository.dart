import 'package:either_dart/either.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class SyllabusesRepositoryMemoryAdapter implements SyllabusesRepositoryPort {
  List<Syllabus>? _cachedSyllabuses;

  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    Syllabus buildSyllabusFromJson(Map<String, dynamic> json) {
      Syllabus newSyllabus = Syllabus(
          name: json['name'],
          administrativeResolution: json['administrativeResolution']);
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

    Syllabus buildSyllabus490DGE19() {
      Map<String, dynamic> newJson = {
        'name': 'Tecnicatura Superior en Computación y Redes',
        'administrativeResolution': '490-DGE-19',
        'subjects': [
          {
            'id': '490-DGE-19-01',
            'year': 1,
            'name': 'Inglés técnico I',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '490-DGE-19-02',
            'year': 1,
            'name': 'Matemática I',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '490-DGE-19-03',
            'year': 1,
            'name': 'Tecnología de la información I',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '490-DGE-19-04',
            'year': 1,
            'name': 'Sistemas operativos I',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '490-DGE-19-05',
            'year': 1,
            'name': 'Lógica computacional',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '490-DGE-19-06',
            'year': 1,
            'name': 'Comprensión y producción de textos',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '490-DGE-19-07',
            'year': 1,
            'name': 'Fundamentos de electrónica',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '490-DGE-19-08',
            'year': 1,
            'name': 'Arquitectura de computadoras',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '490-DGE-19-09',
            'year': 1,
            'name': 'Problemática sociocultural y el contexto',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '490-DGE-19-10',
            'year': 1,
            'name': 'Electrónica aplicada',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [7],
            'examNeededForExaminationIds': [7]
          },
          {
            'id': '490-DGE-19-11',
            'year': 1,
            'name': 'Práctica profesionalizante I',
            'subjectType': [SubjectType.professionalPractice],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': [3, 4, 5, 7, 8]
          },
          {
            'id': '490-DGE-19-12',
            'year': 2,
            'name': 'Inglés técnico II',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [1],
            'examNeededForExaminationIds': [1]
          },
          {
            'id': '490-DGE-19-13',
            'year': 2,
            'name': 'Matemática II',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [2],
            'examNeededForExaminationIds': [2]
          },
          {
            'id': '490-DGE-19-14',
            'year': 2,
            'name': 'Sistemas operativos II',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [4],
            'examNeededForExaminationIds': [4]
          },
          {
            'id': '490-DGE-19-15',
            'year': 2,
            'name': 'Fundamentos de programación II',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [3, 5],
            'examNeededForExaminationIds': [3, 5]
          },
          {
            'id': '490-DGE-19-16',
            'year': 2,
            'name': 'Ética profesional',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 2,
            'coursesNeededForCoursingIds': [9],
            'examNeededForExaminationIds': [9]
          },
          {
            'id': '490-DGE-19-17',
            'year': 2,
            'name': 'Soporte de infraestructura I',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [8, 11],
            'examNeededForExaminationIds': [11]
          },
          {
            'id': '490-DGE-19-18',
            'year': 2,
            'name': 'Comunicaciones y redes',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 8,
            'coursesNeededForCoursingIds': [3],
            'examNeededForExaminationIds': [3]
          },
          {
            'id': '490-DGE-19-19',
            'year': 2,
            'name': 'Sistemas administrativos aplicados',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '490-DGE-19-20',
            'year': 2,
            'name': 'Redes aplicadas I',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 8,
            'coursesNeededForCoursingIds': [7, 18],
            'examNeededForExaminationIds': [7, 18]
          },
          {
            'id': '490-DGE-19-21',
            'year': 2,
            'name': 'Práctica profesionalizante II',
            'subjectType': [SubjectType.professionalPractice],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [11],
            'examNeededForExaminationIds': [11, 17, 20]
          },
          {
            'id': '490-DGE-19-22',
            'year': 3,
            'name': 'Estadistica aplicada',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 2,
            'coursesNeededForCoursingIds': [13],
            'examNeededForExaminationIds': [13]
          },
          {
            'id': '490-DGE-19-23',
            'year': 3,
            'name': 'Soporte de infraestructura II',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [17],
            'examNeededForExaminationIds': [17]
          },
          {
            'id': '490-DGE-19-24',
            'year': 3,
            'name': 'Sistemas de telefonía y videoseguridad',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [20],
            'examNeededForExaminationIds': [20]
          },
          {
            'id': '490-DGE-19-25',
            'year': 3,
            'name': 'Gestión de base de datos',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 6,
            'coursesNeededForCoursingIds': [15],
            'examNeededForExaminationIds': [15]
          },
          {
            'id': '490-DGE-19-26',
            'year': 3,
            'name': 'Legislación informática',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [16],
            'examNeededForExaminationIds': [16]
          },
          {
            'id': '490-DGE-19-27',
            'year': 3,
            'name': 'Seguridad en redes',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 7,
            'coursesNeededForCoursingIds': [20],
            'examNeededForExaminationIds': [20]
          },
          {
            'id': '490-DGE-19-28',
            'year': 3,
            'name': 'Programación de scripts y embebidos',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 6,
            'coursesNeededForCoursingIds': [15],
            'examNeededForExaminationIds': [15]
          },
          {
            'id': '490-DGE-19-29',
            'year': 3,
            'name': 'Gestión de emprendimientos',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [19],
            'examNeededForExaminationIds': [19]
          },
          {
            'id': '490-DGE-19-30',
            'year': 3,
            'name': 'Redes aplicadas II',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 7,
            'coursesNeededForCoursingIds': [20],
            'examNeededForExaminationIds': [20]
          },
          {
            'id': '490-DGE-19-31',
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
      return buildSyllabusFromJson(newJson);
    }

    Syllabus buildSyllabus501DGE19() {
      Map<String, dynamic> newJson = {
        'name': 'Tecnicatura Superior en Desarrollo de Software',
        'administrativeResolution': '501-DGE-19',
        'subjects': [
          {
            'id': '501-DGE-19-01',
            'year': 1,
            'name': 'Programación I',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 8,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '501-DGE-19-02',
            'year': 1,
            'name': 'Arquitectura de las computadoras',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '501-DGE-19-03',
            'year': 1,
            'name': 'Requerimientos de software',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '501-DGE-19-04',
            'year': 1,
            'name': 'Álgebra',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '501-DGE-19-05',
            'year': 1,
            'name': 'Inglés técnico I',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '501-DGE-19-06',
            'year': 1,
            'name': 'Comprensión y producción de textos',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '501-DGE-19-07',
            'year': 1,
            'name': 'Lógica computacional',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '501-DGE-19-08',
            'year': 1,
            'name': 'Problematica sociocultural y del trabajo',
            'subjectType': [SubjectType.seminary],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '501-DGE-19-09',
            'year': 1,
            'name': 'Sistemas administrativos aplicados',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '501-DGE-19-10',
            'year': 1,
            'name': 'Práctica profesionalizante I',
            'subjectType': [SubjectType.professionalPractice],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': [1, 3, 7, 9]
          },
          {
            'id': '501-DGE-19-11',
            'year': 2,
            'name': 'Comunicaciones y redes',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [2],
            'examNeededForExaminationIds': [2]
          },
          {
            'id': '501-DGE-19-12',
            'year': 2,
            'name': 'Programación II',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 6,
            'coursesNeededForCoursingIds': [1],
            'examNeededForExaminationIds': [1]
          },
          {
            'id': '501-DGE-19-13',
            'year': 2,
            'name': 'Matemática discreta',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [4],
            'examNeededForExaminationIds': [4]
          },
          {
            'id': '501-DGE-19-14',
            'year': 2,
            'name': 'Análisis matemático',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 5,
            'coursesNeededForCoursingIds': [13],
            'examNeededForExaminationIds': [13]
          },
          {
            'id': '501-DGE-19-15',
            'year': 2,
            'name': 'Inglés técnico II',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [5],
            'examNeededForExaminationIds': [5]
          },
          {
            'id': '501-DGE-19-16',
            'year': 2,
            'name': 'Modelado de software',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [3],
            'examNeededForExaminationIds': [3]
          },
          {
            'id': '501-DGE-19-17',
            'year': 2,
            'name': 'Base de datos I',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [2, 7],
            'examNeededForExaminationIds': [7]
          },
          {
            'id': '501-DGE-19-18',
            'year': 2,
            'name': 'Sistemas operativos',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [2],
            'examNeededForExaminationIds': [2]
          },
          {
            'id': '501-DGE-19-19',
            'year': 2,
            'name': 'Práctica profesionalizante II',
            'subjectType': [SubjectType.professionalPractice],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [10],
            'examNeededForExaminationIds': [11, 12, 16, 17, 9]
          },
          {
            'id': '501-DGE-19-20',
            'year': 3,
            'name': 'Programación III',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [12],
            'examNeededForExaminationIds': [12]
          },
          {
            'id': '501-DGE-19-21',
            'year': 3,
            'name': 'Arquitectura y diseño de interfaces',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [16],
            'examNeededForExaminationIds': [16]
          },
          {
            'id': '501-DGE-19-22',
            'year': 3,
            'name': 'Auditoria y calidad de sistemas',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [9, 16],
            'examNeededForExaminationIds': [16]
          },
          {
            'id': '501-DGE-19-23',
            'year': 3,
            'name': 'Seguridad informática',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [22],
            'examNeededForExaminationIds': [22]
          },
          {
            'id': '501-DGE-19-24',
            'year': 3,
            'name': 'Inglés técnico III',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 2,
            'coursesNeededForCoursingIds': [15],
            'examNeededForExaminationIds': [15]
          },
          {
            'id': '501-DGE-19-25',
            'year': 3,
            'name': 'Base de datos II',
            'subjectType': [SubjectType.module, SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [17],
            'examNeededForExaminationIds': [17]
          },
          {
            'id': '501-DGE-19-26',
            'year': 3,
            'name': 'Probabilidad y estadística',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 4,
            'coursesNeededForCoursingIds': [14],
            'examNeededForExaminationIds': [14]
          },
          {
            'id': '501-DGE-19-27',
            'year': 3,
            'name': 'Legislación informática',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.firstQuarter,
            'hoursPerWeek': 2,
            'coursesNeededForCoursingIds': [],
            'examNeededForExaminationIds': []
          },
          {
            'id': '501-DGE-19-28',
            'year': 3,
            'name': 'Ética profesional',
            'subjectType': [SubjectType.module],
            'subjectDuration': SubjectDuration.secondQuarter,
            'hoursPerWeek': 2,
            'coursesNeededForCoursingIds': [27],
            'examNeededForExaminationIds': [27]
          },
          {
            'id': '501-DGE-19-29',
            'year': 3,
            'name': 'Gestión de proyectos de software',
            'subjectType': [SubjectType.workshop],
            'subjectDuration': SubjectDuration.allYear,
            'hoursPerWeek': 3,
            'coursesNeededForCoursingIds': [16],
            'examNeededForExaminationIds': [16]
          },
          {
            'id': '501-DGE-19-30',
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
      return buildSyllabusFromJson(newJson);
    }

    if (_cachedSyllabuses == null) {
      _cachedSyllabuses = [];
      _cachedSyllabuses!.add(buildSyllabus490DGE19());
      _cachedSyllabuses!.add(buildSyllabus501DGE19());
    }

    return Right(Success('Ok'));
  }

  @override
  Future<Either<Failure, Syllabus>> getSyllabusByAdministrativeResolution(
      {required String administrativeResolution}) async {
    if (administrativeResolution == '490-DGE-19') {
      return Right(_cachedSyllabuses![0]);
    } else if (administrativeResolution == '501-DGE-19') {
      return Right(_cachedSyllabuses![1]);
    } else {
      return Left(Failure(failureName: FailureName.unknown));
    }
  }

  @override
  Future<Either<Failure, List<Syllabus>>>
      getSyllabusesByAdministrativeResolution(
          {required List<String> administrativeResolutions}) async {
    List<Syllabus> syllabuses = [];
    for (String res in administrativeResolutions) {
      getSyllabusByAdministrativeResolution(administrativeResolution: res).fold(
          (error) {
        return error;
      }, (syllabus) {
        syllabuses.add(syllabus);
      });
    }

    return Right(syllabuses);
  }

  @override
  List<Syllabus> getAllSyllabuses() {
    return _cachedSyllabuses ?? [];
  }
}
