import 'package:flutter/material.dart';
import 'package:flutter_demo/Notification/sharedPrefs.dart';
import 'package:flutter_demo/models/Druglist.dart';
import 'calendar.dart';

class notiHome extends StatefulWidget {
  @override
  _notiHomeState createState() => _notiHomeState();
}

class _notiHomeState extends State<notiHome> {
  @override
  void initState() {
    super.initState();
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, 08, 00); // eg 7 AM
    var endTime = DateTime(now.year, now.month, now.day, 23, 59); // eg 10 PM
    setStartTime(startTime);
    setEndTime(endTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          color: Colors.blue,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CustomizedNotification();
            }));
          },
          child: Container(
            height: 60,
            width: 100,
            child: Icon(
              Icons.alarm,
              color: Colors.white,
              size: 50,
            ),
          ),
        ),
      ),
    );
  }
}