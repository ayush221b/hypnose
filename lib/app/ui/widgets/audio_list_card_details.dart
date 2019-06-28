import 'package:flutter/material.dart';
import 'package:hypnose/app/models/audio.dart';
import 'package:intl/intl.dart';

class AudioListCardDetails extends StatelessWidget {
  const AudioListCardDetails({
    Key key,
    @required this.audio,
  }) : super(key: key);

  final Audio audio;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment:
          MainAxisAlignment.spaceAround,
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Title',
          style: TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 18),
        ),
        Text(
          '${audio.title}',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Description',
          style: TextStyle(
              color: Colors.white,
              fontWeight:
                  FontWeight.bold,
              fontSize: 18),
        ),
        Text(
          '${audio.description}',
          style: TextStyle(
              color: Colors.white,
              fontSize: 16),
        ),
        SizedBox(
          height: 10,
        ),
        if (audio.category != null)
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: 'Category: ',
                    style: TextStyle(
                        fontWeight:
                            FontWeight
                                .bold)),
                TextSpan(
                    text:
                        '${audio.category}')
              ],
            ),
          )
        else
          RichText(
            text: TextSpan(
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
              children: <TextSpan>[
                TextSpan(
                    text: 'User: ',
                    style: TextStyle(
                        fontWeight:
                            FontWeight
                                .bold)),
                TextSpan(
                    text:
                        '${audio.userUid}')
              ],
            ),
          ),
        SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
            children: <TextSpan>[
              TextSpan(
                  text: 'Added On: \n',
                  style: TextStyle(
                      fontWeight:
                          FontWeight
                              .bold)),
              TextSpan(
                  text:
                      '${DateFormat.yMMMMd().format(audio.dateTime.toDate())}')
            ],
          ),
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}