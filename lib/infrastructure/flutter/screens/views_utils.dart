import 'package:flutter/material.dart';

Expanded snackbarLike({required String text, required bool isFailure}) {
  return Expanded(
      child: Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
              height: 36,
              width: double.infinity,
              child: Container(
                color: isFailure ? Colors.red : Colors.green,
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  text,
                  style: const TextStyle(color: Colors.white),
                ),
              ))));
}
