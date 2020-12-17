import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vehicle_sharing_app/models/user.dart';

class FirebaseFunctions {
  Future<String> uploadUserData(Map<String, dynamic> data) async {
    String isUploaded;

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');

    User currentUser = FirebaseAuth.instance.currentUser;

    await collectionReference
        .doc(currentUser.uid)
        .set(data)
        .then((_) => isUploaded = 'true')
        .catchError((e) => isUploaded = e.message);

    return isUploaded;
  }

  Future<bool> hasUserCompletedProfile() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');

    User currentUser = FirebaseAuth.instance.currentUser;

    bool isComplete = false;

    await collectionReference.doc(currentUser.uid).get().then((docSnap) =>
        isComplete = AppUser.fromMap(docSnap.data()).hasCompleteProfile);

    print(isComplete);

    return isComplete;
  }
}
