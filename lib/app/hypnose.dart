import 'package:flutter/material.dart';
import 'package:hypnose/app/routes/route_manager.dart';
import 'package:hypnose/app/services/agenda_service.dart';
import 'package:hypnose/app/services/categories_service.dart';
import 'package:hypnose/app/services/fetch_service.dart';
import 'package:hypnose/app/services/host_service.dart';
import 'package:hypnose/app/services/audio_util_service.dart';
import 'package:hypnose/app/services/pitcure_util_service.dart';
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
  FetchService _fetchService;
  PictureUtilService _pictureUtilService;
  CategoriesService _categoriesService;
  AgendaService _agendaService;

  @override
  void initState() {
    super.initState();

    _userService = UserService();
    _audioUtilService = AudioUtilService();
    _hostService = HostService();
    _fetchService = FetchService();
    _pictureUtilService = PictureUtilService();
    _categoriesService = CategoriesService();
    _agendaService = AgendaService();
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
        ChangeNotifierProvider<FetchService>(
          builder: (_) => _fetchService,
        ),
        ChangeNotifierProvider<PictureUtilService>(
          builder: (_) => _pictureUtilService,
        ),
        ChangeNotifierProvider<CategoriesService>(
          builder: (_) => _categoriesService,
        ),
        ChangeNotifierProvider<AgendaService>(
          builder: (_) => _agendaService,
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
