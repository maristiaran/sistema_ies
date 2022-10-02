import 'package:either_dart/either.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
import 'package:sistema_ies/core/model/entities/syllabus.dart';
import 'package:sistema_ies/core/model/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/core/model/utils/responses.dart';

class SyllabusesRepositoryFirestoreAdapter implements SyllabusesRepositoryPort {
  List<Syllabus>? _cachedSyllabuses;

  @override
  Future<Either<Failure, List<Syllabus>>> getActiveSyllabuses() async {
    if (_cachedSyllabuses == null) {
      _cachedSyllabuses = [];
      for (var doc in (await firestoreInstance
          .collection('syllabuses')
          .get()
          .then((snapshot) => snapshot.docs))) {
        _cachedSyllabuses!.add(Syllabus.fromJson(doc.data()));
      }
    }
    return Right(_cachedSyllabuses!);
  }

  @override
  Future<Either<Failure, Syllabus>> getSyllabusByAdministrativeResolution(
      {required String administrativeResolution}) async {
    return Left(Failure(failureName: FailureName.unknown));
  }
}