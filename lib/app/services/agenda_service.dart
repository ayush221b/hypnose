import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
}
