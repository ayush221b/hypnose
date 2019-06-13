import 'package:flutter/material.dart';
import 'package:hypnose/app/services/audio_util_service.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:hypnose/app/static/globals.dart';
import 'package:hypnose/app/ui/pages/audio_create.dart';
import 'package:hypnose/app/ui/pages/home_switcher.dart';
import 'package:hypnose/app/ui/pages/welcome_screen.dart';
import 'package:provider/provider.dart';

class HypnoseApp extends StatefulWidget {
  @override
  _HypnoseAppState createState() => _HypnoseAppState();
}

class _HypnoseAppState extends State<HypnoseApp> {
  UserService _userService;
  AudioUtilService _audioUtilService;

  @override
  void initState() {
    super.initState();

    _userService = UserService();
    _audioUtilService = AudioUtilService();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserService>(
          builder: (_) => _userService,
        ),
        ChangeNotifierProvider<AudioUtilService>(
          builder: (_) => _audioUtilService,
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Globals.title,
          theme: ThemeData(primarySwatch: Colors.teal),
          darkTheme: ThemeData.dark(),
          initialRoute: '/',
          routes: {
            '/': (BuildContext context) => WelcomeScreen(_userService),
            '/home': (BuildContext context) => HomePageSwitcher(),
            '/audiocreate': (BuildContext context) => AudioCreateScreen()
          }),
    );
  }
}
