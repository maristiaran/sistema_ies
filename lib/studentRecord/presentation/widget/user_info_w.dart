import 'package:flutter/material.dart';
import 'package:sistema_ies/core/domain/entities/users.dart';

Widget userInfoBar(IESUser iesUser, context) {
  return Container(
    height: 95,
    decoration: const BoxDecoration(color: Color.fromARGB(255, 73, 145, 254)),
    child: Row(
      children: [
        const SizedBox(width: 30),
        CircleAvatar(
          backgroundColor: const Color.fromARGB(144, 255, 255, 255),
          maxRadius: 35,
          child: Text(
            iesUser.firstname[0],
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(
          width: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              iesUser.firstname + iesUser.surname,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(iesUser.dni.toString(),
                style: const TextStyle(
                  color: Colors.white,
                ))
          ],
        )
      ],
    ),
  );
}
