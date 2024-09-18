import 'package:flutter/material.dart';
import 'package:sistema_ies/admin_student_record/presentation/widgets/formTextField.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

class CourseApprovedByAcredtation extends StatelessWidget {
  const CourseApprovedByAcredtation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final certificationInstitute = TextEditingController();
    final bookNumber = TextEditingController();
    final pageNumber = TextEditingController();
    final certificationResolution = TextEditingController();
    final numericalGrade = TextEditingController();

    return Form(
      key: formKey,
      child: Column(
        children: <Widget>[
          // Certification institute
          FormTextField(
            name: "Certification institute",
            controller: certificationInstitute,
          ),
          // Book number
          FormTextField(
            name: "Book number",
            controller: bookNumber,
          ),
          // Page number
          FormTextField(
            name: "Page number",
            controller: pageNumber,
          ),
          // Certification resolution
          FormTextField(
            name: "Certification resolution",
            controller: certificationResolution,
          ),
          // Numerical grade
          FormTextField(
            name: "Numerical grade",
            controller: numericalGrade,
          ),

          ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (formKey.currentState!.validate()) {
                  // If the form is valid, display a snackbar. In the real world,
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                  // and send the form
                  // TODO: IESSystem().adminStudentRecordsUseCase.submitNewStudentMovement();
                }
              },
              child: const Text("Load"))
          // Add TextFormFields and ElevatedButton here.
        ],
      ),
    );
  }
}

