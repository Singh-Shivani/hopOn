import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/dataHandler/appdata.dart';
import 'package:vehicle_sharing_app/screens/home_page.dart';
import 'package:vehicle_sharing_app/screens/login_page.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';

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
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        ChangeNotifierProvider(
          create: (context) => AppData(),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
        ),
      ],
      child: MaterialApp(
        title: 'hopOn',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'OpenSans',
          primaryColor: Color.fromRGBO(0, 0, 0, 1),
          // 27, 34, 46
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return HomePage();
    } else {
      return LoginPage();
    }
  }
}
