import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';

class MovementSelectorWidget extends ConsumerWidget {
  const MovementSelectorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String dropdownValue = ref.watch(movementProvider).currentMovement;
    return Center(
      child: Column(
        children: [
          DropdownButton(
            value: dropdownValue,
            items: MovementStudentRecordName.values
                .map<DropdownMenuItem<String>>((Enum value) {
              return DropdownMenuItem<String>(
                value: value.name,
                child: Text(value.name),
              );
            }).toList(),
            onChanged: (String? value) {
              ref.read(movementProvider.notifier).changeMovement(value!);
            },
          ),
        ],
        
      ),
    );
  }
}

class MovementState {
  MovementState(this.currentMovement);
  final String currentMovement;
}

class MovementStateNotifier extends StateNotifier<MovementState> {
  MovementStateNotifier()
      : super(MovementState(MovementStudentRecordName.courseApproved.name));

  void changeMovement(String currentMovement) {
    state = MovementState(currentMovement);
  }
}

final movementProvider =
    StateNotifierProvider<MovementStateNotifier, MovementState>((ref) {
  return MovementStateNotifier();
});
