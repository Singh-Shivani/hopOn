import 'dart:io';

class User {
  String displayName;
  String email;
  String password;
  String uuid;
  String mobileNo;
  String profilePic;
  String age;
  String bloodType;
  File profileFile;


  User();

  User.fromMap(Map<String, dynamic> data) {
    displayName = data['displayName'];
    email = data['email'];
    password = data['password'];
    uuid = data['uuid'];
    mobileNo = data['mobileNo'];
    profilePic = data['profilePic'];
    age = data['age'];
    bloodType = data['bloodType'];
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'email': email,
      'password': password,
      'uuid': uuid,
      'mobileNo': mobileNo,
      'profilePic': profilePic,
      'age' : age,
      'bloodType': bloodType,
    };
  }
}
