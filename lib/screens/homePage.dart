import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthenticationService _authenticationService =
      AuthenticationService(FirebaseAuth.instance);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              'THIS IS THE HOME PAGE',
              style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
            ),
            // SizedBox(
            //   height: 30,
            // ),
            // Text(FirebaseAuth.instance.currentUser.displayName),
            SizedBox(
              height: 30,
            ),
            Text(
              FirebaseAuth.instance.currentUser.email,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30,
            ),
            FlatButton(
              onPressed: () {
                _authenticationService.signOut(context);
              },
              child: Text('Sign Out'),
            )
          ],
        ),
      ),
    );
  }
}
