import 'package:flutter/material.dart';


class FormTextField extends StatelessWidget {
  const FormTextField(
      {Key? key, required this.controller, required this.name}) : super(key: key);

  final TextEditingController controller;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 5, vertical: 16),
      child: TextFormField(
        decoration: InputDecoration(
          //contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: name,
        ),
        controller: controller,
        // The validator receives the text that the user has entered.
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      ),
    );
  }
}
