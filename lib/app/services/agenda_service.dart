import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hypnose/app/models/appointment.dart';

class AgendaService extends ChangeNotifier {
  Map<String, dynamic> _appointmentMap = {};

  Map<String, dynamic> get appointmentMap => _appointmentMap;

  set appointmentMap(Map<String, dynamic> aptMap) {
    _appointmentMap = aptMap;
    notifyListeners();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final Firestore db = Firestore.instance;

  Future<void> addAppointment() async {
    _isLoading = true;
    notifyListeners();

    final CollectionReference firestoreRef = db.collection('appointment');
    await firestoreRef.add(_appointmentMap);

    _isLoading = false;
    notifyListeners();
  }

  Stream getAgenda({@required adminUid}) {
    Query query = db
        .collection('appointment')
        .where('adminUid', isEqualTo: adminUid)
        .orderBy('dateTime', descending: true);
    Stream appointments =
        query.snapshots().map((list) => list.documents.map((doc) {
              Appointment appointment = Appointment.fromMap(doc.data);
              return appointment;
            }));

    return appointments;
  }
}
