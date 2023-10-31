import 'package:flutter/material.dart';

Container tittlewidget(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
  return Container(
    width: 250,
    height: screenHeight * 0.070,
    margin: const EdgeInsets.fromLTRB(0, 40, 0, 20),
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 2,
              blurRadius: 1,
              offset: const Offset(0, 3)),
        ],
        color: const Color(0xFFC6C6C6),
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(25), bottomRight: Radius.circular(25))),
    child: const Center(
      child: Text(
        "GESTION DE INSCRIPCION",
        style: TextStyle(
            fontSize: 20,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w800),
        textAlign: TextAlign.center,
      ),
    ),
  );
}
