import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hypnose/app/services/audio_util_service.dart';

class AudioRecordingConsole extends StatelessWidget {
  final AudioUtilService audioUtilService;

  AudioRecordingConsole({this.audioUtilService});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SpinKitRipple(
                color: Colors.teal,
                size: 50,
              ),
              Text(
                'Now Recording',
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: RaisedButton.icon(
              color: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () async {
                await audioUtilService.stopAudioRecording();
              },
              icon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.stop,
                  color: Colors.white,
                ),
              ),
              label: Text(
                'Stop Recording',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}