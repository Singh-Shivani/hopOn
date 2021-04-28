import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'package:vehicle_sharing_app/globalvariables.dart';

class FirebaseFunctions {
  final CollectionReference collectionReference =
      FirebaseFirestore.instance.collection('users');

  Future<String> uploadUserData(Map<String, dynamic> data) async {
    String isUploaded;

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
    print('iscomplete');
    print(isComplete);

    return isComplete;
  }

  // Get data from firestore
  final uid = FirebaseAuth.instance.currentUser.uid;

  Future<AppUser> getUser() async {
    final userDoc = await collectionReference.doc(uid).get();
    print('USer id:: ');
    print(uid);

    if (userDoc.exists) {
      final userData = userDoc.data();
      print('USer Data :: ');
      print(userData);
      final deocdedData = AppUser.fromMap(userData);
      print(deocdedData);
      return deocdedData;
    }
  }

  Future<String> uploadVehicleInfo(Map<String, dynamic> data) async {
    String isRegistered;
    User currentUser = FirebaseAuth.instance.currentUser;
    currentFirebaseUser = currentUser;
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
