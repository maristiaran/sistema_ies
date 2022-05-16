import 'package:either_dart/either.dart';
import 'package:sistema_ies/shared/entities/student.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/entities/users.dart';
import 'package:sistema_ies/shared/repositories/users_repository_port.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

class FakeUsersRepositoryAdapter implements UsersRepositoryPort {
  @override
  Either<Failure, User> getUser(int idUser) {
    Either<Failure, User> response;
    switch (idUser) {
      case 1:
        {
          response = Right(User(
              id: 1,
              firstname: 'Brian',
              surname: 'Barquesi',
              birthdate: DateTime(2000, 1, 1),
              uniqueNumber: 40000000,
              roles: [
                Student(
                    syllabus: Syllabus(
                        name: 'Tecnicatura Superior en Desarrollo de Software',
                        administrativeResolution: '501-DGE-19'))
              ]));
        }
        break;
      case 2:
        {
          response = Right(User(
              id: 2,
              firstname: 'Milena',
              surname: 'Peletay',
              birthdate: DateTime(2000, 1, 1),
              uniqueNumber: 40000000,
              roles: [
                Student(
                    syllabus: Syllabus(
                        name: 'Tecnicatura Superior en Desarrollo de Software',
                        administrativeResolution: '501-DGE-19'))
              ]));
        }
        break;
      case 3:
        {
          response = Right(User(
              id: 3,
              firstname: 'Mauro',
              surname: 'Rodriguez',
              birthdate: DateTime(2000, 1, 1),
              uniqueNumber: 40000000,
              roles: [
                Student(
                    syllabus: Syllabus(
                        name: 'Tecnicatura Superior en Desarrollo de Software',
                        administrativeResolution: '501-DGE-19'))
              ]));
        }
        break;
      default:
        {
          response = Left(Failure(''));
        }
    }
    return response;
  }
}
