import 'package:app_kanji/utils/player.dart';
import 'package:app_kanji/data/spelling_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/games/message_box.dart';

class Controller extends ChangeNotifier {
  int totalLetters = 0, lettersAnswered = 0, wordsAnswered = 0;
  bool generateWord = true, sessionCompleted = false;
  double percentCompleted = 0;
  int tries = 0;
  int score = 0;
  int total_tries = 0;
  int total_score = 0;
  int round = 0;


  setUp({required int total}) {
    lettersAnswered = 0;
    totalLetters = total;
    notifyListeners();
  }

  incrementTries () {
    tries++;
    total_tries++;
    notifyListeners();
  }

  resetScoreBoard() {
    score = 0;
    tries = 0;
    round++;
    notifyListeners();
  }

  incrementLetters({required BuildContext context}) {
    lettersAnswered++;
    if (lettersAnswered == totalLetters) {
      Player.play('audios/finish.mp3');
      score += 10;
      total_score += 10;
      final coins = (score / tries * 10).round();
      final DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);
      docRef.update({"coins": FieldValue.increment(coins)});
      wordsAnswered++;
      percentCompleted = wordsAnswered / words.length;
      if (wordsAnswered == words.length) {

        sessionCompleted = true;
      }
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) =>  MessageBox(sessionCompleted: sessionCompleted,));
    } else {
      Player.play('audios/correct.mp3');
      score += 10;
      total_score += 10;
    }

    notifyListeners();
  }

  requestWord({required bool request}) {
    generateWord = request;
    resetScoreBoard();
    notifyListeners();
  }

  reset() {
    sessionCompleted = false;
    wordsAnswered = 0;
    generateWord = true;
    percentCompleted = 0;
    tries = 0;
    score = 0;
    total_score = 0;
    total_tries = 0;
    round = 0;
  }
}
