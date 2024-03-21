import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class AddingTeacherDialog extends StatefulWidget {
  final UserRole? newuserRoleIfAny;
  const AddingTeacherDialog({Key? key, this.newuserRoleIfAny})
      : super(key: key);

  @override
  State<AddingTeacherDialog> createState() => _AddingTeacherDialogState();
}

class _AddingTeacherDialogState extends State<AddingTeacherDialog> {
  List<Syllabus> syllabuses =
      IESSystem().getSyllabusesRepository().getAllSyllabuses();
  Syllabus? selectedSyllabus;
  Subject? selectedSubject;

  late Widget newUserRoleWidget;
  _AddingTeacherDialogState();
  @override
  Widget build(BuildContext context) {
    Syllabus? selectedSyllabus = syllabuses[0];
    return AlertDialog(
      title: const SizedBox(width: 500, child: Text('Agregar rol docente')),
      content: Scaffold(
        body: SizedBox(
          width: 500,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<Syllabus>(
                  // isExpanded: true,
                  items: syllabuses
                      .map((aSyllabus) => DropdownMenuItem<Syllabus>(
                          value: aSyllabus,
                          child: Text(
                            aSyllabus.name,
                          )))
                      .toList(),
                  value: selectedSyllabus,
                  onChanged: (aSyllabus) {
                    setState(() => selectedSyllabus = aSyllabus);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DropdownButtonFormField<Subject>(
                  // isExpanded: true,
                  items: (selectedSyllabus != null
                          ? selectedSyllabus!.subjects
                          : [])
                      .map((aSubject) => DropdownMenuItem<Subject>(
                          value: aSubject,
                          child: Text(
                            aSubject.name,
                          )))
                      .toList(),
                  value: selectedSubject,
                  onChanged: (aSyllabus) {
                    setState(() => selectedSubject = aSyllabus);
                  }),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () => {
                        if (selectedSyllabus != null && selectedSubject != null)
                          {Navigator.of(context).pop(Teacher(subjects: []))}

                        // Navigator.of(context).pop(null)
                      },
                  child: const SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Center(child: Text('Aceptar')),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () => {Navigator.of(context).pop(null)},
                  child: const SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Center(child: Text('Cancelar')),
                  )),
            ),
            const SizedBox(
              height: 50,
            )
          ]),
        ),
      ),
    );
  }
}
