import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/admin_student_record/presentation/widgets/movement_selector_wg.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class AdminStudentRecordPage extends ConsumerWidget {
  AdminStudentRecordPage({Key? key}) : super(key: key);
  // TODO: I have to do every forms
  final Map<Enum, Widget> widgetElements = {
    MovementStudentRecordName.courseApproved: const Text("courseApproved"),
    MovementStudentRecordName.courseApprovedWithAccreditation:
        const Text("courseApprovedWithAccreditation"),
    MovementStudentRecordName.courseFailedFree: const Text("courseFailedFree"),
    MovementStudentRecordName.courseFailedNonFree:
        const Text("courseFailedNonFree"),
    MovementStudentRecordName.finalExamApprovedByCertification:
        const Text("finalExamApprovedByCertification"),
    MovementStudentRecordName.courseRegistering:
        const Text("courseRegistering"),
    MovementStudentRecordName.finalExamApproved:
        const Text("finalExamApproved"),
    MovementStudentRecordName.finalExamNonApproved:
        const Text("finalExamNonApproved"),
    MovementStudentRecordName.unknow: const Text('Uknown')
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentBody = widgetElements.keys.firstWhere((element) =>
        element.name == ref.watch(movementProvider).currentMovement);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              IESSystem().onUserLogged(IESSystem().homeUseCase.currentIESUser),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const MovementSelectorWidget(),
          Container(child: widgetElements[currentBody])
        ],
      ),
    );
  }
}
// TODO: I have to choose how it will to works