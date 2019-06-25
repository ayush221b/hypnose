import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hypnose/app/services/host_service.dart';
import 'package:hypnose/app/services/audio_util_service.dart';
import 'package:hypnose/app/services/user_service.dart';
import 'package:hypnose/app/ui/widgets/min_audio_player_console.dart';
import 'package:hypnose/app/ui/widgets/page_move_button.dart';
import 'package:hypnose/app/ui/widgets/upload_fire.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
                UploadFireWidget(),
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

  Container buildRecordingConsole(
      BuildContext context, AudioUtilService audioUtilService) {
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

  Widget buildGetAudioButton(
      BuildContext context, AudioUtilService audioUtilService) {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton.icon(
        color: Theme.of(context).primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        icon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Icon(
              _shouldPickFromPhone
                  ? FontAwesomeIcons.fileAudio
                  : FontAwesomeIcons.microphoneAlt,
              color: Colors.white),
        ),
        onPressed: () async {
          _shouldPickFromPhone
              ? await audioUtilService.pickAudiofromDevice()
              : await audioUtilService.startAudioRecorder();
        },
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
          child:
              Text(_shouldPickFromPhone ? 'Choose Audio File' : 'Record Audio',
                  style: TextStyle(
                    color: Colors.white,
                  )),
        ),
      ),
    );
  }
}
