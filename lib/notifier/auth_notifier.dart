import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthNotifier extends ChangeNotifier {
  FirebaseAuth _user;

  FirebaseAuth get user {
    return _user;
  }

  void setUser(FirebaseAuth user) {
    _user = user;
    notifyListeners();
  }

  //Test
  User _userDetails;

  User get userDetails => _userDetails;

  setUserDetails(User user) {
    _userDetails = user;
    notifyListeners();
  }
}
