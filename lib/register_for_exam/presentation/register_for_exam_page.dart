import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/data/utils/theme_data_system.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/register_for_exam/domain/register_for_exam.dart';
import 'package:sistema_ies/register_for_exam/utils/prints.dart';

class RegisterForExamPage extends ConsumerWidget {
  const RegisterForExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Subject> getSubjectsToRegister =
        IESSystem().registerForExamUseCase.getSubjectsToRegister();
    List regs = ref
        .watch(IESSystem().registerForExamUseCase.stateNotifierProvider)
        .props;

    final Map<Enum, Widget> widgetElements = {
      RegisterForExamStateName.init: RegisterForm(
          getSubjectsToRegister: getSubjectsToRegister, registers: regs),
      // RegisterForExamStateName.failure: const FailureRegisterPage(),
      RegisterForExamStateName.loading: const Center(
        child: CircularProgressIndicator(),
      )
    };

    ref.listen<OperationState>(
        IESSystem().registerForExamUseCase.stateNotifierProvider,
        (previous, next) {
      if (previous!.stateName == RegisterForExamStateName.failure) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Ups, hubo un error al realizar las inscripciones")));
      } else if (next.stateName == RegisterForExamStateName.loadnull) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: const Text("Falló al cargar las materias")));
      } else if (next.stateName == RegisterForExamStateName.success) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: const Text("Inscripto correctamente")));
      }
    });
    final currentBody = widgetElements.keys.firstWhere((element) =>
        element ==
        ref
            .watch(IESSystem().registerForExamUseCase.stateNotifierProvider)
            .stateName);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => IESSystem()
                .onUserLogged(IESSystem().homeUseCase.currentIESUser),
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Row(children: [
            Text(
              'Inscripción a mesas - ${IESSystem().homeUseCase.currentIESUser.firstname} ${IESSystem().homeUseCase.currentIESUser.surname}',
              style: TextStyle(
                  color: ThemeDataSW.themeDataSW.textTheme.titleLarge?.color),
              // style: ThemeDataSW.themeDataSW.appBarTheme.titleTextStyle,
              textAlign: TextAlign.justify,
            ),
          ]),
          automaticallyImplyLeading: false,
        ),
        body: widgetElements[currentBody]);
  }
}

class RegisterForm extends ConsumerWidget {
  const RegisterForm({
    Key? key,
    required this.getSubjectsToRegister,
    required this.registers,
  }) : super(key: key);

  final List<Subject> getSubjectsToRegister;
  final List registers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, child) {
      if (registers.length > 1) {
        return Center(
            child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          width: MediaQuery.of(context).size.width / 0.5,
          child: Column(children: [
            Text(
                '${IESSystem().registerForExamUseCase.studentRole.syllabus.name}:'),
            Expanded(
                child: ListView.builder(
              shrinkWrap: true,
              itemCount: getSubjectsToRegister.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                    title: Text("${getSubjectsToRegister[index]}"),
                    subtitle: Text(
                        "Año: ${getSubjectsToRegister[index].courseYear}, Aprobadas para poder rendir: ${getSubjectsToRegister[index].examNeededForExamination}"),
                    value:
                        registers[1].contains(getSubjectsToRegister[index].id),
                    onChanged: (bool? newValue) {
                      IESSystem()
                          .registerForExamUseCase
                          .toogleRegister(getSubjectsToRegister[index].id);
                    });
              },
            )),
            Container(
              width: MediaQuery.of(context).size.width / 0.5,
              height: 50,
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: TextButton(
                  onPressed: () {
                    prints("Checks: (");
                    IESSystem()
                        .registerForExamUseCase
                        .submitRegister(registers[1]);
                    prints("Submit succefull");
                    prints(") :skcehC");
                  },
                  child: const Text(
                    "Inscribirse",
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ]),
        ));
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}
