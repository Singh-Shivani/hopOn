import 'package:firebase_auth/firebase_auth.dart';
import 'package:connectivity/connectivity.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:vehicle_sharing_app/screens/signUpPage.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';
import 'choose.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title){
    final snackbar = SnackBar(
      content: Text(title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15),),);
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  var emailIdController = TextEditingController();
  var passwordController = TextEditingController();

  void login() async {

    // dialog
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(status: 'Logging you in',),
    );


    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailIdController.text,
      password: passwordController.text,
    ).catchError((e){
      // PlatformException thisEx = e;
      Navigator.pop(context);
      showSnackBar(e.message);
    });

    if (userCredential!=null){
      DatabaseReference userRef = FirebaseDatabase.instance.reference().child('users/${userCredential.user.uid}');

      userRef.once().then((DataSnapshot snapshot){
        if(snapshot.value != null){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return ChooseOption();
            }),
          );
        }
      });
    }
  }

  Widget _buildLogin() {
    return  Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          InputTextField(
            controller: emailIdController,
            label: 'Email-Id',
            icon: Icon(Icons.email_outlined),
          ),
          InputTextField(
            controller: passwordController,
            label: 'Password',
            icon: Icon(Icons.lock),
          ),
          SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap:() async {
              // network connectivity
              var connectivityResult = await Connectivity().checkConnectivity();
              if(connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi){
                showSnackBar('No Internet connectivity');
                return;
              }

              if(!emailIdController.text.contains('@')){
                showSnackBar('Please provide a valid email address');
              }

              if(passwordController.text.length < 6){
                showSnackBar('Please provide a password of length more than 6');
              }

              login();
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
      key: scaffoldKey,
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
