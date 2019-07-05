import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';

// Allows to switch between Admin and User View,
// based on Logged-in user role

class HomePageSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserService>(
      builder: (BuildContext context, UserService userService, Widget child) {
        return Scaffold(
          appBar: AppBar(),
          drawer: Drawer(
            child: Column(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountEmail: Text(userService.loggedInUser.email),
                  accountName: Text(userService.loggedInUser.name),
                  currentAccountPicture: CachedNetworkImage(
                    imageUrl: userService.loggedInUser.avatar,
                    placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                ListTile(
                  leading: Icon(FontAwesomeIcons.userFriends),
                  title: Text(
                    'Agenda',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, '/myaudios'),
                  leading: Icon(FontAwesomeIcons.microphone),
                  title: Text(
                    'Audios',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, '/mypictures'),
                  leading: Icon(FontAwesomeIcons.images),
                  title: Text(
                    'Pictures',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).pushNamed('/settings_admin');
                  },
                  leading: Icon(Icons.settings),
                  title: Text(
                    'Settings',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    await userService.signOut();
                    Navigator.pushNamed(context, '/');
                  },
                  leading: Icon(FontAwesomeIcons.signOutAlt),
                  title: Text(
                    'Sign Out',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
