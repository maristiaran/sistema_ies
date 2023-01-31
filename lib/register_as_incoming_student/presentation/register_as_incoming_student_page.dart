import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class RegisterAsIncomingStudentPage extends ConsumerWidget {
  RegisterAsIncomingStudentPage({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registeringAsIncomingStudentStatesProvider = ref.watch(
        IESSystem().registeringAsIncomingStudentUseCase.stateNotifierProvider);
    return Scaffold(
      body: Container(
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 255, 255, 255)),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 420),
            width: MediaQuery.of(context).size.width / 0.5,
            child: Form(
                key: _formKey,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 150),
                  child: Column(
                    // crossAxisAlignment: WrapCrossAlignment.center,
                    // alignment: WrapAlignment.center,
                    // //mainAxisAlignment: MainAxisAlignment.center,
                    // spacing: 10,
                    children: [
                      const Text('Planes de estudio:'),
                      const SizedBox(height: 10),
                      DropdownButton<Syllabus>(
                          //  value: null,
                          value: registeringAsIncomingStudentStatesProvider
                              .selectedSyllabusIfAny,
                          items: IESSystem()
                              .registeringAsIncomingStudentUseCase
                              .getRegisteringSyllabuses()
                              .map((s) => DropdownMenuItem<Syllabus>(
                                  value: s,
                                  child: Text(s.administrativeResolution)))
                              .toList(),
                          onChanged: (Syllabus? value) {
                            IESSystem()
                                .registeringAsIncomingStudentUseCase
                                .changeSelectedSyllabus(value);
                          }),
                      TextButton(
                          onPressed: () async {
                            IESSystem()
                                .registeringAsIncomingStudentUseCase
                                .registerAsIncomingStudent();
                          },
                          child: Container(
                              width: MediaQuery.of(context).size.width / 0.5,
                              height: 50,
                              decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 36, 110, 221),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: const Text(
                                '¡Me inscribo!',
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center,
                              ))),
                      TextButton(
                        onPressed: () async {
                          IESSystem()
                              .registeringAsIncomingStudentUseCase
                              .cancelRegistation();
                        },
                        child: Text(
                          'Cancelar',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
