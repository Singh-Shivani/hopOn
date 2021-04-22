import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'dataproviders/appdata.dart';
import 'screens/loginPage.dart';
import 'dart:io' show Platform;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await Firebase.initializeApp(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
      appId: '1:297855924061:ios:c6de2b69b03a5be8',
      apiKey: 'AIzaSyD_shO5mfO9lhy2TVWhfo1VUmARKlG4suk',
      projectId: 'flutter-firebase-plugins',
      messagingSenderId: '297855924061',
      databaseURL: 'https://flutterfire-cd2f7.firebaseio.com',
    )
        : FirebaseOptions(
      appId: '1:792415077234:android:45e448b71826aa789293eb',
      apiKey: 'AIzaSyBB34ETGgqbdUe4LRRcNF7lmY8XWdFE7NM',
      messagingSenderId: '297855924061',
      projectId: 'flutter-firebase-plugins',
      databaseURL: 'https://hopon-6bb14-default-rtdb.firebaseio.com',
    ),
  );
  runApp(MyApp());
}




class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Hop On',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',

          primaryColor: Color.fromRGBO(0, 0, 0, 1),
        ),
        home: LoginPage(),
      ),
    );
  }
}