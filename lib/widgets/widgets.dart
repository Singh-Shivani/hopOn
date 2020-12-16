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
        //TODO: call validator function
        return validator(value);
      },
      decoration: InputDecoration(
        hintText: fieldName,
      ),
      obscureText: obscure,
    );
  }
}
