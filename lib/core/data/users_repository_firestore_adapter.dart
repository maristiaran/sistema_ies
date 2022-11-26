import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
// import 'package:sistema_ies/core/data/utils/iesuser_json_convertion.dart';
import 'package:sistema_ies/core/domain/entities/course.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_role_operation.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/repositories/syllabus_repository_port.dart';
import 'package:sistema_ies/core/domain/repositories/users_repository_port.dart';
import 'package:sistema_ies/core/domain/utils/datetime.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

class UsersRepositoryFirestoreAdapter implements UsersRepositoryPort {
  @override
  Future<Either<Failure, Success>> initRepositoryCaches() async {
    return Right(Success('ok'));
  }

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
    Future<IESUser> _getIESUserBasicInfo({required String idUser}) async {
      final DocumentSnapshot userDoc =
          (await firestoreInstance.collection("iesUsers").doc(idUser).get());

      // print("----${userDoc.id}");
      return (IESUser(
          id: idUser,
          firstname: userDoc.get('firstname'),
          surname: userDoc.get('surname'),
          birthdate: stringToDate(userDoc.get('birthdate')),
          dni: userDoc.get('dni'),
          email: userDoc.get('email')));
    }

    // try {
    IESUser iesUser = await _getIESUserBasicInfo(idUser: idUser);
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
              .getSyllabusesByAdministrativeResolution(
                  administrativeResolutions: docRole['syllabuses'])
              .fold((left) {
            return left;
          }, (right) {
            iesUser.addRole(Student(syllabuses: right));
          });

          break;
        case 'teacher':
          iesUser.addRole(Teacher(subjects: docRole['subjects']));
          break;
        case 'administrative':
          IESSystem()
              .getSyllabusesRepository()
              .getSyllabusesByAdministrativeResolution(
                  administrativeResolutions: docRole['syllabuses'])
              .fold((left) {
            return left;
          }, (right) {
            iesUser.addRole(Administrative(syllabuses: right));
          });

          break;
        case 'systemadmin':
          iesUser.addRole(SystemAdmin());
          break;
        default:
          iesUser.addRole(Manager());
          break;
      }
    }
    return Right(iesUser);
    // } catch (exception) {
    //   print(exception);
    //   return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
    // }
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
      // print(documentList.first.reference);
      // print(documentList.first.id);

      return getIESUserByID(idUser: documentList.first.id);
    } else {
      return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
    }
  }

  @override
  Future<Either<Failure, IESUser>> signInUsingEmailAndPassword(
      {String? email, String? password}) async {
    try {
      // print('$email - $password');
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
    } catch (failure) {
      // print(failure);
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
      // IESUser? iesUser = await getIESUserByDNI(dni: dni)
      //     .fold((failure) => null, (iesUser) => iesUser);

      // if (iesUser == null) {
      UserCredential userCredential = await firestoreAuthInstance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user != null) {
        final usersCollectionRef = firestoreInstance.collection('iesUsers');
        try {
          final docRef = await usersCollectionRef.add(<String, dynamic>{
            'firstname': firstname,
            'surname': surname,
            'birthdate': dateToString(birthdate),
            'dni': dni,
            'email': email
          });
          userCredential.user!.sendEmailVerification();

          return Right(IESUser(
              id: docRef.id,
              firstname: firstname,
              surname: surname,
              birthdate: birthdate,
              dni: dni,
              email: email));
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
      // } else {
      //   return Left(Failure(
      //       failureName: UsersRepositoryFailureName.userExists,
      //       message: 'El usuario ya existe'));
      // }
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
  Future<Either<Failure, List<UserRoleType>>> getUserRoles(
      {IESUser? user}) async {
    return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
  }

  @override
  Future<Either<Failure, List<UserRoleOperation>>> getUserRoleOperations(
      {UserRoleType? userRole}) async {
    return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
  }

  @override
  Future<Either<Failure, Success>> addUserRole(
      {required IESUser user, required UserRoleType userRole}) async {
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
      switch (userRole.name) {
        case UserRoleTypeName.student:
          Student studentRole = userRole as Student;
          json = {'syllabuses': studentRole.syllabuses};
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
      {required IESUser user, required UserRoleType userRole}) async {
    return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
  }

  @override
  Either<Failure, Success> updateStudentEducationalRecord(
      IESUser student, Syllabus syllabus, List<Course> updatedCourses) {
    return Left(Failure(failureName: FailureName.unknown));
  }

  @override
  Either<Failure, IESUser> registerAsIncomingStudent(
      {required IESUser iesUser, required Syllabus syllabus}) {
    Student studentRole;
    UserRole? studentRoleIfAny = iesUser.roles.firstWhereOrNull(((userRole) =>
        userRole.userRoleTypeName() == UserRoleTypeName.student));
    print("here: $studentRoleIfAny ");
    if (studentRoleIfAny == null) {
      print("here: ${iesUser.roles} 222");
      studentRole = Student(syllabuses: []);
      if (iesUser.roles.first.userRoleTypeName() == UserRoleTypeName.guest) {
        print("here: $studentRoleIfAny 333");
        iesUser.roles.removeAt(0);
        iesUser.roles.add(studentRole);
        iesUser.defaultRole = studentRole;
      } else {
        print("Why!!!${iesUser.roles}");
        print("Why!!!${iesUser.roles.first.userRoleTypeName().name}");
      }
    } else {
      studentRole = studentRoleIfAny as Student;
      print("here: $studentRoleIfAny 444");
    }

    if (studentRole.syllabuses.contains(syllabus)) {
      print("here: $studentRoleIfAny 555");
      return Left(Failure(failureName: FailureName.unknown));
    } else {
      print("here: $studentRoleIfAny 555");
      studentRole.syllabuses.add(syllabus);

      return Right(iesUser);
    }
  }
}
