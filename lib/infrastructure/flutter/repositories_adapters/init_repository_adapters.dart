import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/syllabus_firestore_repository.dart';
import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/users_repository_firestore_adapter.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestoreInstance = FirebaseFirestore.instance;
final usersRepository = UsersRepositoryFirestoreAdapter();
final syllabusesRepository = SyllabusesRepositoryFirestoreAdapter();
