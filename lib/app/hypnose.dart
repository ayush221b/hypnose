import 'package:flutter/material.dart';
import 'package:hypnose/app/routes/route_manager.dart';
import 'package:hypnose/app/services/host_service.dart';
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
  HostService _hostService;

  @override
  void initState() {
    super.initState();

    _userService = UserService();
    _audioUtilService = AudioUtilService();
    _hostService = HostService();
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
        ),
        ChangeNotifierProvider<HostService>(
          builder: (_) => _hostService,
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: Globals.title,
          theme: ThemeData(primarySwatch: Colors.teal),
          darkTheme: ThemeData.dark(),
          initialRoute: '/',
          routes: buildNamedRoutes(userService: _userService)),
    );
  }
}
