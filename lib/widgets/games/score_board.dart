import 'package:flutter/material.dart';

Widget scoreBoard(String title, String info, int a, int r, int g, int b) {
  return Container(
    margin: const EdgeInsets.all(15.0),
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 20.0),
    decoration: BoxDecoration(
        color:  Color.fromARGB(a, r, g, b),
        borderRadius: BorderRadius.circular(20)),
    child: Column(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        Text(
          info,
          style: const TextStyle(
              fontSize: 35.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ],
    ),
  );
}
