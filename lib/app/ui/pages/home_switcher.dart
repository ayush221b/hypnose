import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// Allows to switch between Admin and User View,
// based on Logged-in user role

class HomePageSwitcher extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Let\'s Switch'),
      ),
    );
  }
}
