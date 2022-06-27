import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/entities/users.dart';
import 'package:sistema_ies/shared/repositories/users_repository_port.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

class UsersRepositoryFirestoreAdapter implements UsersRepositoryPort {
  final _firestoreAuth = FirebaseAuth.instance;

// @override
//   Future<Either<Failure, Success>> initRepositoryCaches() async {

//     return Right(Success('ok'));
//   }

  @override
  Future<Either<Failure, String>> getUserEmail({required int dni}) async {
    return Left(Failure(''));
  }

  @override
  Future<Either<Failure, IESUser>> signInUsingEmailAndPassword(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await _firestoreAuth
          .signInWithEmailAndPassword(email: email!, password: password!);

      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          return Right(IESUser(
              id: 1,
              firstname: userCredential.user!.email!,
              surname: userCredential.user!.email!,
              birthdate: DateTime(2000, 1, 1),
              uniqueNumber: 123456,
              roles: []));
        } else {
          return Left(Failure('Email no verificado'));
        }
      } else {
        return Left(Failure('Usuario y/o contraseña incorrecto'));
      }
    } on FirebaseAuthException {
      // String m = '';
      // if (e.message != null) {
      //   m = e.message!;
      // }
      // return Left(Failure(m));
      return Left(Failure('Usuario y/o contraseña incorrecto'));
    }
  }

  @override
  Future<Either<Failure, Success>> registerIncomingStudent(
      {required String email,
      required String password,
      required int dni,
      required String firstname,
      required String surname,
      required Syllabus syllabus}) async {
    try {
      UserCredential userCredential = await _firestoreAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        userCredential.user!.sendEmailVerification();
        return Right(Success('Ok'));
      } else {
        return Left(Failure(''));
      }
    } on FirebaseAuthException catch (e) {
      String m = '';
      if (e.message != null) {
        m = e.message!;
      }
      return Left(Failure(m));
    }
  }

  @override
  Future<Either<Failure, List<UserRole>>> getUserRoles({IESUser? user}) async {
    return Left(Failure(''));
  }

  @override
  Future<Either<Failure, List<UserRoleOperation>>> getUserRoleOperations(
      {UserRole? userRole}) async {
    return Left(Failure(''));
  }
}
