import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sistema_ies/checkStudentRecord/presentation/widget/student_record_card.dart';
import 'package:sistema_ies/core/data/utils/theme_data_system.dart';
// import 'package:sistema_ies/core/domain/entities/student.dart';
// import 'package:sistema_ies/checkStudentRecord/presentation/expanded_panel_sr_widget.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
import 'package:sistema_ies/register_for_exam/domain/register_for_exam.dart';
// import 'package:sistema_ies/checkStudentRecord/presentation/widget/user_info_w.dart';

class RegisterForExamPage extends ConsumerWidget {
  // final StudentRecordSubject studentRecordSubject;
  const RegisterForExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Register> registers = ref.watch(registersProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () =>
              IESSystem().onUserLogged(IESSystem().homeUseCase.currentIESUser),
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
      body: Center(
          child: Column(children: [
        Text(
            '${IESSystem().registerForExamUseCase.studentRole.syllabus.name}:'),
        // Expanded(
        //   child: ListView.builder(
        //       shrinkWrap: true,
        //       itemCount: IESSystem()
        //           .registerForExamUseCase
        //           .getSubjectsToRegister()
        //           .length,
        //       itemBuilder: (context, index) {
        //         return Column(children: [
        //           Text(
        //               "${IESSystem().registerForExamUseCase.getSubjectsToRegister()[index]}:\n  Año: ${IESSystem().registerForExamUseCase.getSubjectsToRegister()[index].courseYear}, Aprobadas para poder rendir: ${IESSystem().registerForExamUseCase.getSubjectsToRegister()[index].examNeededForExamination}\n")
        //         ]);
        //       }),
        // ),
        Expanded(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount:
              IESSystem().registerForExamUseCase.getSubjectsToRegister().length,
          itemBuilder: (context, index) {
            // bool? varue = ref.watch(IESSystem()
            //     .registerForExamUseCase
            //     .stateNotifierProvider as ProviderListenable<bool?>);
            // bool? varue = false;
            return CheckboxListTile(
                title: Text(
                    "${IESSystem().registerForExamUseCase.getSubjectsToRegister()[index]}"),
                subtitle: Text(
                    "Año: ${IESSystem().registerForExamUseCase.getSubjectsToRegister()[index].courseYear}, Aprobadas para poder rendir: ${IESSystem().registerForExamUseCase.getSubjectsToRegister()[index].examNeededForExamination}"),
                value: registers[index].check,
                onChanged: (bool? newValue) {
                  ref
                      .read(registersProvider.notifier)
                      .toggle(registers[index].id);
                  // print(
                  //   "${IESSystem().registerForExamUseCase.getSubjectsToRegister()[index]}: $newValue $index",
                  // );
                  // print(IESSystem()
                  //     .registerForExamUseCase
                  //     .getStudentRecordMovements(index)[0]
                  //     .movementName);
                });
          },
        ))
      ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: IconButton(
          color: const Color.fromARGB(255, 0, 0, 255),
          onPressed: () {
            // for (final si
            //     in IESSystem().registerForExamUseCase.getSubjectsToRegister()) {
            //   print("Tick pass");
            //   ref.read(registersProvider.notifier).addRegister(
            //       Register(id: si.id, name: si.name, check: false));
            // }
            print("Checks: (");
            // print(registers);
            List registereds = [];
            for (var reg in registers) {
              if (reg.check) {
                // print(reg.name);
                registereds.add(reg.name);
              }
            }
            print(registereds);
            print(") :skcehC");
          },
          icon: const Icon(Icons.check)),
    );
  }
}

class RegisterListView extends ConsumerWidget {
  const RegisterListView({Key? key}) : super(key: key);

  // const RegisterListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Reconstruir el widget cuando cambia la lista de `Registers`
    List<Register> todos = ref.watch(registersProvider);
    for (final si
        in IESSystem().registerForExamUseCase.getSubjectsToRegister()) {
      print("RLV pass");
      ref
          .read(registersProvider.notifier)
          .addRegister(Register(id: si.id, name: si.name, check: false));
    }

    // Vamos a representar los `todos` en un ListView
    // return ListView(
    //   children: [
    //     for (final todo in todos)
    //       CheckboxListTile(
    //         value: todo.check,
    //         // Al tocar un `todo`, cambie su estado a completado
    //         onChanged: (value) =>
    //             ref.read(registersProvider.notifier).toggle(todo.id),
    //         title: Text(todo.name),
    //       ),
    //   ],
    // );
    return const Text("");
  }
}
