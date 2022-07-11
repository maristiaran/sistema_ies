import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistema_ies/shared/entities/syllabus.dart';
import 'package:sistema_ies/shared/entities/users.dart';
import 'package:sistema_ies/shared/repositories/users_repository_port.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

class UsersRepositoryFirestoreAdapter implements UsersRepositoryPort {
  final _firestoreAuth = FirebaseAuth.instance;

  @override
  Future<Either<Failure, Success>> resetPasswordEmail(
      {required String email}) async {
    try {
      await _firestoreAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      return Left(Failure(
          failureName: FailureName.cantResetPassword,
          message: 'No se pudo restaurar la contraseña'));
    }
    return Right(Success(''));
  }

  @override
  Future<Either<Failure, String>> getUserEmail({required int dni}) async {
    return Left(Failure(failureName: FailureName.unknown));
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
              emailVerified: userCredential.user!.emailVerified,
              roles: []));
        } else {
          return Left(Failure(
              failureName: FailureName.notVerifiedEmail,
              message: 'Email no verificado'));
        }
      } else {
        return Left(Failure(
            failureName: FailureName.notVerifiedEmail,
            message: 'Usuario y/o contraseña incorrecto'));
      }
    } on FirebaseAuthException {
      // String m = '';
      // if (e.message != null) {
      //   m = e.message!;
      // }
      // return Left(Failure(m));
      return Left(Failure(
          failureName: FailureName.notVerifiedEmail,
          message: 'Usuario y/o contraseña incorrecto'));
    }
  }

  @override
  Either<Failure, Success> reSendEmailVerification() {
    if (_firestoreAuth.currentUser == null) {
      return Left(Failure(
          failureName: FailureName.cantSentVerificationEmail,
          message: 'No se pudo enviar el email de verificación'));
    } else {
      _firestoreAuth.currentUser!.sendEmailVerification();
      return Right(Success(''));
    }
  }

  @override
  Future<Either<Failure, User>> registerIncomingStudent(
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
        return Right(userCredential.user!);
      } else {
        return Left(Failure(failureName: FailureName.unknown));
      }
    } on FirebaseAuthException catch (e) {
      String m = '';
      if (e.message != null) {
        m = e.message!;
      }
      return Left(Failure(failureName: FailureName.unknown, message: m));
    }
  }

  @override
  Future<bool> getCurrentUserIsEMailVerified() async {
    if ((_firestoreAuth.currentUser != null)) {
      await _firestoreAuth.currentUser!.reload();

      return _firestoreAuth.currentUser!.emailVerified;
    } else {
      return false;
    }
  }

  @override
  Future<Either<Failure, List<UserRole>>> getUserRoles({IESUser? user}) async {
    return Left(Failure(failureName: FailureName.unknown));
  }

  @override
  Future<Either<Failure, List<UserRoleOperation>>> getUserRoleOperations(
      {UserRole? userRole}) async {
    return Left(Failure(failureName: FailureName.unknown));
  }
}
