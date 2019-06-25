import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/widgets.dart';

// Import the Audio player and Audio recorder modules
import 'package:audioplayers/audioplayers.dart';
import 'package:audio_recorder/audio_recorder.dart';

class AudioUtilService extends ChangeNotifier {
  // Create instance of the audioplayers package
  AudioPlayer audioPlayer = AudioPlayer();

  // Store the path of the recorded audio file
  String _audioFilePath;

  String get audioFilePath {
    return _audioFilePath;
  }

  // Map to store all details of audio
  Map<String, dynamic> _audioMap = {};

  Map<String, dynamic> get audioMap => _audioMap;

  set audioMap(Map<String, dynamic> newMap) {
    _audioMap = newMap;
    notifyListeners();
  }

  // Store the message for Audio player as per audio source
  String _playerMessage;

  String get playerMessage {
    return _playerMessage;
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

  // function to initiate audio recording
  Future startAudioRecorder() async {
    _isRecording = true;
    notifyListeners();

    // Check permissions before starting
    bool hasPermissions = await AudioRecorder.hasPermissions;

    // Get the state of the recorder
    bool isRecording = await AudioRecorder.isRecording;

    // Start recording
    if (hasPermissions && !isRecording) await AudioRecorder.start();
  }

  // function to stop audio recording
  Future stopAudioRecording() async {
    Recording recording = await AudioRecorder.stop();
    print(
        "Path : ${recording.path},  Format : ${recording.audioOutputFormat},  Duration : ${recording.duration},  Extension : ${recording.extension},");
    _audioFilePath = recording.path;
    _isRecording = false;
    _playerMessage = "Play recorded audio";
    notifyListeners();
  }

  // start playback of audio from @param uri
  Future startAudioPlayback(String uri) async {
    _isPlaying = true;
    notifyListeners();

    await audioPlayer.play(uri, isLocal: true);

    audioPlayer.onPlayerStateChanged.listen((AudioPlayerState s) {
      print('Current player state: $s');
      if (s == AudioPlayerState.PLAYING)
        _isPlaying = true;
      else
        _isPlaying = false;
      notifyListeners();
    });
  }

  // stop audio playback
  Future stopAudioPlayback() async {
    await audioPlayer.stop();
    _isPlaying = false;
    notifyListeners();
  }

  // pause audio playback
  Future pauseAudioPlayback() async {
    await audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  // resume audio playback
  Future resumeAudioPlayback() async {
    await audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  // Pick Audio File from System
  Future pickAudiofromDevice() async {
    String filePath;

    filePath = await FilePicker.getFilePath(type: FileType.AUDIO);

    if (filePath != null) {
      _audioFilePath = filePath;
      _playerMessage = "Play selected audio";
      notifyListeners();
    }
  }
}
