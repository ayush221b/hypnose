import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class AudioFetchService extends ChangeNotifier {
  final Firestore db = Firestore.instance;

  Stream getAudiosUploadedByCurrentAdmin({@required String uploaderUid}) {
    // Create a query to get all audio files uploaded by currently logged-in admin
    Query query = db
        .collection('audio')
        .where('uploaderUid', isEqualTo: uploaderUid)
        .orderBy('dateTime', descending: true);

    Stream audios = query.snapshots().map((list) => list.documents.map((doc) => doc.data));

    return audios;
  }
}
