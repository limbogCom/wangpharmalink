import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/components/Home/CategoriesCard.dart';
//import 'package:flutter_demo/components/Home/ScanScreen.dart';
//import 'package:flutter_demo/components/Home/barcode.dart';
import 'package:flutter_demo/components/Home/body.dart';
import 'package:flutter_demo/components/reminder/NotificationPlugin.dart';
import 'package:flutter_demo/components/reminder/calendar.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/screens/Medicine_screen.dart';
import 'package:flutter_demo/screens/Reminder.dart';
import 'package:geolocator/geolocator.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Background extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Background> {

  Future _showNotification() async {
    var androidDetails = new AndroidNotificationDetails(
        "Channel ID", "Desi programmer", "This is my channel",
        importance: Importance.Max);
    var iOSDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
    new NotificationDetails(androidDetails, iOSDetails);
  }


  String _locationMessage = "";
  void _getCurrentLocation() async {
    final position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kPrimary,
      body: SingleChildScrollView(//แก้ overflow pixel
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Hi! ',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Deliver to',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              FlatButton(
                onPressed: () {
                  _getCurrentLocation();
                },
                child: Row(
                  children: [
                    Text(_locationMessage),
                    Text(
                      'Current location',
                      style: TextStyle(
                        color: kPrimaryColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(
                      Icons.location_on,
                      color: kPrimaryColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  boxShadow:[BoxShadow(
                    color: Colors.orangeAccent.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 9,
                    offset: Offset(0, 1),
                  ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: FlatButton(
                    onPressed: () {
                      //Navigator.push(context,
                      // MaterialPageRoute(builder: (context) => ()),
                      //);
                    },
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 22),
                    color: Colors.white,
                    splashColor: Colors.black,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.center_focus_weak,
                          color: kPrimaryColor,
                          size: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Scan barcode',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    'View all',
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                height: 125,
                child: ListView(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ReminderScreen()),
                        );
                      },
                      child: CategoryCard(
                        title: 'Reminders',
                        icon: Icons.alarm_on,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MedicineScreen()),
                        );
                      },
                      child: CategoryCard(
                        title: 'Medicines',
                        icon: Icons.local_pharmacy,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => notiHome()),
                        );
                      },
                      child: CategoryCard(
                        title: 'HealthCare',
                        icon: Icons.location_city,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomebodyPage()),
                        );
                      },
                      child: CategoryCard(
                        title: 'FirstAid',
                        icon: Icons.local_hospital,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Drugstore in Your Area',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'View all',
                    style: TextStyle(
                      color: Colors.black26,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              //Container(
              //padding: EdgeInsets.symmetric(vertical: 14,horizontal: 18),
              //margin: EdgeInsets.only(bottom: 20.0),
              //decoration: BoxDecoration(
              //child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //crossAxisAlignment: CrossAxisAlignment.start,
              //children: <Widget>[
              //CircleAvatar(
              //backgroundColor: Colors.grey,
              //radius: 36,
              //),
              //SizedBox(width: 10),
              //Column(
              //children: <Widget>[
              //RichText(
              //text: TextSpan(

              //)
              //)
              //],
              //)
              //],
              //)
              //),
              //),
            ],
          ),
        ),
      ),
    );
  }
}

void _getCurrentLocation() {
}


