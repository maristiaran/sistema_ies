import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/syllabus_fake_repository.dart';
import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/users_repository_firestore_adapter.dart';

final usersRepository = UsersRepositoryFirestoreAdapter();
final syllabusRepository = SyllabusRepositoryFakeAdapter();
