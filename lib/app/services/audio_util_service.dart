import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

// Import DateFormat from intl package
import 'package:intl/intl.dart' show DateFormat;

// Import Flutter Sound module
import 'package:flutter_sound/flutter_sound.dart';

class AudioUtilService extends ChangeNotifier {

  // Create instance of the flutter sound package
  FlutterSound flutterSound = new FlutterSound();

  // Store the path of the recorded audio file
  String _audioFilePath;

  String get recordedAudioPath {
    return _audioFilePath;
  }

  // Boolean to check if audio is recording
  bool _isRecording = false;

  bool get isRecording {
    return _isRecording;
  }

  // Boolean to check if audio is playing
  bool _isPlaying = false;

  bool get isPlaying {
    return _isPlaying;
  }


  // subscribe to the audio recording stream
  StreamSubscription _recorderSubscription;

  // stores the recorded audio position text
  String _recordedAudioPosition;

  String get recordedAudioPosition {
    return _recordedAudioPosition;
  }

  // subscribe to audio playback stream
  StreamSubscription _playerSubscription;

  // stores the current position text of audio playback
  String _playerAudioPosition;

  String get playerAudioPosition {
    return _playerAudioPosition;
  }

  // function to initiate audio recording
  Future startAudioRecorder() async {
    _isRecording = true;
    notifyListeners();

    Directory appDocDir = await getApplicationDocumentsDirectory();
    var random = Random.secure();
    String audioFileName = random.nextInt(100000).toString();
    String path = await flutterSound.startRecorder('${appDocDir.path}/$audioFileName.m4a');
    print('startRecorder: $path');

    _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
      DateTime date =
          new DateTime.fromMillisecondsSinceEpoch(e.currentPosition.toInt());
      _recordedAudioPosition = DateFormat('mm:ss:SS', 'en_US').format(date);
      notifyListeners();
    });
  }

  // function to stop audio recording
  Future stopAudioRecording() async {
    String result = await flutterSound.stopRecorder();
    print('stopRecorder: $result');

    if (_recorderSubscription != null) {
      _recorderSubscription.cancel();
      _recorderSubscription = null;
    }

    _audioFilePath = result;
    _isRecording = false;
    _recordedAudioPosition = null;
    notifyListeners();
  }

  // start playback of audio from @param uri
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

  // stop audio playback
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

  // pause audio playback
  Future pauseAudioPlayback() async {
    await flutterSound.pausePlayer();
    _isPlaying = false;
    notifyListeners();
  }

  // resume audio playback
  Future resumeAudioPlayback() async {
    await flutterSound.resumePlayer();
    _isPlaying = true;
    notifyListeners();
  }

  // Pick Audio File from System
  Future pickAudiofromDevice() async {

    String filePath;

    filePath = await FilePicker.getFilePath(type: FileType.AUDIO);

    if(filePath != null) {
      _audioFilePath = filePath;
    }
  }
}
