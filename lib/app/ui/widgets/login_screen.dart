import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:provider/provider.dart';

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
              'Hello, Welcome to Hypnose. \nPlease register or login to continue.',
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
