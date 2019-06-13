import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class AudioHostService extends ChangeNotifier {
  // Store reference of audio collection
  final CollectionReference userDb = Firestore.instance.collection('audio');

  final StorageReference storageRef = FirebaseStorage.instance.ref().child('audios');

  Future uploadToStorage(String uri) async {

    
  }
}
