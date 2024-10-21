import 'package:app_kanji/pages/games/spelling_game.dart';
import 'package:flutter/material.dart';
import 'package:app_kanji/pages/games/games.dart';
import 'package:app_kanji/pages/games/memory_game.dart';
import 'package:provider/provider.dart';

import '../controllers/controller.dart';

class GameNav extends StatefulWidget {
  const GameNav({super.key});

  @override
  GameNavState createState() => GameNavState();
}

GlobalKey<NavigatorState> gamesNavigatorKey = GlobalKey<NavigatorState>();

class GameNavState extends State<GameNav> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: gamesNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              if (settings.name == "/game1") {
                return const MemoryGame();
              } else if (settings.name == "/game2") {
                Provider.of<Controller>(context, listen: false).reset();
                return const SpellingGame();
              }
              return const Games();
            });
      },
    );
  }
}
