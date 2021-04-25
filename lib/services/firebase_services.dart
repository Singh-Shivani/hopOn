import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vehicle_sharing_app/globalvariables.dart';
import 'package:vehicle_sharing_app/models/user.dart';

class FirebaseFunctions {
  Future<String> uploadUserData(Map<String, dynamic> data) async {
    String isUploaded;

    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');

    User currentUser = FirebaseAuth.instance.currentUser;
    currentFirebaseUser = currentUser;
    await collectionReference
        .doc(currentUser.uid)
        .set(data)
        .then((_) => isUploaded = 'true')
        // ignore: return_of_invalid_type_from_catch_error
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
    print('iscomplete');

    return isComplete;
  }

  Future<String> uploadVehicleInfo(Map<String, dynamic> data) async {
    String isRegistered;
    User currentUser = FirebaseAuth.instance.currentUser;

    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection('users/${currentUser.uid}/vehicle_details');


    await collectionReference
        .doc(currentUser.uid)
        .set(data)
        .then((_) => isRegistered = 'true')
        // ignore: return_of_invalid_type_from_catch_error
        .catchError((e) => isRegistered = e.message);
    print(isRegistered);
    return isRegistered;


  }
}
