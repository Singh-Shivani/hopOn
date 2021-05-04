import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/screens/complete_profile.dart';
import 'package:vehicle_sharing_app/screens/login_page.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';

import '../widgets/widgets.dart';

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

  var emailIdController = TextEditingController();

  var passwordController = TextEditingController();

  var confirmPassController = TextEditingController();

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
              Text(
                'hopOn',
                style: TextStyle(
                  fontSize: 50,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'MuseoModerno',
                  // color: Colors.white,
                ),
              ),
              SizedBox(height: 30),
              InputTextField(
                controller: emailIdController,
                label: 'Email-Id',
                obscure: false,
                icon: Icon(Icons.email_outlined),
              ),
              InputTextField(
                controller: passwordController,
                label: 'Password',
                obscure: true,
                icon: Icon(Icons.lock),
              ),
              InputTextField(
                controller: confirmPassController,
                label: 'Confirm Password',
                obscure: true,
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
                  BuildContext dialogContext;
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      dialogContext = context;
                      return ProgressDialog(
                        status: 'Registering you\nPlease wait',
                      );
                    },
                  );

                  context
                      .read<AuthenticationService>()
                      .signUp(
                        email: emailIdController.text.trim(),
                        password: passwordController.text.trim(),
                      )
                      .then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return CompleteProfile();
                          }),
                        ),
                      );
                  Navigator.pop(dialogContext);
                },
                child: CustomButton(
                  text: 'Sign Up',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return LoginPage();
                    }),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already a registered user?\t',
                      style: TextStyle(fontSize: 10),
                    ),
                    Text(
                      'Login here',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
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
