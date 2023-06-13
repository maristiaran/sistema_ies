import 'package:flutter/material.dart';
import 'package:sistema_ies/checkStudentRecord/presentation/widget/student_record_card_expanded.dart';
import 'package:sistema_ies/core/domain/entities/student.dart';
import 'package:sistema_ies/core/domain/ies_system.dart';

import '../check_student_record_page.dart';

class StudentRecordCard extends StatelessWidget {
  final StudentRecordSubject studentRecordSubject;

  const StudentRecordCard(this.studentRecordSubject, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 5.0,
        ),
        Container(
          width: MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(-4, 4),
                  spreadRadius: -2,
                  blurRadius: 4,
                  color: Color.fromRGBO(0, 0, 0, 0.28),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ExpansionTile(
                  trailing: TextButton(
                      onPressed: () {
                        // How change to other page related with this item?
                        IESSystem()
                            .checkStudentRecordUseCase
                            .getStudentRecordMovements(studentRecordSubject);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => StudentRecordCardExpanded(
                                    studentRecordSubject)));
                      },
                      child: const Text("Ver movimientos")),
                  title: Text(studentRecordSubject.name),
                  children: [
                    Container(
                        decoration: const BoxDecoration(
                            color: Color.fromRGBO(207, 221, 240, 100),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10))),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                            child: Text(
                                studentRecordSubject.subjectId.toString())))
                  ],
                )),
          ),
        )
      ],
    );
  }
}
