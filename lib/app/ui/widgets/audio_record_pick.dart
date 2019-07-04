import 'package:flutter/material.dart';
import 'package:hypnose/app/services/audio_util_service.dart';
import 'package:hypnose/app/ui/widgets/audio_recprding_console.dart';
import 'package:hypnose/app/ui/widgets/get_audio_button.dart';
import 'package:hypnose/app/ui/widgets/min_audio_player_console.dart';
import 'package:hypnose/app/ui/widgets/page_move_button.dart';
import 'package:hypnose/app/ui/widgets/upload_fire.dart';
import 'package:provider/provider.dart';

class AudioPickRecordPage extends StatefulWidget {
  final PageController controller;

  AudioPickRecordPage(this.controller);

  @override
  _AudioPickRecordPageState createState() => _AudioPickRecordPageState();
}

class _AudioPickRecordPageState extends State<AudioPickRecordPage> {
  bool _shouldPickFromPhone = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioUtilService>(
      builder: (BuildContext context, AudioUtilService audioUtilService,
          Widget child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.all(8),
                child: Text('Step 3',
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor)),
              ),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Choose an Audio File or Record Audio',
                    style: TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                  )),
              Container(
                margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Switch(
                      value: _shouldPickFromPhone,
                      onChanged: (bool value) {
                        setState(() {
                          _shouldPickFromPhone = value;
                        });
                      },
                      inactiveThumbColor: Colors.blue,
                      inactiveTrackColor: Colors.cyan,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 20),
                      child: _shouldPickFromPhone
                          ? Text(
                              'Choose an Audio File',
                              style: TextStyle(fontSize: 20),
                            )
                          : Text(
                              'Record Audio',
                              style: TextStyle(fontSize: 20),
                            ),
                    )
                  ],
                ),
              ),
              audioUtilService.isRecording
                  ? buildRecordingConsole(context, audioUtilService)
                  : buildGetAudioButton(context, audioUtilService),
              if (audioUtilService.audioFilePath != null)
                MinAudioPlayerConsole(
                  audioUtilService: audioUtilService,
                ),
              if (audioUtilService.audioFilePath != null)
                UploadFireWidget(
                  isAudio: true,
                ),
              PageMoveButton(
                controller: this.widget.controller,
                isContinue: false,
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildRecordingConsole(
      BuildContext context, AudioUtilService audioUtilService) {
    return AudioRecordingConsole(audioUtilService: audioUtilService);
  }

  Widget buildGetAudioButton(
      BuildContext context, AudioUtilService audioUtilService) {
    return GetAudioButton(
      shouldPickFromPhone: _shouldPickFromPhone,
      audioUtilService: audioUtilService,
    );
  }
}
