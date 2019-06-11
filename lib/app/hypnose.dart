import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    UserService userService = UserService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserService>.value(
          value: userService,
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Globals.title,
          theme: ThemeData(primarySwatch: Colors.cyan),
          darkTheme: ThemeData.dark(),
          initialRoute: '/',
          routes: {
            // '/': (BuildContext context) => WelcomeScreen(userService),
            '/': (BuildContext context) => AudioCreateScreen(),
            '/home': (BuildContext context) => HomePageSwitcher(),
            '/audiocreate': (BuildContext context) => AudioCreateScreen()
          }),
    );
  }
}
