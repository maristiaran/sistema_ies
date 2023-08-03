import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistema_ies/core/data/log_repository_fake.dart';
import 'package:sistema_ies/core/data/roles_and_operations_repository.dart';
import 'package:sistema_ies/core/data/studentrecord_datasource.dart';

import 'package:sistema_ies/core/data/syllabus_memory_repository.dart';
import 'package:sistema_ies/core/data/users_repository_firestore_adapter.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';

final firestoreAuthInstance = FirebaseAuth.instance;
final firestoreInstance = FirebaseFirestore.instance;
final usersRepository = UsersRepositoryFirestoreAdapter();
final syllabusesRepository = SyllabusesRepositoryMemoryAdapter();
final RolesAndOperationsRepositoryPort rolesAndOperationsRepository =
    RolesAndOperationsRepositoryMemoryAdapter();

final studentRecordDatasource = StudentDatasource();
final logsRepository = LogRepositoryFakeAdapter();
