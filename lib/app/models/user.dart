import 'package:meta/meta.dart';

class User {

  String uid; // uid of user ot from firebase auth
  String id; // id in firestore of stored user
  String name; // name of user, to be displayed in app
  String email; // email address of user
  String avatar; // avatarUrl of user
  String privilege; // the privilige granted to user 

  User({
    @required this.uid,
    @required this.id,
    @required this.name,
    @required this.email,
    @required this.avatar,
    @required privilege
  });

  // Create user instance from map received from firestore
  User.fromMap(Map dataMap) {
    uid = dataMap['uid'];
    id = dataMap['id'];
    name = dataMap['name'];
    email = dataMap['email'];
    avatar = dataMap['avatar'];
    privilege = dataMap['privilege'];
  }

  // Helper function to create map from user instance
  Map<String, dynamic> toMap() {

    var userMap = Map<String, dynamic>();

    userMap['uid'] = uid;
    userMap['id'] = id;
    userMap['name'] = name;
    userMap['email'] = email;
    userMap['avatar'] = avatar;
    userMap['privilege'] = privilege;
    
    return userMap;
  }
}