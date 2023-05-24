import 'package:either_dart/either.dart';
import 'package:flutter/widgets.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/core/domain/utils/responses.dart';

enum PairSubjectTeacherStateName {
  init,
  failure,
}

class PairSubjectTeacherState extends OperationState {
  const PairSubjectTeacherState({required stateName})
      : super(stateName: stateName);

  @override
  List<Object?> get props => [];
}

class InitPairSubjectTeacherState extends PairSubjectTeacherState {
  final Syllabus? currentSyllabusIfAny;
  final List<IESUser> selectedTeachers;
  final Map<Subject, IESUser> subjectTeacherPairs;

  const InitPairSubjectTeacherState(
      {required stateName,
      required this.currentSyllabusIfAny,
      required this.selectedTeachers,
      required this.subjectTeacherPairs})
      : super(stateName: stateName);

  @override
  List<Object?> get props =>
      [currentSyllabusIfAny, selectedTeachers, subjectTeacherPairs];
}

class FailurePairSubjectTeacherState extends PairSubjectTeacherState {
  const FailurePairSubjectTeacherState({required stateName})
      : super(stateName: stateName);

  @override
  List<Object?> get props => [];
}

class PairSubjectTeacherUseCase extends Operation<PairSubjectTeacherState> {
//Auth Use Case initialization
  PairSubjectTeacherUseCase()
      : super(const PairSubjectTeacherState(
            stateName: PairSubjectTeacherStateName.init));

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

  Future changeCurrentSyllabus(Syllabus syllabus) async {}
  Future searchTeachers(String lastnameFirstLetters) async {}
}
