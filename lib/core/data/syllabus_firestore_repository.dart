import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
import 'package:sistema_ies/core/data/utils/syllabus_json_convertion.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class SyllabusesRepositoryFirestoreAdapter implements SyllabusesRepositoryPort {
  List<Syllabus>? _cachedSyllabuses;

  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    if (_cachedSyllabuses == null) {
      _cachedSyllabuses = [];
      for (var doc in (await firestoreInstance
          .collection('syllabuses')
          .get()
          .then((snapshot) => snapshot.docs))) {
        _cachedSyllabuses!.add(fromJsonToSyllabus(doc.data()));
      }
    }
    return Right(Success('Ok'));
  }

  @override
  Future<Either<Failure, Syllabus>> getSyllabusByAdministrativeResolution(
      {required String administrativeResolution}) async {
    return Left(Failure(failureName: FailureName.unknown));
  }

  @override
  Future<Either<Failure, List<Syllabus>>>
      getSyllabusesByAdministrativeResolution(
          {required List<String> administrativeResolutions}) async {
    return Left(Failure(failureName: FailureName.unknown));
  }

  @override
  List<Syllabus> getAllSyllabuses() {
    return _cachedSyllabuses ?? [];
  }
}
