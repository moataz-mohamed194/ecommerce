import 'package:flutter/material.dart';

scaffoldMessage(
    {required context, required String message, required bool isItAlert}) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
      style: const TextStyle(color: Colors.white),
    ),
    backgroundColor: isItAlert == true ? Colors.red : Colors.green,
  ));
}
