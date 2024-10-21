import 'package:flutter/material.dart';

class Drop extends StatelessWidget {
  const Drop({
    super.key,
    required this.letter,
  });

  final String letter;

  @override
  Widget build(BuildContext context) {
    bool accepted = false;
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * .10,
      height: size.height * .10,
      child: Center(
        child: DragTarget(
          onWillAccept: (data) {
            if (data == letter) {
              return true;
            } else {
              return false;
            }
          },
          onAccept: (data) {
            accepted = true;

          },
          builder: (context, candidateData, rejectedData) {
            if (accepted) {
              return Text(
                letter,
                style: const TextStyle(
                    fontSize: 45,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              );
            } else {
              return Container(color: Colors.deepPurple, width: 45, height: 45);
            }
          },
        ),
      ),
    );
  }
}
