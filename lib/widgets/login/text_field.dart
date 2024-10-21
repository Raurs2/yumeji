import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          /*
          enabledBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Color.fromARGB(255, 255, 0, 0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Color.fromARGB(255, 97, 0, 0)),
          ),
          fillColor: Color.fromARGB(255, 186, 186, 186),
           */
          filled: true,
          hintText: hintText,
        ),
      ),
    );
  }
}
