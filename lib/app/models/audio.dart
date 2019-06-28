import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Audio {
  String id; // Firestore id of audio
  String title; // title of audio file, as specified by admin
  String description; // Description as provided by admin
  String downloadUrl; // Firebase storage downloadUrl of audio
  String category; // category of Audio, defined by admin
  Timestamp dateTime; // Date and time when the audio was added
  String userUid; // (Optional) The UID of the user to which the audio was assigned
  String uploaderUid; // UID of the admin who uploaded the file

  Audio({
      @required this.id,
      @required this.title,
      @required this.description,
      @required this.downloadUrl,
      @required this.category,
      @required this.dateTime,
      @required this.userUid,
      @required this.uploaderUid
      });

  // Accepts a map and helps in generating an Audio instance
  Audio.fromMap(Map dataMap){

    id = dataMap['id'];
    title = dataMap['title'];
    description = dataMap['description'];
    downloadUrl = dataMap['downloadUrl'];
    category = dataMap['category'] ?? null;
    dateTime = dataMap['dateTime'];
    userUid = dataMap['userUid'] ?? null;
    uploaderUid = dataMap['uploaderUid'];
  }

  // Helper function to convert an Audio instance into a map
  Map<String, dynamic> toMap() {

    var audioMap = Map<String, dynamic>();

    audioMap['id'] = id;
    audioMap['title'] = title;
    audioMap['description'] = description;
    audioMap['downloadUrl'] = downloadUrl;
    audioMap['category'] = category ?? null;
    audioMap['dateTime'] = dateTime;
    audioMap['userUid'] = userUid ?? null;
    audioMap['uploaderUid'] = uploaderUid;

    return audioMap;
  }

}