import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vehicle_sharing_app/screens/homePage.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              'hopOn',
              style: TextStyle(
                fontSize: 40,
                letterSpacing: 4,
                fontWeight: FontWeight.w600,
                fontFamily: 'MuseoModerno',
              ),
            ),
            Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: "Username",
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock_rounded),
                    hintText: "Password",
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                //TODO: Validate and then push to Home Page
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return HomePage();
                    },
                  ),
                );
              },
              child: CustomButton(text: 'Login'),
            ),
            Column(
              children: [
                Text("Don't have any account?\n"),
                Text(
                  'SignUp here',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            // SizedBox(height:30),
          ],
        ),
      ),
    );
  }
}
