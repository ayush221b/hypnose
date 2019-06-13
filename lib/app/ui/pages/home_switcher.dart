import 'package:flutter/material.dart';
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
                      placeholder: (context, url) =>
                          new CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          new Icon(Icons.error),
                    ),
                  )
                ],
              ),
            ),
            body: Center(
              child: RaisedButton(
                child: Text('Sign out'),
                onPressed: () async {
                  await userService.signOut();
                  Navigator.pushNamed(context, '/');
                },
              ),
            ));
      },
    );
  }
}
