import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FetchService extends ChangeNotifier {
  final Firestore db = Firestore.instance;

  Stream getContentUploadedByCurrentAdmin(
      {@required String uploaderUid, @required String contentType}) {
    Stream stream;
    Query query;

    switch (contentType) {
      case 'audios':
        // Create a query to get all audio files uploaded by currently logged-in admin
        query = db
            .collection('audio')
            .where('uploaderUid', isEqualTo: uploaderUid)
            .orderBy('dateTime', descending: true);
        break;
      case 'pictures':
        // Create a query to get all picture files uploaded by currently logged-in admin
        query = db
            .collection('picture')
            .where('uploaderUid', isEqualTo: uploaderUid)
            .orderBy('dateTime', descending: true);
        break;
      default:
    }

    stream =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));

    return stream;
    ;
  }
}
