import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/screens/completeProfile.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';

import '../widgets/widgets.dart';
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
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => ProgressDialog(
                      status: 'Registering you... \n'
                          'Please Wait',
                    ),
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
                },
                child: AvailabilityButton(text: 'Sign Up'),
              ),
              Text('\nAlready a registered user?'),
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
