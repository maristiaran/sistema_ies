import "package:firebase_core/firebase_core.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:sistema_ies/application/use_cases/all_roles/crud_roles.dart';
import 'package:sistema_ies/application/use_cases/users/home.dart';
import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/application/use_cases/users/login.dart';
import 'package:sistema_ies/application/use_cases/users/registering.dart';
import 'package:sistema_ies/firebase_options.dart';
import 'package:sistema_ies/infrastructure/repositories_adapters/init_repository_adapters.dart';
import 'package:sistema_ies/shared/entities/user_role_operation.dart';
import 'package:sistema_ies/shared/entities/users.dart';
import 'package:sistema_ies/shared/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/shared/repositories/users_repository_port.dart';
import 'package:sistema_ies/shared/utils/observable.dart';

//Auth State Names
enum IESSystemStateName { login, home, registering }

class IESSystem extends Operation {
  // IESSystem as a Singleton
  static final IESSystem _singleton = IESSystem._internal();
  Observable obsSystemState = Observable();
// Current User
  IESUser? _currentIESUserIfAny;
  UserRole? _currentIESUserRoleIfAny;

  // Repositories
  UsersRepositoryPort? _usersRepository;
  SyllabusesRepositoryPort? _syllabusesRepository;

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

  List<UserRole> getCurrentIESUserRoles() {
    if (_currentIESUserIfAny == null) {
      return [];
    } else {
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

  List<UserRoleOperation> getCurrentIESUserRoleOperations() {
    List<UserRoleOperation> iesUserRoleOperations = [];

    switch (_currentIESUserRoleIfAny!.userRoleName()) {
      case UserRoleNames.student:
        iesUserRoleOperations.add(RegisterAsNewStudentOperation());
    }
    iesUserRoleOperations.add(RegisterAsNewStudentOperation());
    return iesUserRoleOperations;
  }

  setCurrentIESUserIfAny(IESUser? newIESUser) {
    _currentIESUserIfAny = newIESUser;
    if (newIESUser == null) {
      _currentIESUserRoleIfAny = null;
    } else {
      if (newIESUser.roles.length == 1) {
        _currentIESUserRoleIfAny = newIESUser.roles.first;
      } else {
        _currentIESUserRoleIfAny = null;
      }
    }
  }

  IESUser? currentIESUserIfAny() {
    return _currentIESUserIfAny;
  }

  initializeStatesAndStateNotifier() {
    OperationStateNotifier newStateNotifier = (OperationStateNotifier(
        initialState:
            const OperationState(stateName: IESSystemStateName.login)));
    stateNotifierProvider =
        StateNotifierProvider<OperationStateNotifier, OperationState>((ref) {
      return newStateNotifier;
    });
    stateNotifier = newStateNotifier;
  }

  initializeIESSystem() async {
    // (await getSyllabusesRepository().getActiveSyllabuses()).fold((left) => null,
    //     (syllabuses) {
    //   for (Syllabus syllabus in syllabuses) {
    //     print('---------------------------------------');
    //     print(syllabus.name);
    //     print('---------------------------------------');
    //     for (Subject subject in syllabus.subjects) {
    //       print(
    //           '${subject.id}-${subject.name} ,para cursar: ${subject.coursesNeededForCoursing}, para rendir: ${subject.examNeededForExamination}');
    //     }
    //   }
    // });

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    initializeStatesAndStateNotifier();
    (_currentIESUserIfAny == null) ? await startLogin() : await startHome();
  }

  Future startLogin() async {
    loginUseCase = LoginUseCase();
    await loginUseCase.initializeUseCase();
    changeState(const OperationState(stateName: IESSystemStateName.login));
    loginUseCase.initLogin();
    obsSystemState.notifyObservers(IESSystemStateName.login);
  }

  Future startHome() async {
    homeUseCase = HomeUseCase();
    await homeUseCase.initializeUseCase();
    changeState(const OperationState(stateName: IESSystemStateName.home));
    loginUseCase.initLogin();
  }

  Future startRegisteringNewUser() async {
    registeringUseCase = RegisteringUseCase();
    await registeringUseCase.initializeUseCase();
    changeState(
        const OperationState(stateName: IESSystemStateName.registering));
    registeringUseCase.initRegistering();
    obsSystemState.notifyObservers(IESSystemStateName.registering);
  }

  void restartLogin() {
    changeState(const OperationState(stateName: IESSystemStateName.login));
    loginUseCase.initLogin();
  }

  onCurrentUserLogout() {}
  // onUserVerifiedEmail() {
  //   print("qq");
  //   if ((currentState.stateName == IESSystemStateName.iesAuth) &&
  //       (authUseCase.currentState.stateName == AuthState.registering) &&
  //       (authUseCase.registeringUseCase.currentState.stateName ==
  //           RegisteringStateName.registeredWaitingEmailValidation)) {
  //     authUseCase.registeringUseCase.onUserVerifiedEmail();
  //   }
  // }
}
