import 'dart:async';

import 'package:flutter/widgets.dart';

import 'package:intl/intl.dart' show DateFormat;

// Import Flutter Sound module
import 'package:flutter_sound/flutter_sound.dart';

class AudioUtilService extends ChangeNotifier {
  FlutterSound flutterSound = new FlutterSound();

  String _recordedAudioPath;

  String get recordedAudioPath {
    return _recordedAudioPath;
  }

  bool _isPlaying = false;

  bool get isPlaying {
    return _isPlaying;
  }

  set isPlaying(bool isPlaying) {
    _isPlaying = isPlaying;
  }

  bool _isRecording = false;

  bool get isRecording {
    return _isRecording;
  }

  set isRecording(bool isRecording) {
    _isRecording = isRecording;
  }

  StreamSubscription _recorderSubscription;

  String _recordedAudioPosition;

  String get recordedAudioPosition {
    return _recordedAudioPosition;
  }

  StreamSubscription _playerSubscription;

  String _playerAudioPosition;

  String get playerAudioPosition {
    return _playerAudioPosition;
  }

  Future startAudioRecorder() async {
    _isRecording = true;
    notifyListeners();

    String path = await flutterSound.startRecorder(null);
    print('startRecorder: $path');

    _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
      DateTime date =
          new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
      _recordedAudioPosition = DateFormat('mm:ss:SS', 'en_US').format(date);
      notifyListeners();
    });
  }

  Future stopAudioRecording() async {
    String result = await flutterSound.stopRecorder();
    print('stopRecorder: $result');

    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }

    _recordedAudioPath = result;
    _isRecording = false;
    _recordedAudioPosition = null;
    notifyListeners();
  }

  Future startAudioPlayback(String uri) async {
    await flutterSound.startPlayer(uri);

    _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
      if (e != null) {
        DateTime date =
            new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
        String txt = DateFormat('mm:ss:SS', 'en_US').format(date);

        _isPlaying = true;
        _playerAudioPosition = txt.substring(0, 8);
        notifyListeners();
      }
    });
  }

  Future stopAudioPlayback() async {
    await flutterSound.stopPlayer();

    if (_playerSubscription != null) {
      _playerSubscription.cancel();
      _playerSubscription = null;
    }

    _isPlaying = false;
    _playerAudioPosition = null;
    notifyListeners();
  }

  Future pauseAudioPlayback() async {
    await flutterSound.pausePlayer();
    _isPlaying = false;
    notifyListeners();
  }

  Future resumeAudioPlayback() async {
    await flutterSound.resumePlayer();
    _isPlaying = true;
    notifyListeners();
  }
}
