import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:sistema_ies/checkStudentRecord/presentation/widget/student_record_card.dart';
import 'package:sistema_ies/core/data/utils/theme_data_system.dart';
// import 'package:sistema_ies/core/domain/entities/student.dart';
// import 'package:sistema_ies/checkStudentRecord/presentation/expanded_panel_sr_widget.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';
// import 'package:sistema_ies/checkStudentRecord/presentation/widget/user_info_w.dart';

class RegisterForExamPage extends ConsumerWidget {
  // final StudentRecordSubject studentRecordSubject;
  const RegisterForExamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            bool? varue = false;
            return CheckboxListTile(
                title: Text(
                    "${IESSystem().registerForExamUseCase.getSubjectsToRegister()[index]}"),
                subtitle: Text(
                    "Año: ${IESSystem().registerForExamUseCase.getSubjectsToRegister()[index].courseYear}, Aprobadas para poder rendir: ${IESSystem().registerForExamUseCase.getSubjectsToRegister()[index].examNeededForExamination}"),
                value: varue,
                onChanged: (bool? newValue) {
                  varue = newValue;
                  print(
                    "${IESSystem().registerForExamUseCase.getSubjectsToRegister()[index]}: $newValue $index",
                  );
                  print(IESSystem()
                      .registerForExamUseCase
                      .getStudentRecordMovements(index)[0]
                      .movementName);
                });
          },
        ))
      ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: IconButton(
          color: Color.fromARGB(255, 0, 0, 255),
          onPressed: () {
            print("Check");
          },
          icon: const Icon(Icons.check)),
    );
  }
}
