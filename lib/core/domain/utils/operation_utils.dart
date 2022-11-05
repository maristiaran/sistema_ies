import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class OperationState extends Equatable {
  final Enum stateName;

  const OperationState({required this.stateName});

  @override
  List<Object?> get props => [];
}

class OperationStateNotifier<T extends OperationState>
    extends StateNotifier<T> {
  OperationStateNotifier({required T initialState}) : super(initialState);

  notifyStateChange(T newOperationState) {
    state = newOperationState;
  }
}

abstract class Operation<T extends OperationState> {
  late T currentState;
  late OperationStateNotifier stateNotifier;
  late StateNotifierProvider<OperationStateNotifier<T>, T>
      stateNotifierProvider;

  changeState(T newOperationState) {
    currentState = newOperationState;
    stateNotifier.notifyStateChange(newOperationState);
  }
}

abstract class UseCase<T extends OperationState> extends Operation<T> {
  T initializeUseCase();

  initializeStateNotifierProvider(T initialState) {
    OperationStateNotifier<T> newStateNotifier =
        OperationStateNotifier<T>(initialState: initialState);
    stateNotifierProvider =
        StateNotifierProvider<OperationStateNotifier<T>, T>((ref) {
      return newStateNotifier;
    });
    stateNotifier = newStateNotifier;
  }

  UseCase() {
    initializeStateNotifierProvider(initializeUseCase());
  }
}
