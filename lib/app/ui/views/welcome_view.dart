// The UI Component of the welcome screen

import 'package:flutter/material.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:hypnose/app/ui/widgets/loading_screen.dart';
import 'package:hypnose/app/ui/widgets/login_screen.dart';

class WelcomeView extends StatefulWidget {
  final UserService
      userService; // Get previously initialized userService instance

  WelcomeView({this.userService});

  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  // The initial view is the LoadingScreen
  Widget viewWidget = LoadingScreenWidget();

  @override
  initState() {
    super.initState();

    // Listen to changes in authState and react accordingly
    this.widget.userService.authStateSubject.listen((AuthState authState) {
      print(authState);
      if (authState == AuthState.Unauthenticated) {
        setState(() {
          viewWidget = LoginScreenWidget();
        });
      } else if (authState == AuthState.Processing) {
        setState(() {
          viewWidget = LoadingScreenWidget();
        });
      } else {
        // Navigate to the home switcher page if authState is authenticated.
        Navigator.pushNamed(context, '/home');
      }
    });

    // Attempt to auto-authenticate user
    this.widget.userService.autoAuthenticateUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: viewWidget,
    );
  }
}
