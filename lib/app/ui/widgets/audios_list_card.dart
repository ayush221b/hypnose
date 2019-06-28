import 'package:flutter/material.dart';
import 'package:hypnose/app/models/audio.dart';
import 'package:hypnose/app/services/audio_util_service.dart';
import 'package:hypnose/app/ui/widgets/audio_list_card_details.dart';
import 'package:provider/provider.dart';

class AudiosListCard extends StatelessWidget {
  const AudiosListCard({
    Key key,
    @required this.audio,
  }) : super(key: key);

  final Audio audio;

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioUtilService>(
      builder: (BuildContext context,
          AudioUtilService audioUtilService,
          Widget child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Material(
            elevation: 4,
            color: Colors.blue,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            child: Container(
              constraints:
                  BoxConstraints(minHeight: 250),
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    width: 100,
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.center,
                      mainAxisAlignment:
                          MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CircleAvatar(
                            radius: 35,
                            backgroundColor:
                                Colors.white,
                            child: Icon(
                              Icons.music_note,
                              size: 40,
                              color: Colors.blue,
                            )),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: <Widget>[
                            IconButton(
                                onPressed: audioUtilService
                                                .currentlyPlayingUri !=
                                            null &&
                                        audioUtilService
                                                .currentlyPlayingUri !=
                                            audio
                                                .downloadUrl
                                    ? null
                                    : () async {
                                        audioUtilService.isPlaying
                                            ? await audioUtilService
                                                .pauseAudioPlayback()
                                            : await audioUtilService
                                                .startAudioPlayback(
                                                    audio.downloadUrl);
                                      },
                                iconSize: 35,
                                icon: Icon(
                                  audioUtilService.currentlyPlayingUri !=
                                              null &&
                                          audioUtilService
                                                  .currentlyPlayingUri ==
                                              audio
                                                  .downloadUrl
                                      ? audioUtilService
                                              .isPlaying
                                          ? Icons
                                              .pause_circle_filled
                                          : Icons
                                              .play_circle_filled
                                      : Icons
                                          .play_circle_filled,
                                  color: Colors.white,
                                )),
                            IconButton(
                                onPressed: () async {
                                  await audioUtilService
                                      .stopAudioPlayback();
                                },
                                icon: Icon(
                                  Icons.stop,
                                  color: Colors.white,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    child: AudioListCardDetails(audio: audio),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}