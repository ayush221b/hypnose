// The UI Component of the welcome screen

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:provider/provider.dart';

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

// Loading Screen presented while authState is Processing
class LoadingScreenWidget extends StatelessWidget {
  const LoadingScreenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.teal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text('Getting things ready for you...',
              style: TextStyle(color: Colors.white, fontSize: 16.0)),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
            child: SizedBox(
                height: 2.0,
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).primaryColor),
                )),
          )
        ],
      ),
    );
  }
}

// Login Screen presented while authState is unauthenticated
class LoginScreenWidget extends StatelessWidget {
  const LoginScreenWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var userService = Provider.of<UserService>(context);

    return Container(
      decoration: BoxDecoration(color: Colors.teal),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(12.0),
            padding: EdgeInsets.all(8.0),
            child: Text(
              'hello, welcome to hypnose. \nplease register or login to continue.',
              style: TextStyle(
                  fontFamily: 'OpenSans', fontSize: 24.0, color: Colors.white),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
              child: InkWell(
                onTap: () async {
                  await userService.authenticateUser();
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  decoration: BoxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        FontAwesomeIcons.google,
                        color: Colors.teal,
                      ),
                      Text(
                        'Sign in with Google',
                        style: TextStyle(
                            color: Colors.teal,
                            fontSize: 18.0,
                            fontWeight: FontWeight.w600),
                      ),
                      Icon(
                        Icons.arrow_right,
                        color: Colors.teal,
                        size: 32,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
