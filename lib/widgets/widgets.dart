import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;

  CustomButton({@required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
class InputTextField extends StatelessWidget {

  final String label;
  final Icon icon;
  InputTextField({ @required this.label,@required this.icon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        decoration: InputDecoration(
            icon: icon,

            labelText: label,
        ),
        onSaved: (String value) {
          // This optional block of code can be used to run
          // code when the user saves the form.
        },
        validator: (String value) {
          return value.length < 4 ? 'Enter a valid Email-Id' : null;
        },

      ),
    );
  }
}

