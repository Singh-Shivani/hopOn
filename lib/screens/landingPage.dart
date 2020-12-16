import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/screens/loginPage.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'hopOn',
            style: TextStyle(
              fontSize: 60,
              letterSpacing: 4,
              fontWeight: FontWeight.w600,
              fontFamily: 'MuseoModerno',
            ),
          ),
          SizedBox(height: 30),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    height: 1.5,
                    color: Colors.black,
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: MediaQuery.of(context).size.width / 2 - 40,
                    height: 1.5,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(width: 30),
              Image.asset('images/1299989.png', width: 180),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              if (firebaseUser != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      //TODO: add home page here
                      return;
                    },
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginPage();
                    },
                  ),
                );
              }
            },
            child: CustomButton(
              text: 'Go',
            ),
          ),
        ],
      ),
    );
  }
}
