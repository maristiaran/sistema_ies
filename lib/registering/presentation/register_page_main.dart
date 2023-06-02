import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/registering/presentation/register_form.dart';
import 'package:sistema_ies/registering/presentation/widget/failure.dart';
import '../../core/domain/utils/operation_utils.dart';
import '../domain/registering.dart';

class RegisterPage extends ConsumerWidget {
  RegisterPage({Key? key}) : super(key: key);
  final Map<Enum, Widget> _widgetElements = {
    RegisteringStateName.init: RegisterBody(),
    RegisteringStateName.loading: const Center(
      child: CircularProgressIndicator(),
    ),
    RegisteringStateName.failure: const FlailurePage()
  };
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<OperationState>(
        IESSystem().registeringUseCase.stateNotifierProvider, (previous, next) {
      if (next.stateName == RegisteringStateName.failure) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content:
                Text("Ha ocurrido un error, inténtelo de nuevo más tarde")));
      } else if (next.stateName == RegisteringStateName.success) {
        IESSystem().registeringUseCase.returnToLogin();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: const Text("Registro con éxito")));
      } else if (next.stateName == RegisteringStateName.verificationEmailSent) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: const Text(
                "Registro con éxito. Revise su bandeja de correo electrónico")));
      }
    });
    final body = _widgetElements.keys.firstWhere((element) =>
        element ==
        ref
            .watch(IESSystem().registeringUseCase.stateNotifierProvider)
            .stateName);
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Registro',
            style: Theme.of(context).textTheme.displayLarge,
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 198, 198, 198),
        ),
        body: _widgetElements[body]);
  }
}
