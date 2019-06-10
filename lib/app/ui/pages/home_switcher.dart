import 'package:flutter/material.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:provider/provider.dart';

// Allows to switch between Admin and User View,
// based on Logged-in user role

class HomePageSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text('Sign out'),
          onPressed: () async {
            await Provider.of<UserService>(context).signOut();
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
    );
  }
}
