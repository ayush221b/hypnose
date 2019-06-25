import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class HostService extends ChangeNotifier {
  // Firebase storage reference
  final StorageReference storageRef = FirebaseStorage.instance.ref();

  // To check if a file is currently being uploaded
  bool _isUploading = false;

  bool get isUploading {
    return _isUploading;
  }

  // Check if the process of addition of object was complete
  bool _objectAdded = false;

  bool get objectAdded => _objectAdded;

  // Download url of the uploaded file
  String _downloadUrl;

  String get downloadUrl => _downloadUrl;

  /// Helper function to generate a random filename for remote storage
  String getFileName(String uri) {
    int firstPos = uri.lastIndexOf(".");
    String fileName = Random().nextInt(10000).toString() +
        uri.substring(firstPos, uri.length);

    return fileName;
  }

  /// Function to upload file to firebase storage
  Future uploadToStorage(
      {String uri, bool isAudio = true}) async {
    _isUploading = true;
    notifyListeners();

    String fileName = getFileName(uri);

    final StorageReference fileRef =
        storageRef.child(isAudio ? 'audios' : 'pictures');
    final StorageUploadTask uploadTask =
        fileRef.child(fileName).putFile(File(uri));
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());

    if (url != null) {
      _downloadUrl = url;
    } else {
      _isUploading = false;
      _downloadUrl = null;
      _objectAdded = false;
    }
    notifyListeners();
  }

  Future updateFirestoreEntry(
      {bool isAudio = true,
      Map<String, dynamic> objectMap}) async {
    objectMap['downloadUrl'] = downloadUrl;

    final CollectionReference firestoreRef =
        Firestore.instance.collection(isAudio ? 'audio' : 'picture');
    DocumentReference entryRef = await firestoreRef.add(objectMap);
    DocumentSnapshot docSnap = await entryRef.snapshots().first;
    Map firestoreEntry = docSnap.data;
    _isUploading = false;
    if (firestoreEntry['id'] != null) {
      _objectAdded = true;
    } else {
      _objectAdded = false;
    }

    notifyListeners();
  }
}
