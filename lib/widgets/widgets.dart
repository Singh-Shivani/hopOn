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

class InputFormField extends StatelessWidget {
  const InputFormField({
    Key key,
    @required this.fieldName,
    @required this.obscure,
    @required this.validator,
    @required this.controller,
  }) : super(key: key);

  final String fieldName;
  final bool obscure;
  final Function validator;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        return validator(value);
      },
      decoration: InputDecoration(
        hintText: fieldName,
      ),
      obscureText: obscure,
    );
  }
}


class ProgressDialog extends StatelessWidget {

  final String status;
  ProgressDialog({this.status});

  @override

  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0)
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.0)
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              SizedBox(width: 5,),
              CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black54),),
              SizedBox(width: 25,),
              Text(status, style: TextStyle(fontSize: 15),),
            ],
          ),
        ),
      ),
    );
  }
}

class InputTextField extends StatelessWidget {

  final String label;
  final Icon icon;
  final TextEditingController controller;
  InputTextField({ @required this.label,@required this.icon, @required this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
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

class AvailabilityButton extends StatelessWidget {
  final String text;
  final Color color;

  AvailabilityButton({@required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      height: 70,
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ConfirmSheetButton extends StatelessWidget {

  final String title;
  final Color color;


  ConfirmSheetButton({this.title,this.color,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.all(Radius.circular(25)),
      ),
      child: Container(
        height: 50.0,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 22.0, fontFamily: 'MuseoModemo', color: Colors.black87),

          ),
        ),
      ),
    );
  }
}



