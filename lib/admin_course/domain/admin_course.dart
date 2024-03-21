import 'package:either_dart/either.dart';
import 'package:sistema_ies/admin_course/presentation/admin_course_page.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

enum AdminCourseName {
  init,
  failure,
}

class AdminCourseState extends OperationState {
  const AdminCourseState({required stateName}) : super(stateName: stateName);

  @override
  List<Object?> get props => [];
}

class InitAdminCourseState extends AdminCourseState {
  final Syllabus? currentSyllabusIfAny;
  final List<IESUser> selectedTeachers;
  final Map<Subject, IESUser> subjectTeacherPairs;

  const InitAdminCourseState(
      {required stateName,
      required this.currentSyllabusIfAny,
      required this.selectedTeachers,
      required this.subjectTeacherPairs})
      : super(stateName: stateName);

  @override
  List<Object?> get props =>
      [currentSyllabusIfAny, selectedTeachers, subjectTeacherPairs];
}

class FailureAdminCourseState extends AdminCourseState {
  const FailureAdminCourseState({required stateName})
      : super(stateName: stateName);

  @override
  List<Object?> get props => [];
}

class AdminCourseUseCase extends Operation<AdminCourseState> {
//Auth Use Case initialization
  AdminCourseUseCase()
      : super(const AdminCourseState(stateName: AdminCourseName.init));

  Future pairSubjectTeacher(
      IESUser teacher, Subject subject, DateTime date) async {
    IESSystem()
        .getTeachersRepository()
        .pairSubjectTeacher(teacher, subject, date)
        .then((errorOrSuccess) => errorOrSuccess.fold((failure) {
              //fallo
            }, (succes) {
              //      exito
            }));
  }

  Future unpairSubjectTeacher(
      IESUser teacher, Subject subject, DateTime date) async {
    Either<Failure, Success> response = await IESSystem()
        .getTeachersRepository()
        .pairSubjectTeacher(teacher, subject, date);
    response.fold((left) => changeState, (right) => changeState);
  }

  Future changeCurrentSyllabus(Syllabus syllabus) async {
    return IESSystem().getSyllabusesRepository().getAllSyllabuses();
  }

  Future searchTeachers(String lastnameFirstLetters) async {
    return IESSystem().getTeachersRepository();
  }
}
