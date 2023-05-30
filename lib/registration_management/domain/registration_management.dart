import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';

enum RegistrationManagementStateName {
  init,
  failure,
}

class RegistrationManagementState extends OperationState {
  const RegistrationManagementState({required stateName})
      : super(stateName: stateName);

  @override
  List<Object?> get props => [];
}

class InitRegistrationManagementState extends RegistrationManagementState {}

class FailureRegistrationManagementState extends RegistrationManagementState {}

class RegistrationManagementUseCase
    extends Operation<RegistrationManagementState> {
  RegistrationManagementUseCase(RegistrationManagementState initialState)
      : super(initialState);
}
