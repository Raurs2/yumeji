import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/constants.dart';
import '../../enums/slide_direction.dart';
import '../../controllers/flashcards_notifier.dart';
import '../../animations/half_flip_animation.dart';
import '../../animations/slide_animation.dart';
import 'card_display.dart';

class Card1 extends StatelessWidget {
  const Card1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => GestureDetector(
        onTap: () {
          notifier.runFlipCard1();
          notifier.setIgnoreTouch(ignore: true);
        },
        child: HalfFlipAnimation(
          animate: notifier.flipCard1,
          reset: notifier.resetFlipCard1,
          flipFromHalfWay: false,
          animationCompleted: () {
            notifier.resetCard1();
            notifier.runFlipCard2();
          },
          child: SlideAnimation(
            animationDuration: 1000,
            animationDelay: 200,
            animationCompleted: () {
              notifier.setIgnoreTouch(ignore: false);
            },
            reset: notifier.resetSlideCard1,
            animate: notifier.slideCard1 && !notifier.isRoundCompleted,
            direction: SlideDirection.upIn,
            child: Center(
              child: Container(
                width: size.width * 0.9,
                height: size.height * 0.75,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(kCircularBorderRadius),
                    border: Border.all(
                        color: const Color.fromARGB(255, 135, 4, 184),
                        width: kCardBorderWidth),
                    color: const Color.fromARGB(255, 69, 0, 97)),
                child: const CardDisplay(isCard1: true),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


