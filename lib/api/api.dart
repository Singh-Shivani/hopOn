// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:vehicle_sharing_app/model/user.dart';
// import 'package:vehicle_sharing_app/notifier/authNotifier.dart';
// import 'package:vehicle_sharing_app/screens/loginPage.dart';
//
// login(User user, AuthNotifier authNotifier, BuildContext context) async {
//   AuthResult authResult = await FirebaseAuth.instance
//       .signInWithEmailAndPassword(email: user.email, password: user.password)
//       .catchError((error) => print(error));
//
//   if (authResult != null) {
//     FirebaseUser firebaseUser = authResult.user;
//     if (firebaseUser != null) {
//       print("Log In: $firebaseUser");
//       authNotifier.setUser(firebaseUser);
//       await getUserDetails(authNotifier);
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//     }
//   }
// }
//
// signUp(User user, AuthNotifier authNotifier, BuildContext context) async {
//   bool userDataUploaded = false;
//   AuthResult authResult = await FirebaseAuth.instance
//       .createUserWithEmailAndPassword(
//       email: user.email.trim(), password: user.password)
//       .catchError((error) => print(error));
//
//   if (authResult != null) {
//     UserUpdateInfo updateInfo = UserUpdateInfo();
//     updateInfo.displayName = user.displayName;
//
//     FirebaseUser firebaseUser = authResult.user;
//
//     if (firebaseUser != null) {
//       await firebaseUser.updateProfile(updateInfo);
//       await firebaseUser.reload();
//
//       print("Sign Up: $firebaseUser");
//
//       FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
//
//       authNotifier.setUser(currentUser);
//
//       uploadUserData(user, userDataUploaded);
//
//       await getUserDetails(authNotifier);
//
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => LoginPage()),
//       );
//     }
//   }
// }
//
// signOut(AuthNotifier authNotifier, BuildContext context) async {
//   await FirebaseAuth.instance.signOut();
//
//   authNotifier.setUser(null);
//   print('log out');
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (BuildContext context) {
//       return LoginPage();
//     }),
//   );
// }
//
// initializeCurrentUser(AuthNotifier authNotifier, BuildContext context) async {
//   FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
//   if (firebaseUser != null) {
//     authNotifier.setUser(firebaseUser);
//     await getUserDetails(authNotifier);
//   }
// }
//
// getUserDetails(AuthNotifier authNotifier) async {
//   await Firestore.instance
//       .collection('users')
//       .document(authNotifier.user.uid)
//       .get()
//       .catchError((e) => print(e))
//       .then((value) => authNotifier.setUserDetails(User.fromMap(value.data)));
// }
// uploadUserData(User user, bool userdataUpload) async {
//   bool userDataUploadVar = userdataUpload;
//   FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
//
//   CollectionReference userRef = Firestore.instance.collection('users');
//   user.uuid = currentUser.uid;
//   if (userDataUploadVar != true) {
//     await userRef
//         .document(currentUser.uid)
//         .setData(user.toMap())
//         .catchError((e) => print(e))
//         .then((value) => userDataUploadVar = true);
//   } else {
//     print('already uploaded user data');
//   }
//   print('user data uploaded successfully');
// }