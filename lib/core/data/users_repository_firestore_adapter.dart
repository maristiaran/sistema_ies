import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:collection/collection.dart';
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sistema_ies/core/data/init_repository_adapters.dart';
// import 'package:sistema_ies/core/data/utils/iesuser_json_convertion.dart';
import 'package:sistema_ies/core/domain/entities/course.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
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

  // Future<IESUser> _IESUserFromJSON(Map<String, dynamic> json) async {
  //   List<UserRole> roles = [];
  //   List<Map<String, dynamic>> docRoles = json['roles'];

  //   if (docRoles.isEmpty) {
  //     Guest guestRole = Guest();
  //     // defaultRoleIfAny = guestRole;
  //     roles = [guestRole];
  //   } else {
  //     for (Map<String, dynamic> docRole in docRoles) {
  //       switch (docRole['role']) {
  //         case 'student':
  //           await IESSystem()
  //               .getSyllabusesRepository()
  //               .getSyllabusByAdministrativeResolution(
  //                   administrativeResolution: docRole['syllabus'])
  //               .fold((left) {
  //             return left;
  //           }, (right) {
  //             roles.add(Student(syllabus: right));
  //           });

  //           break;
  //         case 'teacher':
  //           roles.add(Teacher(subjects: docRole['subject']));
  //           break;
  //         case 'administrative':
  //           await IESSystem()
  //               .getSyllabusesRepository()
  //               .getSyllabusByAdministrativeResolution(
  //                   administrativeResolution: docRole['syllabus'])
  //               .fold((left) {
  //             return left;
  //           }, (right) {
  //             roles.add(Administrative(syllabus: right));
  //           });

  //           break;
  //         case 'systemadmin':
  //           roles.add(SystemAdmin());
  //           break;
  //         default:
  //           roles.add(Manager());
  //           break;
  //       }
  //     }
  //   }
  //   return IESUser(
  //     id: json['id'],
  //     firstname: json['firstname'],
  //     surname: json['surname'],
  //     birthdate: stringToDate(json['birthdate']),
  //     dni: json['dni'],
  //     email: json['email'],
  //     roles: roles,
  //     // defaultRole: defaultRoleIfAny ?? roles.first
  //   );
  // }

  @override
  Future<Either<Failure, IESUser>> getIESUserByID(
      {required String idUser}) async {
    List<UserRole> roles = [];
    Map<String, Map<String, dynamic>> docRolesByID = {};
    var rolesReference = firestoreInstance
        .collection("iesUsers")
        .doc(idUser)
        .collection('roles');
    var jsonRoles = (await rolesReference.get()).docs;

    for (var jsRole in jsonRoles) {
      docRolesByID[jsRole.id] = jsRole.data();
    }

    final DocumentSnapshot userDoc =
        (await firestoreInstance.collection("iesUsers").doc(idUser).get());

    if (docRolesByID.isEmpty) {
      Guest guestRole = Guest();
      // defaultRoleIfAny = guestRole;
      roles = [guestRole];
    } else {
      for (var docRole in docRolesByID.entries) {
        switch (docRole.value['role']) {
          case 'student':
            await IESSystem()
                .getSyllabusesRepository()
                .getSyllabusByAdministrativeResolution(
                    administrativeResolution: docRole.value['syllabus'])
                .fold((left) {
              return left;
            }, (right) {
              roles.add(Student(syllabus: right));
            });

            break;
          case 'teacher':
            // final DocumentSnapshot userDoc = (await firestoreInstance
            //     .collection("iesUsers")
            //     .doc(idUser)
            //     .get());
            var teacherSubjectsRef =
                (firestoreInstance.collection("iesUsers").doc(idUser))
                    .collection('roles')
                    .doc(docRole.key)
                    .collection('subjects');
            var teacherSubjectIDs =
                (await teacherSubjectsRef.get()).docs.map((e) => e.id);
            List<Subject> teacherSubjects = [];
            // print('------------');
            // print(idUser);
            // print(docRole);
            // print(docRole['subjects']);
            // print('------------');
            for (String subjectID in teacherSubjectIDs) {
              Syllabus? aSyllabus = await syllabusesRepository
                  .getSyllabusByAdministrativeResolution(
                      administrativeResolution: subjectID.substring(0, 10))
                  .fold((failure) => null, (syllabus) => null);
              if (aSyllabus != null) {
                teacherSubjects.add(aSyllabus
                    .getSubjectIfAnyByID(int.parse(subjectID.substring(10)))!);
              }
            }
            roles.add(Teacher(subjects: teacherSubjects));
            break;
          case 'administrative':
            await IESSystem()
                .getSyllabusesRepository()
                .getSyllabusByAdministrativeResolution(
                    administrativeResolution: docRole.value['syllabus'])
                .fold((left) {
              return left;
            }, (right) {
              roles.add(Administrative(syllabus: right));
            });

            break;
          case 'systemadmin':
            roles.add(SystemAdmin());
            break;
          default:
            roles.add(Manager());
            break;
        }
      }
    }
    return Right(IESUser(
      id: idUser,
      firstname: userDoc.get('firstname'),
      surname: userDoc.get('surname'),
      birthdate: stringToDate(userDoc.get('birthdate')),
      dni: userDoc.get('dni'),
      email: userDoc.get('email'),
      roles: roles,
      // defaultRole: defaultRoleIfAny ?? roles.first
    ));
  }

  // return Left(Failure(failureName: FailureName.unknown));

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
  Future<List<IESUser>> getIESUsersByFullName(
      {required String surname, String? firstName}) async {
    List<IESUser> newIESUsers = [];
    await firestoreInstance
        .collection('iesUsers')
        .where('surname', isEqualTo: surname.trim())
        .limit(8)
        .get()
        .then((qs) async {
      for (var qsDoc in qs.docs) {
        await getIESUserByID(idUser: qsDoc.id).mapRight((newIESUser) {
          newIESUsers.add(newIESUser);
        });
//
      }
    });
    return newIESUsers;
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
    //When a newIESUser is registered, it has no roles entry en the DB,
    //although it has a Guest role in roles and as a defaultRole

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

          Guest guestRole = Guest();

          return Right(IESUser(
            id: docRef.id,
            firstname: firstname,
            surname: surname,
            birthdate: birthdate,
            dni: dni,
            email: email,
            roles: [guestRole],
            // defaultRole: guestRole)
          ));
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

  // @override
  // Future<Either<Failure, List<UserRoleType>>> getUserRoles(
  //     {IESUser? user}) async {
  //   return Left(Failure(failureName: UsersRepositoryFailureName.unknown));
  // }

  @override
  Future<Either<Failure, List<UserRoleOperation>>> getUserRoleOperations(
      {UserRoleType? userRole}) async {
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
      switch (userRole.userRoleTypeName()) {
        case UserRoleTypeName.student:
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

  @override
  Either<Failure, Success> updateStudentEducationalRecord(
      IESUser student, Syllabus syllabus, List<Course> updatedCourses) {
    return Left(Failure(failureName: FailureName.unknown));
  }

  @override
  Future<Either<Failure, Success>> registerAsIncomingStudent(
      {required IESUser iesUser, required Syllabus syllabus}) async {
    //When register as an incoming student...
    // final DocumentSnapshot userDoc =
    //     (await firestoreInstance.collection("iesUsers").doc(iesUser.id).get());
    final rolesRef = firestoreInstance
        .collection('iesUsers')
        .doc(iesUser.id)
        .collection('roles');
    try {
      await rolesRef.add(<String, dynamic>{
        'role': 'student',
        'syllabus': syllabus.administrativeResolution
      });
      return Right(Success('Ok'));
    } catch (e) {
      return Left(Failure(
          failureName: UsersRepositoryFailureName.unknown,
          message: 'Error desconocido en la creación del nuevo estudiante'));
    }
  }

  @override
  Future<List<IESUser>> getAllTeacherBySyllabus({required Syllabus syllabus}) {
    // TODO: implement getAllTeacherBySyllabus
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<UserRoleType>>> getUserRoles({IESUser? user}) {
    // TODO: implement getUserRoles
    throw UnimplementedError();
  }
}
