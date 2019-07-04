import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FetchService extends ChangeNotifier {
  final Firestore db = Firestore.instance;

  Stream getAudiosUploadedByCurrentAdmin({@required String uploaderUid}) {
    // Create a query to get all audio files uploaded by currently logged-in admin
    Query query = db
        .collection('audio')
        .where('uploaderUid', isEqualTo: uploaderUid)
        .orderBy('dateTime', descending: true);
    Stream stream =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));
    return stream;
  }

  Stream getPicturesUploadedByCurrentAdmin({@required String uploaderUid}) {
    // Create a query to get all picture files uploaded by currently logged-in admin
    Query query = db
        .collection('picture')
        .where('uploaderUid', isEqualTo: uploaderUid)
        .orderBy('dateTime', descending: true);
    Stream stream =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));
    return stream;
  }
}
