import 'package:flutter/material.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:hypnose/app/ui/pages/audio_create.dart';
import 'package:hypnose/app/ui/pages/home_switcher.dart';
import 'package:hypnose/app/ui/pages/my_audios_screen.dart';
import 'package:hypnose/app/ui/pages/my_pictures.dart';
import 'package:hypnose/app/ui/pages/pictures_create.dart';
import 'package:hypnose/app/ui/pages/settings_admin.dart';
import 'package:hypnose/app/ui/pages/welcome_screen.dart';

Map<String, WidgetBuilder> buildNamedRoutes({UserService userService}) {
  Map<String, WidgetBuilder> namedRoutes = {
    '/': (BuildContext context) => WelcomeScreen(userService),
    '/home': (BuildContext context) => HomePageSwitcher(),
    '/audiocreate': (BuildContext context) => AudioCreateScreen(),
    '/myaudios': (BuildContext context) => MyAudiosScreen(),
    '/mypictures': (BuildContext context) => MyPicturesScreen(),
    '/picturecreate': (BuildContext context) => PicturesCreateScreen(),
    '/settings_admin': (BuildContext context) => AdminSettingsPage(),
  };

  return namedRoutes;
}
