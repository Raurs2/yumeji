import 'package:app_kanji/controllers/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/home/FlashCardText.dart';
import '../../widgets/home/tts_button.dart';

class CardDisplay extends StatelessWidget {
  const CardDisplay({
    super.key,
    required this.isCard1,
  });

  final bool isCard1;

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => isCard1
          ? Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FlashCardText(text: notifier.word1.portuguese, size: 50),
                    FlashCardText(
                        text: 'Kun: ${notifier.word1.kunyomi}', size: 30),
                    FlashCardText(
                        text: 'On: ${notifier.word1.onyomi}', size: 30),
                    const TtsButton()
                  ]),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FlashCardText(text: notifier.word2.character, size: 130),
                  FlashCardText(text: notifier.word2.story, size: 30)
                ],
              ),
            ),
    );
  }
}
