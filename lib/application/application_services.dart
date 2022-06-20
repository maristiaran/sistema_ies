import 'package:either_dart/either.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/application/use_cases/users/auth.dart';
import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/init_repository_adapters.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/shared/repositories/users_repository_port.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

//Auth State Names
enum IESAdminState { iesAuth }

class IESSystem extends Operation {
  // IESSystem as a Singleton
  static final IESSystem _singleton = IESSystem._internal();
  // Repositories
  final UsersRepositoryPort _usersRepository = usersRepository;
  final SyllabusesRepositoryPort _syllabusesRepository = syllabusesRepository;

  late OperationStateNotifier<IESAdminState> systemNotifier;
  late StateNotifierProvider systemStateProvider;
  // Use cases
  late AuthUseCase authUseCase;

  // IESSystem as a Singleton
  factory IESSystem() {
    return _singleton;
  }
  IESSystem._internal();

  UsersRepositoryPort getUsersRepository() {
    return _usersRepository;
  }

  SyllabusesRepositoryPort getSyllabusesRepository() {
    return _syllabusesRepository;
  }

  Future<Either<Failure, Success>> initializeUsersRepository() async {
    return _usersRepository.initRepositoryCaches();
  }

  Future<Either<Failure, Success>> initializeSyllabusesRepository() async {
    return _syllabusesRepository.initRepositoryCaches();
  }

  @override
  initializeStateNotifiers() {
    systemNotifier = OperationStateNotifier(
        initialState: const OperationState(stateName: IESAdminState.iesAuth));
    systemStateProvider = StateNotifierProvider<
        OperationStateNotifier<IESAdminState>, OperationState>((ref) {
      return systemNotifier;
    });
  }

  startLogin() async {
    await initializeUsersRepository();
    await initializeSyllabusesRepository();
    await _syllabusesRepository.initRepositoryCaches();
    List<Syllabus> syllabuses = [];
    await _syllabusesRepository
        .getActiveSyllabuses()
        .fold((left) => syllabuses = [], (right) => syllabuses = right);
    authUseCase = AuthUseCase(syllabuses: syllabuses);
    initializeStateNotifiers();
    authUseCase.initializeStateNotifiers();
  }
}
