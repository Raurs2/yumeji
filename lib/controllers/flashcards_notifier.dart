import 'dart:math';

import 'package:app_kanji/enums/slide_direction.dart';
import 'package:app_kanji/widgets/home/result_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../data/constants.dart';

import '../data/kanji.dart';
import '../data/word.dart';

class FlashcardsNotifier extends ChangeNotifier {
  final DocumentReference docRef = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid);

  int round = 0,
      card = 0,
      correct = 0,
      incorrect = 0,
      correctPercentage = 0;
  List<Word> incorrectCards = [];
  bool isFirstRound = true,
      isRoundCompleted = false,
      isSessionCompleted = false;

  String profilePictureNotifier = '';
  changeProfilePicture({required String picture}) {
    profilePictureNotifier = picture;
    notifyListeners();
  }


  calculateCorrectPercentage() {
  final percentage = correct / card;
  correctPercentage = (percentage * 100).round();
}

  reset () {
    isFirstRound = true;
    isRoundCompleted = false;
    isSessionCompleted = false;
    round = 0;
  }

  String number = '', username = '', email = '';
  Word word1 = Word(
      portuguese: '',
      character: '',
      kunyomi: '',
      onyomi: '',
      number: '',
      story: '');
  Word word2 = Word(
      portuguese: '',
      character: '',
      kunyomi: '',
      onyomi: '',
      number: '',
      story: '');
  List<Word> selectedWords = [];

  String n = '1';
  changeCardPack({required String number}) {
    n = number;
    notifyListeners();
  }

  generateAllSelectedWords({required String number}) {
    selectedWords.clear();
    isRoundCompleted = false;
    if (isFirstRound) {
      selectedWords = words.where((element) => element.number == number).toList();
    } else {
      selectedWords = incorrectCards.toList();
      incorrectCards.clear();
    }
    round++;
    card = selectedWords.length;
    correct = 0;
    incorrect = 0;
  }

  generateCurrentWord({required BuildContext context}) {
    if (selectedWords.isNotEmpty) {
      final random = Random().nextInt(selectedWords.length);
      word1 = selectedWords[random];
      selectedWords.removeAt(random);
    } else {
      if(incorrectCards.isEmpty) {
        isSessionCompleted = true;
        n = '2';
        docRef.update({"cards_pack": FieldValue.increment(1)});
      }
      isRoundCompleted = true;
      isFirstRound = false;
      calculateCorrectPercentage();
      Future.delayed(const Duration(milliseconds: 500), () {
        showDialog(context: context, builder: (context) => const ResultBox());
      });

    }
    Future.delayed(const Duration(milliseconds: kSlideAwayDuration), () {
      word2 = word1;
    });
  }

  updateCardOutcome({required Word word, required bool isCorrect}) {
    docRef.update({"cards": FieldValue.increment(1)});
    if (!isCorrect) {
      incorrectCards.add(word);
      incorrect++;
    } else {
      correct++;
    }
    notifyListeners();

  }

  //animation code
  SlideDirection swipeDirection = SlideDirection.none;
  bool flipCard2 = false,
      flipCard1 = false,
      swipeCard2 = false,
      slideCard1 = false;
  bool resetSlideCard1 = false,
      resetFlipCard1 = false,
      resetFlipCard2 = false,
      resetSwipeCard2 = false;
  bool ignoreTouches = true;

  setIgnoreTouch({required bool ignore}) {
    ignoreTouches = ignore;
    notifyListeners();
  }

  runSlideCard1() {
    resetSlideCard1 = false;
    slideCard1 = true;
    notifyListeners();
  }

  runSwipeCard2({required SlideDirection direction}) {
    updateCardOutcome(word: word2, isCorrect: direction == SlideDirection.leftAway);
    swipeDirection = direction;
    swipeCard2 = true;
    resetSwipeCard2 = false;
    notifyListeners();
  }

  runFlipCard1() {
    resetFlipCard1 = false;
    flipCard1 = true;
    notifyListeners();
  }

  runFlipCard2() {
    resetFlipCard2 = false;
    flipCard2 = true;
    notifyListeners();
  }

  resetCard1() {
    resetFlipCard1 = true;
    resetSlideCard1 = true;
    slideCard1 = false;
    flipCard1 = false;
  }

  resetCard2() {
    resetFlipCard2 = true;
    resetSwipeCard2 = true;
    swipeCard2 = false;
    flipCard2 = false;
  }
}
