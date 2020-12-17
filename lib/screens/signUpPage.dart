import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/screens/completeProfile.dart';
import 'package:vehicle_sharing_app/services/authentication_service.dart';
import 'package:vehicle_sharing_app/services/validation_services.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();

  AuthenticationService _authenticationService =
      AuthenticationService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Builder(builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Text(
                    'hopOn',
                    style: TextStyle(
                      fontSize: 40,
                      letterSpacing: 4,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'MuseoModerno',
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InputFormField(
                            fieldName: 'Username',
                            obscure: false,
                            validator: ValidationService().emailValidator,
                            controller: _emailController,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          InputFormField(
                            fieldName: 'Password',
                            obscure: true,
                            validator: ValidationService().passwordValidator,
                            controller: _passwordController,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          InputFormField(
                            fieldName: 'Re-Enter Password',
                            obscure: true,
                            validator: ValidationService().rePasswordValidator,
                            controller: _repasswordController,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Password must contain:\n1.Must be atleast of 8 characters\n2.Must contain an upper case character\n3.Must contain a lower case character\n4.Must contain a special character\n5.Must contain a digit.',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState.validate()) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Processing')));

                            await _authenticationService
                                .signUp(
                                    email: _emailController.text,
                                    password: _passwordController.text)
                                .then((value) {
                              if (value != 'Signed up') {
                                Scaffold.of(context).showSnackBar(
                                    SnackBar(content: Text(value)));
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
                            });
                          }
                        },
                        child: CustomButton(
                          text: 'SignUp',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
