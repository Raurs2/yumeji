import 'package:app_kanji/controllers/flashcards_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class TtsButton extends StatefulWidget {
  const TtsButton({super.key});

  @override
  State<TtsButton> createState() => _TtsButtonState();
}

class _TtsButtonState extends State<TtsButton> {

  bool _isTapped = false;
  final FlutterTts _tts = FlutterTts();

  @override
  void initState() {
    _setUpTts();
    super.initState();
  }

  @override
  void dispose() {
    _tts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardsNotifier>(
      builder: (_, notifier, __) => IconButton(onPressed: (){
        _runTts(text: '${notifier.word1.kunyomi}, ${notifier.word1.onyomi}');
        _isTapped = true;
        setState(() {});
        Future.delayed(const Duration(milliseconds: 500), () {
          _isTapped = false;
          setState(() {});
        });
      }, icon: Icon(Icons.audiotrack, size: 50, color: _isTapped ? Colors.black: Colors.white,)),
    );
  }

  _setUpTts() async{
    await _tts.setLanguage('ja-JP');
    await _tts.setSpeechRate(0.40);
  }

  _runTts({required String text}) async {
    await _tts.speak(text);
  }
}
