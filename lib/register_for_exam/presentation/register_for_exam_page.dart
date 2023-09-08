import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/data/utils/theme_data_system.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/core/domain/utils/operation_utils.dart';
import 'package:sistema_ies/register_for_exam/domain/register_for_exam.dart';

class RegisterForExamPage extends ConsumerWidget {
  // final StudentRecordSubject studentRecordSubject;
  const RegisterForExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Subject> getSubjectsToRegister =
        IESSystem().registerForExamUseCase.getSubjectsToRegister();
    List<Register> registers = ref.watch(registersProvider);
    final Map<Enum, Widget> widgetElements = {
      RegisterForExamStateName.init: RegisterForm(
          getSubjectsToRegister: getSubjectsToRegister, registers: registers),
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
      }
    });
    // List registereds = IESSystem().registerForExamUseCase.registereds();
    // int indexed = 0;
    // for (dynamic s in subjects) {
    //   bool checked =
    //       registereds.where((element) => element.contains(s.name)).isNotEmpty;
    //   if (checked) {
    //     ref.read(registersProvider.notifier).toggle(registers[indexed].id);
    //   }
    //   indexed++;
    // }
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
  final List<Register> registers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                value: registers[index].check,
                onChanged: (bool? newValue) {
                  ref
                      .read(registersProvider.notifier)
                      .toggle(registers[index].id);
                  // ref.read(registersProvider.notifier).completeRegisters();
                  // print(
                  //   "${IESSystem().registerForExamUseCase.getSubjectsToRegister()[index]}: $newValue $index",
                  // );
                  // print(IESSystem()
                  //     .registerForExamUseCase
                  //     .getStudentRecordMovements(index)[0]
                  //     .movementName);
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
                print("Checks: (");
                // print(registers);
                List registereds = [];
                for (var reg in registers) {
                  if (reg.check) {
                    // print(reg.name);
                    registereds.add(reg.id);
                  }
                }
                print(registereds);
                IESSystem().registerForExamUseCase.submitRegister(registereds);
                print("Submit succefull");
                ref.read(registersProvider.notifier).update();
                print(") :skcehC");
              },
              child: const Text(
                "Inscribirse",
                style: TextStyle(color: Colors.white),
              )),
        )
      ]),
    ));
  }
}
