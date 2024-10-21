import 'dart:math';

import 'package:app_kanji/animations/fly_animation.dart';
import 'package:app_kanji/widgets/games/progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/controller.dart';
import '../../data/spelling_list.dart';
import '../../widgets/games/drag.dart';
import '../../widgets/games/drop.dart';
import '../../widgets/games/score_board.dart';

class SpellingGame extends StatefulWidget {
  const SpellingGame({super.key});

  @override
  State<SpellingGame> createState() => _SpellingGameState();
}

class _SpellingGameState extends State<SpellingGame> {
  final List<String> _words = words.toList();
  final List<String> _kanjis = kanjiList.toList();
  late String _word, _dropWord, image;


  _generateWord() {
    int random = Random().nextInt(_words.length);
    _word = _words[random];
    image = _kanjis[random];
    _dropWord = _word;
    //print('drop = $_dropWord\nimage = $image\nword = $_word\nrandom = $random');
    _words.removeAt(random);
    _kanjis.removeAt(random);
    final aux = _word.characters.toList()..shuffle();
    _word = aux.join();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<Controller>(context, listen: false)
          .setUp(total: _word.length);
      Provider.of<Controller>(context, listen: false)
          .requestWord(request: false);
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 154, 0, 118),
        title: const Text(
          "綴り Jogo de Soletrar",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Selector<Controller, bool>(
        selector: (_, controller) => controller.generateWord,
        builder: (_, generate, __) {
          if (generate && _words.isNotEmpty) {
            _generateWord();
          }
          return SafeArea(
            child: Center(
              child: Column(
                children: [
                  Expanded(flex: 2, child: Consumer<Controller>(
                    builder: (context, controller, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          scoreBoard("Tentativas", "${controller.tries}", 255, 78, 0, 60),
                          scoreBoard("Pontuação", "${controller.score}", 255, 78, 0, 60),
                        ],
                      );
                    },
                  )),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _dropWord.characters
                            .map((e) => FlyAnimation(
                          animate: true,
                              child: Drop(
                                    letter: e,
                                  ),
                            ))
                            .toList(),
                      )),
                  Expanded(
                      flex: 3,
                      child: FlyAnimation(animate: true,
                          child: Image.asset(image))),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _word.characters
                            .map((e) => FlyAnimation(
                          animate: true,
                              child: Drag(
                                    letter: e,
                                  ),
                            ))
                            .toList(),
                      )),
                  const Expanded(flex: 1, child: ProgressBar()),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
