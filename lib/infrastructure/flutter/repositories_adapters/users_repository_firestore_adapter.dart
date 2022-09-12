import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistema_ies/application/ies_system.dart';
import 'package:sistema_ies/infrastructure/flutter/repositories_adapters/init_repository_adapters.dart';
import 'package:sistema_ies/shared/entities/administrative.dart';
import 'package:sistema_ies/shared/entities/manager.dart';
import 'package:sistema_ies/shared/entities/student.dart';
import 'package:sistema_ies/shared/entities/system_admin.dart';
import 'package:sistema_ies/shared/entities/teacher.dart';
import 'package:sistema_ies/shared/entities/user_role_operation.dart';
import 'package:sistema_ies/shared/entities/users.dart';
import 'package:sistema_ies/shared/repositories/users_repository_port.dart';
import 'package:sistema_ies/shared/utils/datetime.dart';
import 'package:sistema_ies/shared/utils/responses.dart';

class UsersRepositoryFirestoreAdapter implements UsersRepositoryPort {
  @override
  Future<Either<Failure, Success>> resetPasswordEmail(
      {required String email}) async {
    try {
      await firestoreAuthInstance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException {
      return Left(Failure(
          failureName: UsersRepositoryFailureName.cantResetPassword,
          message: 'No se pudo restaurar la contraseña'));
    }
    return Right(Success(''));
  }

  @override
  Future<Either<Failure, IESUser>> getIESUserByID(
      {required String idUser}) async {
    List<Map<String, dynamic>> docRoles;
    try {
      final DocumentSnapshot userDoc =
          (await firestoreInstance.collection("iesUsers").doc(idUser).get());

      IESUser iesUser = (IESUser(
          firstname: userDoc.get('firstname'),
          surname: userDoc.get('surname'),
          birthdate: stringToDate(userDoc.get('birthdate')),
          dni: userDoc.get('dni'),
          email: userDoc.get('email')));

      try {
        docRoles = (await firestoreInstance
                .collection("iesUsers")
                .doc(idUser)
                .collection('roles')
                .get())
            .docs
            .map((e) => e.data())
            .toList();
      } catch (e) {
        docRoles = [];
      }

      for (Map<String, dynamic> docRole in docRoles) {
        switch (docRole['userRoleName']) {
          case 'student':
            IESSystem()
                .getSyllabusesRepository()
                .getSyllabusByAdministrativeResolution(
                    administrativeResolution: docRole['syllabus'])
                .fold((left) {
              return left;
            }, (right) {
              iesUser.addRole(Student(user: iesUser, syllabus: right));
            });

            break;
          case 'teacher':
            iesUser.addRole(Teacher(user: iesUser, course: docRole['course']));
            break;
          case 'administrative':
            IESSystem()
                .getSyllabusesRepository()
                .getSyllabusByAdministrativeResolution(
                    administrativeResolution: docRole['syllabus'])
                .fold((left) {
              return left;
            }, (right) {
              iesUser.addRole(Administrative(user: iesUser, syllabus: right));
            });

            break;
          case 'systemadmin':
            iesUser.addRole(SystemAdmin(user: iesUser));
            break;
          default:
            iesUser.addRole(Manager(user: iesUser));
            break;
        }
      }
      return Right(iesUser);
    } catch (exception) {
      return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
    }
  }

  @override
  Future<Either<Failure, IESUser>> getIESUserByDNI({required int dni}) async {
    List<DocumentSnapshot> documentList;
    documentList = (await firestoreInstance
            .collection("iesUsers")
            .where("dni", isEqualTo: dni)
            .get())
        .docs;

    if (documentList.length == 1) {
      return getIESUserByID(idUser: documentList.first.id);
    } else {
      return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
    }
  }

  @override
  Future<Either<Failure, IESUser>> getIESUserByEmail(
      {required String email}) async {
    List<DocumentSnapshot> documentList;
    documentList = (await firestoreInstance
            .collection("iesUsers")
            .where("email", isEqualTo: email)
            .get())
        .docs;

    if (documentList.length == 1) {
      return getIESUserByID(idUser: documentList.first.id);
    } else {
      return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
    }
  }

  @override
  Future<Either<Failure, IESUser>> signInUsingEmailAndPassword(
      {String? email, String? password}) async {
    try {
      UserCredential userCredential = await firestoreAuthInstance
          .signInWithEmailAndPassword(email: email!, password: password!);
      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          return getIESUserByEmail(email: email);
        } else {
          return Left(Failure(
              failureName: UsersRepositoryFailureName.notVerifiedEmail,
              message: 'Email no verificado'));
        }
      } else {
        return Left(Failure(
            failureName: UsersRepositoryFailureName.unknown,
            message: 'Usuario y/o contraseña incorrecto'));
      }
    } on FirebaseAuthException {
      // String m = '';
      // if (e.message != null) {
      //   m = e.message!;
      // }
      // return Left(Failure(m));
      return Left(Failure(
          failureName: UsersRepositoryFailureName.unknown,
          message: 'Usuario y/o contraseña incorrecto'));
    }
  }

  @override
  Either<Failure, Success> reSendEmailVerification() {
    if (firestoreAuthInstance.currentUser == null) {
      return Left(Failure(
          failureName: UsersRepositoryFailureName.cantSentVerificationEmail,
          message: 'No se pudo enviar el email de verificación'));
    } else {
      firestoreAuthInstance.currentUser!.sendEmailVerification();
      return Right(Success(''));
    }
  }

  @override
  Future<Either<Failure, IESUser>> registerNewIESUser(
      {required String email,
      required String password,
      required int dni,
      required String firstname,
      required String surname,
      required DateTime birthdate}) async {
    try {
      IESUser? iesUser = await getIESUserByDNI(dni: dni)
          .fold((failure) => null, (iesUser) => iesUser);

      if (iesUser == null) {
        UserCredential userCredential = await firestoreAuthInstance
            .createUserWithEmailAndPassword(email: email, password: password);
        if (userCredential.user != null) {
          // final User user = userCredential.user!;
          IESUser newIESUser = IESUser(
              firstname: firstname,
              surname: surname,
              birthdate: birthdate,
              dni: dni,
              email: email);
          final iesUserDoc = firestoreInstance.collection('iesUsers').doc();
          final Map<String, dynamic> json = {
            'firstname': firstname,
            'surname': surname,
            'dni': dni,
            'email': email,
            'birthdate': dateToString(birthdate)
          };
          try {
            iesUserDoc.set(json);
            return Right(newIESUser);
          } catch (e) {
            Left(Failure(
                failureName: UsersRepositoryFailureName.unknown,
                message: 'Error desconocido en la creación del nuevo usuario'));
          }
        } else {
          return Left(Failure(
              failureName: UsersRepositoryFailureName.unknown,
              message: 'Error desconocido en la creación del nuevo usuario'));
        }
      } else {
        return Left(Failure(
            failureName: UsersRepositoryFailureName.userExists,
            message: 'El usuario ya existe'));
      }
    } on FirebaseAuthException catch (e) {
      String m = '';
      if (e.message != null) {
        m = e.message!;
      }
      return Left(
          Failure(failureName: UsersRepositoryFailureName.unknown, message: m));
    }
    return Left(Failure(
        failureName: UsersRepositoryFailureName.unknown,
        message: 'Error desconocido en la creación del nuevo usuario'));
  }

  @override
  Future<bool> getCurrentUserIsEMailVerified() async {
    if ((firestoreAuthInstance.currentUser != null)) {
      await firestoreAuthInstance.currentUser!.reload();

      return firestoreAuthInstance.currentUser!.emailVerified;
    } else {
      return false;
    }
  }

  @override
  Future<Either<Failure, List<UserRole>>> getUserRoles({IESUser? user}) async {
    return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
  }

  @override
  Future<Either<Failure, List<UserRoleOperation>>> getUserRoleOperations(
      {UserRole? userRole}) async {
    return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
  }

  @override
  Future<Either<Failure, Success>> addUserRole(
      {required IESUser user, required UserRole userRole}) async {
    List<DocumentSnapshot> documentList;
    final DocumentReference<Map<String, dynamic>> roleDoc;
    final Map<String, dynamic> json;
    documentList = (await firestoreInstance
            .collection("iesUsers")
            .where("email", isEqualTo: user.email)
            .get())
        .docs;
    if (documentList.length == 1) {
      roleDoc =
          firestoreInstance.collection('iesUsers').doc(documentList.first.id);
    } else {
      return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
    }

    try {
      switch (userRole.userRoleName()) {
        case UserRoleNames.student:
          Student studentRole = userRole as Student;
          json = {'syllabus': studentRole.syllabus};
          break;
        default:
          json = {};
      }
      if (json.isEmpty) {
        return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
      } else {
        roleDoc.set(json);
        return Right(Success(''));
      }
    } on Failure {
      return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
    }
  }

  @override
  Future<Either<Failure, Success>> removeUserRole(
      {required IESUser user, required UserRole userRole}) async {
    return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
  }
}
