import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum RegistrationManagementStateName {
  init,
  failure,
}

class RegistrationManagementState extends OperationState {
  const RegistrationManagementState({required Enum stateName})
      : super(stateName: stateName);

  @override
  List<Object?> get props => [];
}

class InitRegistrationManagementState extends RegistrationManagementState {
  const InitRegistrationManagementState()
      : super(stateName: RegistrationManagementStateName.init);
}

class FailureRegistrationManagementState extends RegistrationManagementState {
  const FailureRegistrationManagementState()
      : super(stateName: RegistrationManagementStateName.failure);
}

class RegistrationManagementUseCase
    extends Operation<RegistrationManagementState> {
  RegistrationManagementUseCase()
      : super(const InitRegistrationManagementState());
}

// Proveedores de estadoooo
final registrationManagementUseCaseProvider =
    Provider<RegistrationManagementUseCase>((ref) {
  return RegistrationManagementUseCase();
});
