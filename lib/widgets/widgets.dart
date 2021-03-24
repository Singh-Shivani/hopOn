import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';


final kDrawerItemStyle = TextStyle(fontSize: 16);


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

class BrandDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Divider(height: 1.0, color: Color(0xFFe2e2e2), thickness: 1.0,);
  }
}

class DrawerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(0),
        children: [
          Container(
            color: Colors.white,
            height: 160,
            child: DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.white
              ),
              child: Row(
                children: [
                  Image.asset('images/user_icon.png', height: 60, width: 60,),
                  SizedBox(width: 15,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Yasha Shetty', style: TextStyle(fontSize: 20),),
                      SizedBox(height: 5,),
                      Text('View Profile', style: TextStyle(fontSize: 15),),
                    ],
                  )
                ],
              ),
            ),
          ),

          BrandDivider(),

          SizedBox(height: 10,),

          ListTile(
            leading: Icon(OMIcons.cardGiftcard),
            title: Text('Home', style: kDrawerItemStyle,),
          ),
          ListTile(
            leading: Icon(OMIcons.creditCard),
            title: Text('Payments', style: kDrawerItemStyle,),
          ),
          ListTile(
            leading: Icon(OMIcons.history),
            title: Text('Ride History', style: kDrawerItemStyle,),
          ),
          ListTile(
            leading: Icon(OMIcons.contactSupport),
            title: Text('Support', style: kDrawerItemStyle,),
          ),
          ListTile(
            leading: Icon(OMIcons.info),
            title: Text('About', style: kDrawerItemStyle,),
          ),
        ],
      ),
    );
  }
}








