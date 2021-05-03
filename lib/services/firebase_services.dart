import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vehicle_sharing_app/globalvariables.dart';
import 'package:vehicle_sharing_app/models/user.dart';
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/widgets.dart';


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

    if (userDoc.exists) {
      final userData = userDoc.data();

      final decodedData = AppUser.fromMap(userData);

      return decodedData;
    }
  }


  //upload image

  Future<String> uploadVehicleInfo(Map<String, dynamic> data, File localFile, BuildContext context) async {
    if (localFile != null) {
      print('uploading img file');

      var fileExtension = path.extension(localFile.path);
      print(fileExtension);

      var uuid = Uuid().v4();

      final Reference firebaseStorageRef =
      FirebaseStorage.instance.ref().child('images/$uuid$fileExtension');

      UploadTask task = firebaseStorageRef.putFile(localFile);

      TaskSnapshot taskSnapshot = await task;

      String url = await taskSnapshot.ref.getDownloadURL();
      print('dw url $url');
      if (url != null) {
        print(url);
        try {
          data['vehicleImg'] = url;
          print(data['vehicleImg']);
        } catch (e) {
          print(e);
        }
      }
    }

    print(data);

      String isRegistered;
      User currentUser = FirebaseAuth.instance.currentUser;
      currentFirebaseUser = currentUser;
      CollectionReference collectionReference = FirebaseFirestore.instance
          .collection('users/${currentUser.uid}/vehicle_details');

      await collectionReference
          .doc(currentUser.uid)
          .set(data)
          .then((_) => isRegistered = 'true')
      // ignore: return_of_invalid_type_from_catch_error
          .catchError((e) => isRegistered = e.message);
      print(isRegistered);
      return isRegistered;

  }

  Future<VehicleUser> getOwner(String key) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users/$key/vehicle_details');
    final ownerDoc = await collectionReference.doc(key).get();
    // print('USer id:: ');
    // print(ownerDoc);

    if (ownerDoc.exists) {
      final ownerData = ownerDoc.data();
      // print('Owner Data :: ');
      // print(ownerData);
      final decodedData = VehicleUser.fromMap(ownerData);
      // print(decodedData);
      return decodedData;
    }
  }
}
