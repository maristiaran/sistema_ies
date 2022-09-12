import 'package:either_dart/either.dart';
import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/init_repository_adapters.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

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
