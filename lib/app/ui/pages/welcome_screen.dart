/* The welcome screen loads quickly on appLaunch and then checks the user state,
* if a logged-in user exists then the user is auto-authenticated, otherwise the 
* user is redirected to the auth screen where they must login/register and then 
* the appropriate workflow kicks in.
*/

import 'package:flutter/material.dart';

import 'package:hypnose/app/services/user_service.dart';
import 'package:hypnose/app/ui/views/welcome_view.dart';

class WelcomeScreen extends StatelessWidget {
  final UserService userService;

  WelcomeScreen(this.userService);

  @override
  Widget build(BuildContext context) {
    return WelcomeView(userService: userService);
  }
}
