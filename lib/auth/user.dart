import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CurrentUser extends ChangeNotifier{
  String _uid;
  String _email;

  get getEmail => _email;
  get getUid => _uid;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> signUpUser(String email, String password) async{
    bool returnValue = false;

    try{

      UserCredential _authResult = await _auth.signInWithEmailAndPassword(email: email, password: password);

      if(_authResult.user != null){
        _uid = _authResult.user.uid;
        _email = _authResult.user.email;
        returnValue = true;
      }
    }catch(e){
      print(e);
    }

    return returnValue;

  }
  Future<bool> loginUser(String email, String password) async{

  }
}