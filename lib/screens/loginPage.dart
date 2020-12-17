import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vehicle_sharing_app/screens/completeProfile.dart';
import 'package:vehicle_sharing_app/screens/signUpPage.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthenticationService _authenticationService =
      AuthenticationService(FirebaseAuth.instance);

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(
        builder: (context) {
          return Padding(
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
                      controller: _emailController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person_outline),
                        hintText: "Username",
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_rounded),
                        hintText: "Password",
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Scaffold.of(context)
                        .showSnackBar(SnackBar(content: Text('Processing')));

                    _authenticationService
                        .signIn(
                            email: _emailController.text,
                            password: _passwordController.text)
                        .then((value) {
                      if (value != "Signed in") {
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text(value)));
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CompleteProfile();
                            },
                          ),
                        );
                      }
                    });
                  },
                  child: CustomButton(text: 'Login'),
                ),
                Column(
                  children: [
                    Text("Don't have any account?\n"),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              print('signupclicked');
                              return SignUp();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'SignUp here',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height:30),
              ],
            ),
          );
        },
      ),
    );
  }
}
