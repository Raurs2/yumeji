import 'package:audioplayers/audioplayers.dart';

class Player {
  static play(String source) async {
    final player = AudioPlayer();
    await player.play(AssetSource(source));
  }
}