import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  final String amount;

  PaymentPage({@required this.amount});
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(widget.amount),
    );
  }
}
