import 'dart:math';

import 'package:app_kanji/pages/home/card_display.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/constants.dart';
import '../../enums/slide_direction.dart';
import '../../controllers/flashcards_notifier.dart';
import '../../animations/half_flip_animation.dart';
import '../../animations/slide_animation.dart';

class Card2 extends StatelessWidget {
  const Card2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => GestureDetector(
        onHorizontalDragEnd: (details) {
          print(details.primaryVelocity);
          if (details.primaryVelocity! > 100) {
            notifier.runSwipeCard2(direction: SlideDirection.leftAway);
            notifier.runSlideCard1();
            notifier.setIgnoreTouch(ignore: true);
            notifier.generateCurrentWord(context: context);
          } else if (details.primaryVelocity! < -100) {
            notifier.runSwipeCard2(direction: SlideDirection.rightAway);
            notifier.runSlideCard1();
            notifier.setIgnoreTouch(ignore: true);
            notifier.generateCurrentWord(context: context);
          }

        },
        child: HalfFlipAnimation(
          animate: notifier.flipCard2,
          reset: notifier.resetFlipCard2,
          flipFromHalfWay: true,
          animationCompleted: () {
            notifier.setIgnoreTouch(ignore: false);
          },
          child: SlideAnimation(
            animationCompleted: () {
              notifier.resetCard2();
            },
            reset: notifier.resetSwipeCard2,
            animate: notifier.swipeCard2,
            direction: notifier.swipeDirection,
            child: Center(
              child: Container(
                width: size.width * 0.9,
                height: size.height * 0.75,
                decoration:
                    BoxDecoration(
                        borderRadius: BorderRadius.circular(kCircularBorderRadius),
                        border: Border.all(
                          color: const Color.fromARGB(255, 135, 4, 184),
                          width: kCardBorderWidth
                        ),
                        color: const Color.fromARGB(255, 69, 0, 97)),
                child: Transform(
                  alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: const CardDisplay(isCard1: false)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
