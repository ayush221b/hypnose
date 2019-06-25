import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hypnose/app/services/audio_util_service.dart';
import 'package:hypnose/app/ui/widgets/page_move_button.dart';
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
            children: <Widget>[
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
              buildGetAudioButton(context, audioUtilService),
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

  Widget buildGetAudioButton(
      BuildContext context, AudioUtilService audioUtilsService) {
    return Container(
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
        onPressed: () {},
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
          child: Text(
              _shouldPickFromPhone ? 'Choose Audio File' : 'Start Recording',
              style: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
