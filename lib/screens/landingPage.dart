import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/api/api.dart';
import 'package:vehicle_sharing_app/notifier/authNotifier.dart';
import 'package:vehicle_sharing_app/screens/homePage.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';
import 'package:vehicle_sharing_app/screens/loginPage.dart';
import 'package:provider/provider.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  @override
  void initState() {
    // AuthNotifier authNotifier =
    // Provider.of<AuthNotifier>(context, listen: false);
    // initializeCurrentUser(authNotifier, context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
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
            onTap:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  // return (authNotifier.user == null)
                  //     ? LoginPage()
                  //     :HomePage();
                  return LoginPage();
                }),
              );
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

