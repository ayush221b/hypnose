import 'package:flutter/material.dart';

class Audio {
  String id;
  String name;
  String description;
  String url;
  String category;
  DateTime dateTime;
  String userUid;

  Audio({
      @required this.id,
      @required this.name,
      @required this.description,
      @required this.url,
      @required this.category,
      @required this.dateTime,
      @required this.userUid
      });

  Audio.fromMap(Map dataMap){

    id = dataMap['id'];
    name = dataMap['name'];
    description = dataMap['description'];
    url = dataMap['url'];
    category = dataMap['category'];
    dateTime = DateTime.parse(dataMap['dateTime']);
    userUid = dataMap['userUid'];
  }

  Map<String, dynamic> toMap() {

    var audioMap = Map<String, dynamic>();

    audioMap['id'] = id;
    audioMap['name'] = name;
    audioMap['description'] = description;
    audioMap['url'] = url;
    audioMap['category'] = category;
    audioMap['dateTime'] = dateTime.toString();
    audioMap['userUid'] = userUid;

    return audioMap;
  }

}