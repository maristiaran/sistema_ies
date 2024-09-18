import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/admin_course/domain/admin_course.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/login/domain/login.dart';
import 'package:sistema_ies/login/presentation/widgets/failure.dart';
import 'package:sistema_ies/login/presentation/login_form.dart';

class AdminCoursePage extends ConsumerWidget {
  const AdminCoursePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Map<Enum, Widget> widgetElements = {
      AdminCourseName.init: LoginForm(),
      AdminCourseName.failure: const FlailureLoginPage(),
      AdminCourseName.successfullySignIn: const Center(),
      AdminCourseName.loading: const Center(
        child: CircularProgressIndicator(),
      )
    };
    ref.listen<OperationState>(IESSystem().loginUseCase.stateNotifierProvider,
        (previous, next) {
      if (previous!.stateName == AdminCourseName.failure) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Usuario o contraseña incorrecta")));
      } else if (next.stateName == AdminCourseName.emailNotVerifiedFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: const Text(
                "Su email no ha sido verificado aún. Revise si casilla de correos por favor")));
      }
    });
    final currentBody = widgetElements.keys.firstWhere((element) =>
        element ==
        ref.watch(IESSystem().loginUseCase.stateNotifierProvider).stateName);
    return Scaffold(body: widgetElements[currentBody]);
  }
}
