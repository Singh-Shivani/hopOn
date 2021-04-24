import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'homePage.dart';
import '../widgets/widgets.dart';
import '../globalvariables.dart';
import 'loginPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var userNameController = TextEditingController();

  var emailIdController = TextEditingController();

  var ageController = TextEditingController();

  var bloodTypeController = TextEditingController();

  var mobileNoController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPassController = TextEditingController();

  var licenseNoController = TextEditingController();

  void registerUser() async {
    // dialog
    showDialog(
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Registering you... ',
      ),
    );

    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: emailIdController.text,
      password: passwordController.text,
    )
        .catchError((e) {
      // PlatformException thisEx = e;
      Navigator.pop(context);
      showSnackBar(e.message);
    });

    if (userCredential != null) {
      currentFirebaseUser = userCredential;
      DatabaseReference newUserRef = FirebaseDatabase.instance
          .reference()
          .child('users/${userCredential.user.uid}');

      newUserRef.set({
        'userName': userNameController.text,
        'email': emailIdController.text,
        'age': ageController.text,
        'bloodType': bloodTypeController.text,
        'mobileNo': mobileNoController.text,
        'licenseNo': licenseNoController.text,
      });



      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return HomePage();
        }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              InputTextField(
                controller: userNameController,
                label: 'User name',
                icon: Icon(Icons.person),
              ),
              InputTextField(
                controller: emailIdController,
                label: 'Email-Id',
                icon: Icon(Icons.email_outlined),
              ),
              InputTextField(
                controller: ageController,
                label: 'Age',
                icon: Icon(Icons.cake_outlined),
              ),
              InputTextField(
                controller: bloodTypeController,
                label: 'Blood Type',
                icon: Icon(Icons.lens_rounded),
              ),
              InputTextField(
                controller: mobileNoController,
                label: 'Mobile No.',
                icon: Icon(Icons.phone),
              ),
              InputTextField(
                controller: licenseNoController,
                label: 'License No.',
                icon: Icon(Icons.description_outlined),
              ),
              InputTextField(
                controller: passwordController,
                label: 'Password',
                icon: Icon(Icons.lock),
              ),
              InputTextField(
                controller: confirmPassController,
                label: 'Confirm Password',
                icon: Icon(Icons.lock),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  // network connectivity
                  var connectivityResult =
                      await Connectivity().checkConnectivity();
                  if (connectivityResult != ConnectivityResult.mobile &&
                      connectivityResult != ConnectivityResult.wifi) {
                    showSnackBar('No Internet connectivity');
                    return;
                  }

                  if (userNameController.text.length < 3) {
                    showSnackBar('Please provide a valid username');
                  }
                  if (!emailIdController.text.contains('@')) {
                    showSnackBar('Please provide a valid email address');
                  }
                  if (ageController.text.length > 2) {
                    showSnackBar('Please provide a valid age');
                  }
                  if (bloodTypeController.text.length > 2) {
                    showSnackBar('Please provide a valid blood type');
                  }
                  if (mobileNoController.text.length > 10) {
                    showSnackBar('Please provide a valid mobile number');
                  }
                  if (passwordController.text.length < 6) {
                    showSnackBar(
                        'Please provide a password of length more than 6');
                  }
                  if (passwordController.text.length !=
                      confirmPassController.text.length) {
                    showSnackBar(
                        'Password and confirm password does not match');
                  }
                  registerUser();
                },
                child: CustomButton(text: 'Sign Up'),
              ),
              Text('\nAlready a registerd user?'),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }),
                  );
                },
                child: Text(
                  'Login here',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
