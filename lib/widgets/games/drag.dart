import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/controller.dart';

class Drag extends StatefulWidget {
  const Drag({
    super.key,
    required this.letter,
  });

  final String letter;

  @override
  State<Drag> createState() => _DragState();
}

class _DragState extends State<Drag> {
  bool _accepted = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Selector<Controller, bool>(
      selector: (_, controller) => controller.generateWord,
      builder: (_, generate, __) {
        if (generate) {
          _accepted = false;
        }
        return Consumer<Controller>(
          builder: (_, notifier, __) => SizedBox(
            width: size.width * .10,
            height: size.height * .10,
            child: Center(
              child: _accepted
                  ? const SizedBox()
                  : Draggable(
                      data: widget.letter,
                      onDragEnd: (details) {
                        notifier.incrementTries();

                        if (details.wasAccepted) {
                          _accepted = true;
                          setState(() {});
                          Provider.of<Controller>(context, listen: false)
                              .incrementLetters(context: context);
                        }
                      },
                      childWhenDragging: const SizedBox(),
                      feedback: Text(
                        widget.letter,
                        style: const TextStyle(
                                fontSize: 45,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)
                            .copyWith(shadows: [
                          Shadow(
                              offset: const Offset(3, 3),
                              color: Colors.black.withOpacity(0.40),
                              blurRadius: 5)
                        ]),
                      ),
                      child: Text(
                        widget.letter,
                        style: const TextStyle(
                            fontSize: 45,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
