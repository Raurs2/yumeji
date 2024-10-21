import 'package:flutter/material.dart';
import 'package:app_kanji/pages/home/home.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  HomeNavState createState() => HomeNavState();
}

GlobalKey<NavigatorState> homeNavigatorKey = GlobalKey<NavigatorState>();

class HomeNavState extends State<HomeNav> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: homeNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return const Home();
            });
      },
    );
  }
}
