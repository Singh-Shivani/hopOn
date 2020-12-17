import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/screens/completeProfile.dart';
import 'package:vehicle_sharing_app/screens/homePage.dart';
import 'package:vehicle_sharing_app/screens/loginPage.dart';
import 'package:vehicle_sharing_app/services/firebase_services.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  FirebaseFunctions firebaseFunctions = FirebaseFunctions();
  bool profileComplete;

  @override
  void initState() {
    profileComplete = false;
    checkProfile();
    super.initState();
  }

  void checkProfile() async {
    bool res = await firebaseFunctions.hasUserCompletedProfile();
    setState(() {
      profileComplete = res;
    });
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
                print(profileComplete);
                if (profileComplete) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return HomePage();
                      },
                    ),
                  );
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
