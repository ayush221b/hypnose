import 'package:flutter/material.dart';

class Audio {
  String id; // Firestore id of audio
  String title; // title of audio file, as specified by admin
  String description; // Description as provided by admin
  String url; // Firebase storage URL of audio
  String category; // category of Audio, defined by admin
  DateTime dateTime; // Date and time when the audio was added
  String userUid; // (Optional) The UID of the user to which the audio was assigned

  Audio({
      @required this.id,
      @required this.title,
      @required this.description,
      @required this.url,
      @required this.category,
      @required this.dateTime,
      @required this.userUid
      });

  // Accepts a map and helps in generating an Audio instance
  Audio.fromMap(Map dataMap){

    id = dataMap['id'];
    title = dataMap['title'];
    description = dataMap['description'];
    url = dataMap['url'];
    category = dataMap['category'];
    dateTime = DateTime.parse(dataMap['dateTime']);
    userUid = dataMap['userUid'];
  }

  // Helper function to convert an Audio instance into a map
  Map<String, dynamic> toMap() {

    var audioMap = Map<String, dynamic>();

    audioMap['id'] = id;
    audioMap['title'] = title;
    audioMap['description'] = description;
    audioMap['url'] = url;
    audioMap['category'] = category;
    audioMap['dateTime'] = dateTime.toString();
    audioMap['userUid'] = userUid;

    return audioMap;
  }

}