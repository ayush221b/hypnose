import 'package:flutter/material.dart';
import 'package:hypnose/app/routes/route_manager.dart';
import 'package:hypnose/app/services/audio_fetch_service.dart';
import 'package:hypnose/app/services/host_service.dart';
import 'package:hypnose/app/services/audio_util_service.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:hypnose/app/static/globals.dart';
import 'package:provider/provider.dart';

class HypnoseApp extends StatefulWidget {
  @override
  _HypnoseAppState createState() => _HypnoseAppState();
}

class _HypnoseAppState extends State<HypnoseApp> {
  UserService _userService;
  AudioUtilService _audioUtilService;
  HostService _hostService;
  AudioFetchService _audioFetchService;

  @override
  void initState() {
    super.initState();

    _userService = UserService();
    _audioUtilService = AudioUtilService();
    _hostService = HostService();
    _audioFetchService = AudioFetchService();
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
        ),
        ChangeNotifierProvider<AudioFetchService>(
          builder: (_) => _audioFetchService,
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
