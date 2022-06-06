import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/shared/repositories/users_repository_port.dart';
import 'package:sistema_ies/shared/utils/states.dart';

//Registering State Names
const registeringInitStateName = 'registeringInit';
const registeringOnFailureStateName = 'registeringOnFailure';
const successfullyRegisteredStateName = 'successfullyRegisteredSignIn';

//Registering States
const registeringInitState = UseCaseState(registeringInitStateName, '');
const registeringOnFailureState =
    UseCaseState(registeringOnFailureStateName, 'Error');
const successfullyRegisteredState =
    UseCaseState(successfullyRegisteredStateName, 'Sign in successfully');

class RegisterIncomingStudentUseCase extends StateNotifier<List<UseCaseState>> {
  final UsersRepositoryPort usersRepository;
  final SyllabusRepositoryPort syllabusRepository;
  RegisterIncomingStudentUseCase(
      {required this.usersRepository, required this.syllabusRepository})
      : super([]) {
    init();
  }

  void init() {
    state = [...state, registeringInitState];
  }

  void registerAsIncomingUser(
      {required String userName,
      required String password,
      required int uniqueNumber,
      required String firstname,
      required String surname,
      required Syllabus syllabus}) async {
    usersRepository
        .registerIncomingStudent(
            email: userName,
            password: password,
            uniqueNumber: uniqueNumber,
            firstname: firstname,
            surname: surname,
            syllabus: syllabus)
        .then((signInResponse) => signInResponse.fold(
            (failure) => {
                  state = [...state, registeringOnFailureState]
                },
            (user) => {
                  state = [...state, successfullyRegisteredState]
                }));
  }
}
