import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 210,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                spreadRadius: 0.5,
                offset: Offset(
                  0.7,
                  0.7,
                ),
              ),
              ]
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 24, top: 48, right: 24, bottom: 20),
              child: Column(
                children: [

                  SizedBox(height: 5,),
                  Stack(
                    children: [
                      GestureDetector(
                        onTap:(){
                          Navigator.pop(context);
                        },
                        child: Icon(Icons.arrow_back)),
                      Center(
                        child: Text('Set Destination',
                          style: TextStyle(fontSize: 20, fontFamily: 'Brand-Bold'),
                        ),
                      )
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Image.asset('images/pick_icon.png', height: 16, width: 16,),
                      SizedBox(width: 18,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                              decoration: InputDecoration(
                                 hintText: 'Pickup location',
                                fillColor: Colors.grey,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 10, top: 8, bottom: 8 )

                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Image.asset('images/pick_icon.png', height: 16, width: 16,),
                      SizedBox(width: 18,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: 'Where to ',
                                  fillColor: Colors.grey,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left: 10, top: 8, bottom: 8 )

                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
