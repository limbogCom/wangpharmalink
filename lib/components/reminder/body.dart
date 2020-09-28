import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Notification/sharedPrefs.dart';
import 'package:flutter_demo/components/reminder/background.dart';
import 'package:flutter_demo/Notification/notificationHelper.dart';
import 'package:flutter_demo/components/reminder/categories.dart';
import 'package:flutter_demo/components/reminder/druglistCard.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/models/Druglist.dart';
import 'package:flutter_demo/size.config.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  State createState() => BodyState();
}

class BodyState extends State<Body> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;
  SharedPreferences sharedPreferences;


  String startTime = "";
  String endTime = "";

  var patient_code;

  List <druglist>druglistAll = [];

  _connectDrug() async {
    print(patient_code);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    patient_code = prefs.getString('patient_code');

    final response = await http.post(
        'https://wangpharma.com/pharmalink/API/drugs.php',
        body: {'patient_code': patient_code, 'drugs_list': '1'});

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      //print(jsonResponse);

      if (jsonResponse != null) {
        jsonResponse.forEach((druglists) =>
            druglistAll.add(druglist.fromJson(druglists)));

        druglistAll.forEach((druglist) async {
          WidgetsFlutterBinding.ensureInitialized();
          await AndroidAlarmManager.initialize();
          onTimePeriodic();
        });


        print(druglistAll);

        setState(() {
          return druglistAll;
        });
      } else {
        print('Connect ERROR');
      }
    }
  }


  initializedNotification() async {
    var androidInitializationSettings =
    AndroidInitializationSettings('ic_notification');
    var iosInitializationSettings = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    var initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }


  Future onDidReceiveLocalNotification(int id, String title, String body,
      String payLoad) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) =>
            CupertinoAlertDialog(
              title: Text(title),
              content: Text(body),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('OKay'),
                  onPressed: () {
                    // do something here
                  },
                )
              ],
            ));
  }


  @override
  void initState() {
    super.initState();
    _connectDrug();
    initializedNotification();
    getTime();
  }

  static periodicCallback() {
    DruglistCard().showNotificationBtweenInterval();
  }

  @override
  DateTime _dateTime;

  Widget build(BuildContext context) {
    // TODO: implement build

    return SafeArea(
      child: Background(child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Categories(),
            Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(
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
                    showDatePicker(
                        context: context,
                        initialDate: _dateTime == null
                            ? DateTime.now()
                            : _dateTime,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2025)
                    ).then((date) {
                      setState(() {
                        _dateTime = date;
                      });
                    });
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  color: Colors.orange,
                  splashColor: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today,
                        color: Colors.white,
                        size: 25,
                      ),
                      Text(" Select Date"),
                      SizedBox(width: 10),
                      Text(_dateTime == null ? '' : _dateTime.toString()),
                    ],
                  ),
                ),
              ),
            ),
            //Container(
            //alignment: Alignment.topRight,
            //child: new FloatingActionButton(child: new Icon(Icons.calendar_today), heroTag: 2,
            //onPressed: () {
            //showDatePicker(
            //  context: context, initialDate: _dateTime == null ? DateTime.now() : _dateTime,
            //firstDate: DateTime(2001),
            //lastDate: DateTime(2025)
            //).then((date) {
            //setState(() {
            //_dateTime = date;
            //});
            //});
            //},
            //backgroundColor: Colors.orange,
            //),
            //),
            //Text(_dateTime == null ? '' : _dateTime.toString()),
            DruglistCard(druglists: druglistAll),

            //Text("รายละเอียดยา",
            //style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            //),
            //Image.asset("assets/images/Artboard 1.png",
            //height: size.height * 0.1,
            //),

          ],
        ),
      ),
      ),
    );
  }

  onTimePeriodic() {
    SharedPreferences.getInstance().then((value) async {
      var a = value.getBool('oneTimePeriodic') ?? false;
      if (!a) {
        await AndroidAlarmManager.periodic(Duration(seconds: 30), 0, periodicCallback);
        onlyOneTimePeriodic();
      } else {
        await AndroidAlarmManager.periodic(Duration(seconds: 30), 0, periodicCallback);
        print("Cannot run more than once");
      }
    });
  }

  getTime() {
    SharedPreferences.getInstance().then((value) {
      var a = value.getString('startTime');
      var b = value.getString('endTime');

      if (a != null && b != null) {
        setState(() {
          startTime = DateFormat('jm').format(DateTime.parse(a));
          endTime = DateFormat('jm').format(DateTime.parse(b));
        });
      }
    });
  }
}