import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app_kanji/navigations/store_nav.dart';
import 'package:app_kanji/navigations/home_nav.dart';
import 'package:app_kanji/navigations/profile_nav.dart';
import 'package:app_kanji/navigations/games_nav.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  MainWrapperState createState() => MainWrapperState();
}

class MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    homeNavigatorKey,
    storeNavigatorKey,
    gamesNavigatorKey,
    profileNavigatorKey,
  ];

  Future<bool> _systemBackButtonPressed() async {
    if (_navigatorKeys[_selectedIndex].currentState?.canPop() == true) {
      _navigatorKeys[_selectedIndex]
          .currentState
          ?.pop(_navigatorKeys[_selectedIndex].currentContext);
      return false;
    } else {
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
      return true; // Indicate that the back action is handled
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _systemBackButtonPressed,
      child: Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          selectedIndex: _selectedIndex,
          destinations: const [
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: '学',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.local_grocery_store),
              icon: Icon(Icons.local_grocery_store_outlined),
              label: '店',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.games),
              icon: Icon(Icons.games_outlined),
              label: '遊',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.person),
              icon: Icon(Icons.person_outline),
              label: '顔',
            ),
          ],
        ),
        body: SafeArea(
          top: false,
          child: IndexedStack(
            index: _selectedIndex,
            children: const <Widget>[
              /// First Route
              HomeNav(),

              /// Second Route
              StoreNav(),

              /// Third Route
              GameNav(),

              /// Fourth Route
              ProfileNav(),
            ],
          ),
        ),
      ),
    );
  }
}
