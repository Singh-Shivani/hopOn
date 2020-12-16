import 'package:firebase_auth/firebase_auth.dart';
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

  AuthenticationService _authenticationService =
      AuthenticationService(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            InputFormField(
              fieldName: 'Username',
              obscure: false,
              validator: ValidationService().emailValidator,
              controller: _emailController,
            ),
            InputFormField(
              fieldName: 'Password',
              obscure: true,
              validator: ValidationService().passswordValidator,
              controller: _passwordController,
            ),
            GestureDetector(
              onTap: () async {
                if (_formKey.currentState.validate()) {
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing')));
                  await _authenticationService
                      .signUp(
                          email: _emailController.text,
                          password: _passwordController.text)
                      .then((value) {
                    if (value != 'Signed up') {
                      Scaffold.of(context)
                          .showSnackBar(SnackBar(content: Text(value)));
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
    );
  }
}


