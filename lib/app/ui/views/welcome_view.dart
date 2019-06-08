// The UI Component of the welcome screen

import 'package:flutter/material.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:provider/provider.dart';

class WelcomeView extends StatefulWidget {
  @override
  _WelcomeViewState createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserService>(context);

    return Scaffold(
      body: Container(
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
                    fontFamily: 'OpenSans',
                    fontSize: 24.0,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(50),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.0),
                    decoration: BoxDecoration(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Continue',
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
      ),
    );
  }
}
