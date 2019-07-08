import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Appointment {

  String userUid; // UID of user 
  String adminUid; // UID of admin
  String description; // Description of appointment
  Timestamp dateTime; // Date and Time of Appointment

  Appointment({
    @required this.userUid,
    @required this.adminUid,
    @required this.description,
    @required this.dateTime
  });

  // Create instance of Appointment from map
  Appointment.fromMap(Map dataMap) {

    userUid = dataMap['userUid'];
    adminUid = dataMap['adminUid'];
    description = dataMap['description'];
    dateTime = dataMap['dateTime'];
  }

  // Helper function for creating map from Appointment instance
  Map<String, dynamic> toMap() {

    var appointmentMap = Map<String, dynamic>();

    appointmentMap['userUid'] = userUid;
    appointmentMap['adminUid'] = adminUid;
    appointmentMap['description'] = description;
    appointmentMap['dateTime'] = dateTime.toString();

    return appointmentMap;
  }
}