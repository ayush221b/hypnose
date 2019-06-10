/* The welcome screen loads quickly on appLaunch and then checks the user state,
* if a logged-in user exists then the user is auto-authenticated, otherwise the 
* user is redirected to the auth screen where they must login/register and then 
* the appropriate workflow kicks in.
*/

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:hypnose/app/services/user_service.dart';
import 'package:hypnose/app/ui/views/welcome_view.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserService userService = UserService();
    return ChangeNotifierProvider<UserService>(
      builder: (BuildContext context) => userService,
      child: WelcomeView(userService: userService),
    );
  }
}
