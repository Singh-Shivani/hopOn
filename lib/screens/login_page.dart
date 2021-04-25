import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:vehicle_sharing_app/screens/home_page.dart';
import 'package:vehicle_sharing_app/screens/signup_page.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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

  Widget _buildLogin() {
    return Padding(
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
            onTap: () async {
              // network connectivity
              var connectivityResult = await Connectivity().checkConnectivity();
              if (connectivityResult != ConnectivityResult.mobile &&
                  connectivityResult != ConnectivityResult.wifi) {
                showSnackBar('No Internet connectivity');
                return;
              }

              if (!emailIdController.text.contains('@')) {
                showSnackBar('Please provide a valid email address');
              }

              if (passwordController.text.length < 6) {
                showSnackBar('Please provide a password of length more than 6');
              }
              showDialog(
                context: context,
                builder: (BuildContext context) => ProgressDialog(
                  status: 'Logging you in...',
                ),
              );
              context
                  .read<AuthenticationService>()
                  .signIn(
                    email: emailIdController.text.trim(),
                    password: passwordController.text.trim(),
                  )
                  .then((value) => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }),
                      ));
            },
            child: CustomButton(text: 'Login'),
          ),
          Text("\nDon't have any account?"),
          GestureDetector(
            onTap: () {
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
