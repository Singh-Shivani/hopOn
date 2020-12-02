import 'package:flutter/material.dart';
import 'package:vehicle_sharing_app/screens/loginPage.dart';
import 'package:vehicle_sharing_app/widgets/widgets.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            InputTextField(
              label: 'User name',
              icon: Icon(Icons.person),
            ),
            InputTextField(
              label: 'Email-Id',
              icon: Icon(Icons.email_outlined),
            ),
            InputTextField(
              label: 'Age',
              icon: Icon(Icons.cake_outlined),
            ),
            InputTextField(
              label: 'Blood Type',
              icon: Icon(Icons.lens_rounded),
            ),
            InputTextField(
              label: 'Mobile No.',
              icon: Icon(Icons.phone),
            ),
            InputTextField(
              label: 'Password',
              icon: Icon(Icons.lock),
            ),
            InputTextField(
              label: 'Confirm Passsword',
              icon: Icon(Icons.lock),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                //TODO: Go to home Page.
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
    );
  }
}
