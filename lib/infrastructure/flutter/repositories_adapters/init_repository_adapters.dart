import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/syllabus_firestore_repository.dart';
import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/users_repository_firestore_adapter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firestoreAuthInstance = FirebaseAuth.instance;
final firestoreInstance = FirebaseFirestore.instance;
final usersRepository = UsersRepositoryFirestoreAdapter();
final syllabusesRepository = SyllabusesRepositoryFirestoreAdapter();
