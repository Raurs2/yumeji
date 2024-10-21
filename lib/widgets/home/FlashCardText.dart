import 'package:flutter/material.dart';

class FlashCardText extends StatelessWidget {
  const FlashCardText({
    super.key, required this.text, required this.size,
  });

  final String text;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
          color: Colors.white,
          fontSize: size,
          fontWeight: FontWeight.bold,
        ));
  }
}