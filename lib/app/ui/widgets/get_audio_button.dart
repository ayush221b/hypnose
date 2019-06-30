import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hypnose/app/services/audio_util_service.dart';

class GetAudioButton extends StatelessWidget {

  final bool shouldPickFromPhone;
  final AudioUtilService audioUtilService;

  GetAudioButton({this.audioUtilService, this.shouldPickFromPhone});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: RaisedButton.icon(
        color: Theme.of(context).primaryColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        icon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
          child: Icon(
              shouldPickFromPhone
                  ? FontAwesomeIcons.fileAudio
                  : FontAwesomeIcons.microphoneAlt,
              color: Colors.white),
        ),
        onPressed: () async {
          shouldPickFromPhone
              ? await audioUtilService.pickAudiofromDevice()
              : await audioUtilService.startAudioRecorder();
        },
        label: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
          child:
              Text(shouldPickFromPhone ? 'Choose Audio File' : 'Record Audio',
                  style: TextStyle(
                    color: Colors.white,
                  )),
        ),
      ),
    );
  }
}