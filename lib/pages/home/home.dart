import 'package:app_kanji/controllers/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'card_1.dart';
import 'card_2.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String n = '1';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final flashCardsNotifier =
          Provider.of<FlashcardsNotifier>(context, listen: false);
      flashCardsNotifier.runSlideCard1();
      flashCardsNotifier.generateAllSelectedWords(number: n);
      flashCardsNotifier.generateCurrentWord(context: context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
        builder: (_, notifier, __) => Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset('assets/logos/app-icon.png',
                      fit: BoxFit.scaleDown),
                ),
              ],
              backgroundColor: const Color.fromARGB(255, 69, 0, 97),
              title: const Text(
                "学 Estudo",
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: IgnorePointer(
              ignoring: notifier.ignoreTouches,
              child: const Stack(
                children: [
                  Card2(),
                  Card1(),
                ],
              ),
            )));
  }
}
