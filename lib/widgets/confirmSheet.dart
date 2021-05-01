import 'package:flutter/material.dart';

import 'widgets.dart';

class ConfirmSheet extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function onPressed;

  ConfirmSheet({this.title, this.subtitle, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 15.0,
            spreadRadius: 0.5,
            offset: Offset(
              0.7,
              0.7,
            ),
          ),
        ],
      ),
      height: 220,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 18),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.black87),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15, color: Colors.black54),
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                SizedBox(width: 50),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Expanded(
                    child: Container(
                      child: ConfirmSheetButton(
                        title: 'Back',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 36,
                ),
                GestureDetector(
                  onTap: onPressed,
                  child: Expanded(
                    child: Container(
                      child: ConfirmSheetButton(
                        title: 'Confirm',
                        color:
                            (title == 'Go Online') ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
