import 'package:flutter/material.dart';

class Picture {
  String id; // Firestore id of picture
  String name; // Name of picture file, as specified by admin
  String description; // Description as provided by admin
  String url; // Firebase storage URL of picture
  String category; // category of picture, defined by admin
  DateTime dateTime; // Date and time when the picture was added

  Picture({
    @required this.id,
    @required this.name,
    @required this.description,
    @required this.url,
    @required this.category,
    @required this.dateTime,
  });

  // Accepts a map and helps in generating an picture instance
  Picture.fromMap(Map dataMap) {
    id = dataMap['id'];
    name = dataMap['name'];
    description = dataMap['description'];
    url = dataMap['url'];
    category = dataMap['category'];
    dateTime = DateTime.parse(dataMap['dateTime']);
  }

  // Helper function to convert an picture instance into a map
  Map<String, dynamic> toMap() {
    var pictureMap = Map<String, dynamic>();

    pictureMap['id'] = id;
    pictureMap['name'] = name;
    pictureMap['description'] = description;
    pictureMap['url'] = url;
    pictureMap['category'] = category;
    pictureMap['dateTime'] = dateTime.toString();

    return pictureMap;
  }
}
