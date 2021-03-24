import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../widgets/widgets.dart';
import 'login.dart';

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
                  return LoginPage();
                }),
              );
            },
            child: CustomButton(
              text: 'Go',
            ),)

        ],
      ),
    );
  }
}

