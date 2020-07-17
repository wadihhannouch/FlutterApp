import 'package:firebase_database/firebase_database.dart';

import 'FollowingCountry.dart';

class User {
  String key;
  String username;
  String firstName;
  String lastName;
  String email;
  String phone;
  String password;
  String location;
  String origin;
  DateTime DOB;
  List<FollowingCountry> followingCountries;
  String userId;


  User(
      this.firstName,
      this.lastName,
      this.username,
      this.phone,
      this.userId,
      this.email,
      this.DOB,
      this.location,
      this.origin);

  User.fromSnapshot(DataSnapshot snapshot) :

//        this.firstName,
//        this.lastName,
//        this.username,
//        this.userId,
//        this.email,
//        this.location,
//        this.origin
        key = snapshot.key,
        userId = snapshot.value["userId"],
        DOB = snapshot.value["dob"],
        username = snapshot.value["username"],
        email = snapshot.value["email"],
        firstName = snapshot.value["firstName"],
        lastName = snapshot.value["lastName"],
        origin = snapshot.value["origin"],

        location = snapshot.value["location"];


  toJson() {
    return {
      "userId": userId,
      "username": username,
      "email": email,
    };
  }
}