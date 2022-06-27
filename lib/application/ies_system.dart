import 'package:firebase_core/firebase_core.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/use_cases/users/auth.dart';
import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/firebase_options.dart';
import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/init_repository_adapters.dart';
import 'package:sistema_ies/shared/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/shared/repositories/users_repository_port.dart';

//Auth State Names
enum IESSystemStateName { iesAuth }

class IESSystem extends Operation {
  // IESSystem as a Singleton
  static final IESSystem _singleton = IESSystem._internal();
  // Repositories
  UsersRepositoryPort? _usersRepository;
  SyllabusesRepositoryPort? _syllabusesRepository;

  // Use cases
  late AuthUseCase authUseCase;

  // IESSystem as a Singleton
  factory IESSystem() {
    return _singleton;
  }
  IESSystem._internal();

  UsersRepositoryPort getUsersRepository() {
    _usersRepository ??= usersRepository;
    return _usersRepository!;
  }

  SyllabusesRepositoryPort getSyllabusesRepository() {
    _syllabusesRepository ??= syllabusesRepository;
    return _syllabusesRepository!;
  }

  initializeStatesAndStateNotifier() {
    OperationStateNotifier newStateNotifier = (OperationStateNotifier(
        initialState:
            const OperationState(stateName: IESSystemStateName.iesAuth)));
    stateNotifierProvider =
        StateNotifierProvider<OperationStateNotifier, OperationState>((ref) {
      return newStateNotifier;
    });
    stateNotifier = newStateNotifier;
  }

  initializeIESSystem() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    initializeStatesAndStateNotifier();
    await startAuth();
  }

  startAuth() async {
    authUseCase = AuthUseCase(parentOperation: this);
    await authUseCase.initializeUseCase();
    changeState(const OperationState(stateName: IESSystemStateName.iesAuth));
    authUseCase.startLogin();
  }
}
