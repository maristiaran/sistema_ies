import "package:firebase_core/firebase_core.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import 'package:sistema_ies/application/use_cases/users/auth.dart';
import 'package:sistema_ies/application/operation_utils.dart';
// import 'package:sistema_ies/application/use_cases/users/registering.dart';
import 'package:sistema_ies/firebase_options.dart';
import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/init_repository_adapters.dart';
import 'package:sistema_ies/shared/entities/user_role_operation.dart';
import 'package:sistema_ies/shared/entities/users.dart';
// import 'package:sistema_ies/shared/entities/users.dart';
import 'package:sistema_ies/shared/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/shared/repositories/users_repository_port.dart';

//Auth State Names
enum IESSystemStateName { iesAuth }

class IESSystem extends Operation {
  // IESSystem as a Singleton
  static final IESSystem _singleton = IESSystem._internal();
// Current User
  late IESUser? _currentIESUser;
  late UserRole? _currentIESUserRole;

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

  List<UserRole> getCurrentIESUserRoles() {
    if (_currentIESUser == null) {
      return [];
    } else {
      return _currentIESUser!.roles;
    }
  }

  int getCurrentIESUserRolesCount() {
    if (_currentIESUser == null) {
      return 0;
    } else {
      return _currentIESUser!.roles.length;
    }
  }

  List<UserRoleOperation> getCurrentIESUserRoleOperations() {
    //TODO: Add current role operations
    List<UserRoleOperation> iesUserRoleOperations = [];
    iesUserRoleOperations.add(RegisterAsNewStudentOperation());
    return iesUserRoleOperations;
  }

  setCurrentIESUser(IESUser newIESUser) {
    _currentIESUser = newIESUser;
  }

  IESUser? currentIESUserIfAny() {
    return _currentIESUser;
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
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   print("user: $user, currentUser: $_currentUser");
    //   if (user == null) {
    //     if (_currentUser != null) {
    //       onCurrentUserLogout();
    //     }
    //     print("m");
    //   } else {
    //     if (_currentUser != null) {
    //       print("S ");
    //       if ((!_currentUser!.emailVerified) && (user.emailVerified)) {
    //         onUserVerifiedEmail();
    //       }
    //     }
    //   }
    // });
    await startAuth();
  }

  startAuth() async {
    authUseCase = AuthUseCase(parentOperation: this);
    await authUseCase.initializeUseCase();
    changeState(const OperationState(stateName: IESSystemStateName.iesAuth));
    authUseCase.startLogin();
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
