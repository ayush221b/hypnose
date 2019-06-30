/* The user service is a utility which extends the ChangeNotifier class,
* which facilitates user authentication, and all other services related to the user model.
*/

import 'package:flutter/material.dart';

// Firebase imports
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// rxdart import to get PublishSubject
import 'package:rxdart/subjects.dart';

// User model
import 'package:hypnose/app/models/user.dart';

// enum to track Authentication State
enum AuthState { Unauthenticated, Processing, Authenticated }

class UserService extends ChangeNotifier {
  // Get auth instances
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Store reference of user collection
  final CollectionReference userDb = Firestore.instance.collection('user');

  // Master instance of logged in user
  User _loggedInUser;

  // Getter to access loggedInUser
  User get loggedInUser {
    return _loggedInUser;
  }

  PublishSubject<AuthState> _authStateSubject = PublishSubject();

  // Getter for authState
  PublishSubject<AuthState> get authStateSubject {
    return _authStateSubject;
  }

  // By default the state should be unauthenticated when the service is initialized
  UserService() {
    _authStateSubject.add(AuthState.Unauthenticated);
  }

  // Check if a user login is already present and auto-authenticate
  Future autoAuthenticateUser() async {
    // Change auth state to processing
    _authStateSubject.add(AuthState.Processing);

    FirebaseUser user = await _auth.currentUser();

    if (user != null) {
      await processFirestoreEntryOfUser(user);
    }

    // Update authState
    updateAuthState();
  }

  // Method to authenticate user
  Future authenticateUser() async {
    // Change auth state to processing
    _authStateSubject.add(AuthState.Processing);

    // Sign in user with google
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Get firebase user from signed in Google user
    final FirebaseUser user = await _auth.signInWithCredential(credential);
    print("signed in " + user.displayName);

    // Check and add user into firestore users collection
    await processFirestoreEntryOfUser(user);

    updateAuthState();
  }

  // Check and add user to users collection in firestore
  Future processFirestoreEntryOfUser(FirebaseUser user) async {
    Map userData;

    // Check if user exists in collection
    QuerySnapshot checkQuery =
        await userDb.where('uid', isEqualTo: user.uid).limit(1).getDocuments();

    final List<DocumentSnapshot> results = checkQuery.documents;

    if (results.length == 1)
      userData = results[0].data;
    else {
      Map<String, dynamic> userDbEntry = {
        'uid': user.uid,
        'name': user.displayName,
        'email': user.email,
        'avatar': user.photoUrl,
        'privilege': 'user'
      };

      DocumentReference entryRef = await userDb.add(userDbEntry);
      DocumentSnapshot docSnap = await entryRef.snapshots().first;
      userData = docSnap.data;
    }

    if (userData['uid'] != null) {
      _loggedInUser = User.fromMap(userData);
      notifyListeners();
    }
  }

  Future signOut() async {
    _authStateSubject.add(AuthState.Processing);

    await _auth.signOut();
    await _googleSignIn.signOut();

    _loggedInUser = null;

    updateAuthState();
  }

  void updateAuthState() {
    // Update Auth state accordingly
    if (_loggedInUser != null)
      _authStateSubject.add(AuthState.Authenticated);
    else
      _authStateSubject.add(AuthState.Unauthenticated);
  }
}
