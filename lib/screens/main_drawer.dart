import  'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/models/patientdata.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MainDrawer extends StatelessWidget{
  @override

  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            child:  Center(
              child: Column(
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 100,
                    margin: EdgeInsets.only(
                      top: 30,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                        image: DecorationImage(
                          image: ExactAssetImage(
                              'assets/images/userpic.png'),
                          fit: BoxFit.fill
                      )
                    ),
                  ),
                  Text("ณเดชน์", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,
                   ),
                  ),
                  Text('0777', style: TextStyle(fontSize: 16, color: Colors.white,//patient_id
                  ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings) ,
            title: Text(
              'Setting',
              style: TextStyle(
                fontSize: 16,
                color: kPrimaryColor,
              ),
            ),
            onTap: null,
          ),
        ListTile(
           leading: Icon(Icons.exit_to_app) ,
            title: Text(
             'Log out',
              style: TextStyle(
              fontSize: 16,
              color: kPrimaryColor,
               ),
              ),
           onTap: null,
         ),
        ],
      ),
    );
  }

}


