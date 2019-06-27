import 'package:flutter/material.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:hypnose/app/ui/pages/audio_create.dart';
import 'package:hypnose/app/ui/pages/home_switcher.dart';
import 'package:hypnose/app/ui/pages/welcome_screen.dart';

Map<String, WidgetBuilder> buildNamedRoutes({UserService userService}) {
  Map<String, WidgetBuilder> namedRoutes = {
    '/': (BuildContext context) => WelcomeScreen(userService),
    '/home': (BuildContext context) => HomePageSwitcher(),
    '/audiocreate': (BuildContext context) => AudioCreateScreen()
  };

  return namedRoutes;
}
