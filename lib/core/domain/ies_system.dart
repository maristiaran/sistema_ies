import "package:firebase_core/firebase_core.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
// import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/repositories/roles_and_operations_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/core/domain/repositories/users_repository_port.dart';
import 'package:sistema_ies/crud_roles/crud_roles.dart';
import 'package:sistema_ies/firebase_options.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
import 'package:sistema_ies/home/domain/home.dart';
import 'package:sistema_ies/login/domain/login.dart';
import 'package:sistema_ies/registering/domain/registering.dart';

enum IESSystemStateName { login, home, registering }

class IESSystem extends Operation {
  // IESSystem as a Singleton
  static final IESSystem _singleton = IESSystem._internal();
  // Current User
  IESUser? _currentIESUserIfAny;
  UserRole? _currentIESUserRole;

  // Repositories
  UsersRepositoryPort? _usersRepository;
  SyllabusesRepositoryPort? _syllabusesRepository;
  RolesAndOperationsRepositoryPort? _rolesAndOperationsRepository;

  // Use cases
  late LoginUseCase loginUseCase;
  late HomeUseCase homeUseCase;
  late RegisteringUseCase registeringUseCase;
  late CRUDRoleUseCase crudRolesUseCase;

  // IESSystem as a Singleton
  factory IESSystem() {
    return _singleton;
  }
  IESSystem._internal();

  IESUser? getCurrentIESUserIfAny() {
    return _currentIESUserIfAny;
  }

  UsersRepositoryPort getUsersRepository() {
    _usersRepository ??= usersRepository;
    return _usersRepository!;
  }

  SyllabusesRepositoryPort getSyllabusesRepository() {
    _syllabusesRepository ??= syllabusesRepository;
    return _syllabusesRepository!;
  }

  RolesAndOperationsRepositoryPort getRolesAndOperationsRepository() {
    _rolesAndOperationsRepository ??= rolesAndOperationsRepository;
    return _rolesAndOperationsRepository!;
  }

  List<UserRole> getCurrentIESUserRoles() {
    if (_currentIESUserIfAny == null) {
      // print("no user");
      return [];
    } else {
      // print("roles");
      // print(_currentIESUserIfAny!.roles.length);
      // print(_currentIESUserIfAny!.roles);

      return _currentIESUserIfAny!.roles;
    }
  }

  int getCurrentIESUserRolesCount() {
    if (_currentIESUserIfAny == null) {
      return 0;
    } else {
      return _currentIESUserIfAny!.roles.length;
    }
  }

  setCurrentRole(UserRole userRole) {
    _currentIESUserRole = userRole;
  }

  UserRole? getCurrentRoleIfAny() {
    return _currentIESUserRole;
  }

  setCurrentIESUserIfAny(IESUser? newIESUser) {
    _currentIESUserIfAny = newIESUser;
    if (newIESUser == null) {
      _currentIESUserRole = null;
    } else {
      if (newIESUser.roles.length == 1) {
        _currentIESUserRole = newIESUser.roles.first;
      } else {
        _currentIESUserRole = null;
      }
    }
  }

  IESUser? currentIESUserIfAny() {
    return _currentIESUserIfAny;
  }

  initializeStatesAndStateNotifier() {
    OperationStateNotifier newStateNotifier = (OperationStateNotifier(
        initialState:
            const OperationState(stateName: IESSystemStateName.home)));
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
    (_currentIESUserIfAny == null)
        ? await startLogin()
        : await onUserLogged(_currentIESUserIfAny!);
  }

  Future startLogin() async {
    loginUseCase = LoginUseCase();
    await loginUseCase.initializeUseCase();
    changeState(const OperationState(stateName: IESSystemStateName.login));
  }

  Future onUserLogged(IESUser userLogged) async {
    IESSystem().setCurrentIESUserIfAny(userLogged);
    homeUseCase = HomeUseCase();
    await homeUseCase.initializeUseCase();
    changeState(const OperationState(stateName: IESSystemStateName.home));
    // loginUseCase.initLogin();
  }

  Future startRegisteringNewUser() async {
    registeringUseCase = RegisteringUseCase();
    await registeringUseCase.initializeUseCase();
    changeState(
        const OperationState(stateName: IESSystemStateName.registering));
    // registeringUseCase.initRegistering();
  }

  void restartLogin() {
    changeState(const OperationState(stateName: IESSystemStateName.login));
    // loginUseCase.initLogin();
  }

  onCurrentUserLogout() {}
}
