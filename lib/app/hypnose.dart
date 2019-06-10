import 'package:flutter/material.dart';
import 'package:hypnose/app/static/globals.dart';
import 'package:hypnose/app/ui/pages/home_switcher.dart';
import 'package:hypnose/app/ui/pages/welcome_screen.dart';

class HypnoseApp extends StatefulWidget {
  @override
  _HypnoseAppState createState() => _HypnoseAppState();
}

class _HypnoseAppState extends State<HypnoseApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Globals.title,
        theme: ThemeData(primarySwatch: Colors.cyan),
        darkTheme: ThemeData.dark(),
        initialRoute: '/',
        routes: {
          '/': (BuildContext context) => WelcomeScreen(),
          '/home': (BuildContext context) => HomePageSwitcher(),
        });
  }
}
