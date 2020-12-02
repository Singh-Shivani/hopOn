import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vehicle_sharing_app/screens/signUpPage.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget _buildLogin() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          InputTextField(
            label: 'Email-Id',
            icon: Icon(Icons.email_outlined),
          ),
          InputTextField(
            label: 'Password',
            icon: Icon(Icons.lock),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap:(){
              //TODO: Go to Home Page.
            },
            child: CustomButton(text: 'Login'),
          ),
          Text("\nDon't have any account?"),
          GestureDetector(
            onTap: () {
              print('Signup');
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return SignUpPage();
                }),
              );
            },
            child: Text(
              'SignUp here',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(top: 150),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'hopOn',
                  style: TextStyle(
                    fontSize: 50,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'MuseoModerno',
                  ),
                ),
                SizedBox(height: 100),
                _buildLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
