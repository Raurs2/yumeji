import 'package:flutter/material.dart';
import 'package:app_kanji/pages/profile/profile.dart';

class ProfileNav extends StatefulWidget {
  const ProfileNav({super.key});

  @override
  ProfileNavState createState() => ProfileNavState();
}

GlobalKey<NavigatorState> profileNavigatorKey = GlobalKey<NavigatorState>();

class ProfileNavState extends State<ProfileNav> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: profileNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return  const Profile();
          },
        );
      },
    );
  }
}
