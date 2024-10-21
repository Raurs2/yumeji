import 'package:flutter/material.dart';
import 'package:app_kanji/pages/store/store.dart';

class StoreNav extends StatefulWidget {
  const StoreNav({super.key});

  @override
  StoreNavState createState() => StoreNavState();
}

GlobalKey<NavigatorState> storeNavigatorKey = GlobalKey<NavigatorState>();

class StoreNavState extends State<StoreNav> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: storeNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return const Store();
          },
        );
      },
    );
  }
}
