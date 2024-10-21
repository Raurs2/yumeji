import 'package:flutter/material.dart';

class MemoryLogic {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue
  ];
  final String hiddenCardpath = "assets/images/hidden.png";

  List<String> cards_list = [
    "assets/kanji/11-boca.png",
    "assets/kanji/12-dia.png",
    "assets/kanji/13-mes.png",
    "assets/kanji/14-campo-de-arroz.png",
    "assets/kanji/15-olho.png",
    "assets/kanji/16-velho.png",
    "assets/kanji/11-boca.png",
    "assets/kanji/12-dia.png",
    "assets/kanji/13-mes.png",
    "assets/kanji/14-campo-de-arroz.png",
    "assets/kanji/15-olho.png",
    "assets/kanji/16-velho.png",

  ];

  final int cardCount = 12;
  List<Map<int, String>> matchCheck = [];

  //methods
  void initGame() {
    cards_list.shuffle();
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
