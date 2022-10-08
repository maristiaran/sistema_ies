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

// class FailureState extends OperationState{
//     final String message;
//     const FailureState({required this.message});

//   @override
//   List<Object?> get props => [];
// }
class OperationStateNotifier extends StateNotifier<OperationState> {
  OperationStateNotifier({required OperationState initialState})
      : super(initialState);

  notifyStateChange(OperationState newOperationState) {
    state = newOperationState;
  }
}

abstract class Operation {
  late OperationState currentState;
  late OperationStateNotifier stateNotifier;
  late StateNotifierProvider<OperationStateNotifier, OperationState>
      stateNotifierProvider;

  changeState(OperationState newOperationState) {
    currentState = newOperationState;
    stateNotifier.notifyStateChange(newOperationState);
  }
}

abstract class UseCase extends Operation {
  UseCase();

  Future<void> initializeUseCase() async {
    await initializeRepositories();
    initializeStateNotifierProvider(initialState());
  }

  Future<void> initializeRepositories() async {}
  OperationState initialState();

  initializeStateNotifierProvider(OperationState initialState) {
    OperationStateNotifier newStateNotifier =
        OperationStateNotifier(initialState: initialState);
    stateNotifierProvider =
        StateNotifierProvider<OperationStateNotifier, OperationState>((ref) {
      return newStateNotifier;
    });
    stateNotifier = newStateNotifier;
  }
}
