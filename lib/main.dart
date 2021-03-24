import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/change_notifier.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'dataproviders/appdata.dart';
import 'screens/landingPage.dart';
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
      appId: '1:817660570833:android:a128d08a82424e33ea69f0',
      apiKey: 'AIzaSyCvIOFoJqw3R6bVHUAoAZxX76GMjPSkosE',
      messagingSenderId: '297855924061',
      projectId: 'flutter-firebase-plugins',
      databaseURL: 'https://hopon-6bf7e-default-rtdb.firebaseio.com',
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
        title: 'Vehicle Sharing Platform',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Montserrat',

          primaryColor: Color.fromRGBO(0, 0, 0, 1),
        ),
        home: LandingPage(),
      ),
    );
  }
}