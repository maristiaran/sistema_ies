import 'package:sistema_ies/application/operation_utils.dart';
import 'package:sistema_ies/application/use_cases/users/login.dart';
import 'package:sistema_ies/application/use_cases/users/registering.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';

//Registering states

//Auth State Names
enum AuthState { login, registering }

// AUTORIZATION
class AuthUseCase extends UseCase {
  // Use cases
  late LoginUseCase loginUseCase;
  late RegisteringUseCase registeringUseCase;

  //Accessors
  late List<Syllabus> syllabuses;
  late Syllabus currentSyllabus;

//Auth Use Case initialization
  AuthUseCase({required Operation parentOperation})
      : super(parentOperation: parentOperation);

  @override
  OperationState initialState() {
    return const OperationState(stateName: AuthState.login);
  }

  void startLogin() async {
    loginUseCase = LoginUseCase(authUseCase: this);
    await loginUseCase.initializeUseCase();
    changeState(const OperationState(stateName: AuthState.login));
    // loginUseCase.initLogin();
  }

  void restartLogin() async {
    changeState(const OperationState(stateName: AuthState.login));
    loginUseCase.initLogin();
  }

  void startRegisteringIncomingUser() async {
    registeringUseCase = RegisteringUseCase(parentOperation: this);
    await registeringUseCase.initializeUseCase();
    changeState(const OperationState(stateName: AuthState.registering));
    registeringUseCase.initRegistering();
  }
}
