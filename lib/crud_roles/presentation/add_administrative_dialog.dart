import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/entities/syllabus.dart';
import 'package:sistema_ies/core/domain/entities/user_roles.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class AddingAdministrativeDialog extends StatefulWidget {
  final UserRole? newuserRoleIfAny;
  const AddingAdministrativeDialog({Key? key, this.newuserRoleIfAny})
      : super(key: key);

  @override
  State<AddingAdministrativeDialog> createState() =>
      _AddingAdministrativeDialogState();
}

class _AddingAdministrativeDialogState
    extends State<AddingAdministrativeDialog> {
  List<Syllabus> syllabuses =
      IESSystem().getSyllabusesRepository().getAllSyllabuses();

  late Widget newUserRoleWidget;
  _AddingAdministrativeDialogState();
  @override
  Widget build(BuildContext context) {
    Syllabus? selectedSyllabus = syllabuses[0];
    return AlertDialog(
      title:
          const SizedBox(width: 500, child: Text('Agregar rol administrativo')),
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
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  onPressed: () => {
                        if (selectedSyllabus != null)
                          {
                            Navigator.of(context).pop(
                                Administrative(syllabus: selectedSyllabus!))
                          }
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
