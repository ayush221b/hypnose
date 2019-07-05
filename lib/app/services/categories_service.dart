import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class CategoriesService extends ChangeNotifier {
  final Firestore db = Firestore.instance;

  Map<String, dynamic> _newCategoryMap = {};

  Map<String, dynamic> get newCategoryMap => _newCategoryMap;

  set newCategoryMap(Map<String, dynamic> categoryMap) {
    _newCategoryMap = categoryMap;
    notifyListeners();
  }

  Stream getPictureCategories() {
    // Create a query to get all picture categories
    Query query = db
        .collection('category')
        .where('type', isEqualTo: 'picture')
        .orderBy('dateTime', descending: true);
    Stream stream =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));
    return stream;
  }

  Stream getAudioCategories() {
    // Create a query to get all audio categories
    Query query = db
        .collection('category')
        .where('type', isEqualTo: 'audio')
        .orderBy('dateTime', descending: true);
    Stream stream =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));
    return stream;
  }

  Future<bool> addNewcategory() async {
    final CollectionReference firestoreRef = db.collection('category');
    DocumentReference entryRef = await firestoreRef.add(_newCategoryMap);
    DocumentSnapshot docSnap = await entryRef.snapshots().first;
    Map firestoreEntry = docSnap.data;

    if (firestoreEntry['title'] != null) {
      return true;
    } else {
      return false;
    }
  }
}
