import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/shared/repositories/users_repository_port.dart';
import 'package:sistema_ies/shared/utils/states.dart';

//Login State Names
const loginInitStateName = 'loginInit';
const loginOnFailureStateName = 'loginOnFailure';
const successfullySignInStateName = 'successfullySignIn';

//Login States
const loginInitState = UseCaseState(loginInitStateName, '');
const loginOnFailureState = UseCaseState(loginOnFailureStateName, 'Error');
const successfullySignInState =
    UseCaseState(successfullySignInStateName, 'Sign in successfully');

class LoginUseCase extends StateNotifier<List<UseCaseState>> {
  final UsersRepositoryPort usersRepository;
  LoginUseCase({required this.usersRepository}) : super([]) {
    init();
  }

  void init() {
    state = [...state, loginInitState];
  }

  void signIn(String userName, String password) async {
    usersRepository
        .signInUsingEmailAndPassword(email: userName, password: password)
        .then((signInResponse) => signInResponse.fold(
            (failure) => {
                  state = [...state, loginOnFailureState]
                },
            (user) => {
                  state = [...state, successfullySignInState]
                }));
  }
}
