import 'package:flutter/material.dart';
import 'package:hypnose/app/services/audio_util_service.dart';

class MinAudioPlayerConsole extends StatelessWidget {
  final AudioUtilService audioUtilService;

  const MinAudioPlayerConsole({Key key, this.audioUtilService})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    '${audioUtilService.playerMessage ?? ''}',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  if (!audioUtilService.isPlaying)
                    IconButton(
                      onPressed: () async {
                        await audioUtilService.startAudioPlayback(
                            audioUtilService.audioFilePath);
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
                    )
                  else
                    IconButton(
                      onPressed: () async {
                        await audioUtilService.pauseAudioPlayback();
                      },
                      icon: Icon(
                        Icons.pause,
                        color: Colors.white,
                      ),
                    ),
                  IconButton(
                    onPressed: () async {
                      await audioUtilService.stopAudioPlayback();
                    },
                    icon: Icon(
                      Icons.stop,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
