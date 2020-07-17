import 'package:firebase_database/firebase_database.dart';

import 'FollowingCountry.dart';

class User {
  String key;
  String username;
  String email;
  String password;
  String location;
  String origin;
  List<FollowingCountry> followingCountries;
  String userId;

  User(this.username,
      this.userId,
      this.email,
      this.location,
      this.origin);

  User.fromSnapshot(DataSnapshot snapshot) :
        key = snapshot.key,
        userId = snapshot.value["userId"],
        username = snapshot.value["username"],
        email = snapshot.value["email"];

  toJson() {
    return {
      "userId": userId,
      "username": username,
      "email": email,
    };
  }
}