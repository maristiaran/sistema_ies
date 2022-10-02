import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sistema_ies/core/data/syllabus_memory_repository.dart';
import 'package:sistema_ies/core/data/users_repository_firestore_adapter.dart';

final firestoreAuthInstance = FirebaseAuth.instance;
final firestoreInstance = FirebaseFirestore.instance;
final usersRepository = UsersRepositoryFirestoreAdapter();
final syllabusesRepository = SyllabusesRepositoryMemoryAdapter();
