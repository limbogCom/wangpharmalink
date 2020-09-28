import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/Notification/sharedPrefs.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/models/Druglist.dart';
import 'package:flutter_demo/size.config.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class DruglistCard extends StatelessWidget {

  List <druglist>druglistAll = [];

  var druglists;

  List statusOrderDrug = [
    '',
    'ก่อนอาหาร 30 นาที',
    'หลังอาหารทันที',
    'หลังอาหาร 15 นาที',
    'ขณะท้องว่าง'
  ];

  DruglistCard({Key key, this.druglists }) : super(key: key);

  String drugTime1, drugTime2, drugTime3, drugTime4, drugTime5, drugAlert;
  String showTime;

  setupTime(druglists) {
    if (druglists.drugTime1 != '00:00:00') {
      showTime = druglists.drugTime1;
    } else if (druglists.drugTime2 != '00:00:00') {
      showTime = druglists.drugTime2;
    } else if (druglists.drugTime3 != '00:00:00') {
      showTime = druglists.drugTime3;
    } else if (druglists.drugTime4 != '00:00:00') {
      showTime = druglists.drugTime4;
    } else if (druglists.drugTime5 != '00:00:00') {
      showTime = druglists.drugTime5;
    } else {
      if (druglists.drugAlert != '00:00:00') {
        showTime = druglists.drugAlert;
      } else
        showTime = '00:00:00';
    }
    print(showTime);
    return showTime.toString();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;
  static BuildContext context;
  SharedPreferences sharedPreferences;

  NotificationHelper() {
    initializedNotification();
  }

  initializedNotification() async {
    androidInitializationSettings = AndroidInitializationSettings('ic_notification');
    iosInitializationSettings = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    initializationSettings = InitializationSettings(
        androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payLoad) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
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

  Future<void> showNotificationBtweenInterval() async {
    await initSharedPrefs();
    await notificationCompare();


    var now = DateTime.now();
    var currentTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);

    var a = sharedPreferences.getString('startTime');
    var b = sharedPreferences.getString('endTime');

    SharedPreferences prefs = await SharedPreferences.getInstance();
    var patient_code = prefs.getString('patient_code');

    final response = await http.post(
        'https://wangpharma.com/pharmalink/API/drugs.php',
        body: {'patient_code': patient_code, 'drugs_list': '1'});

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      //print(jsonResponse);

      if (jsonResponse != null) {
        jsonResponse.forEach((druglists) => druglistAll.add(druglist.fromJson(druglists)));

        print(druglistAll);

      } else {
        print('Connect ERROR');
      }
    }

    //print('showTime ${druglist.drugAlert}');
    druglistAll.forEach((s) async {
      print(s.drugAlert);
    });

    print(a);
    print(b);

    print(currentTime);

    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'channel_Id',
      'Channel Name',
      'Channel Description',
      importance: Importance.Max,
      priority: Priority.High,
      enableVibration: true,
      enableLights: true,
      ticker: 'test ticker',
      playSound: true,
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, iosNotificationDetails);

    /* var star = DateTime
        .parse(a)
        .millisecondsSinceEpoch;
    var end = DateTime
        .parse(b)
        .millisecondsSinceEpoch;
    print(star);
    print(currentTime.millisecondsSinceEpoch);
    print(end);

    if ((star<currentTime.millisecondsSinceEpoch) && (end>currentTime.millisecondsSinceEpoch)) {
      print('check OK');
      await flutterLocalNotificationsPlugin.show(0, "",
          "Please subscribe my channel", notificationDetails);
    }
  }*/

    if (DateTime.parse(a).millisecondsSinceEpoch ==
        currentTime.millisecondsSinceEpoch) {
      print(
          "current Time is less than startTime so  , Cannot play notification");
      await flutterLocalNotificationsPlugin.cancel(0);
    }

    if (currentTime.millisecondsSinceEpoch >=
        DateTime.parse(a).millisecondsSinceEpoch &&
        currentTime.millisecondsSinceEpoch <=
            DateTime.parse(b).millisecondsSinceEpoch) {
      print('play notification');
      await flutterLocalNotificationsPlugin.show(0, "แจ้งเตือนกินยา!", "ถึงเวลากินยาแล้วค่ะ", notificationDetails);
    }

    if (currentTime.millisecondsSinceEpoch >
        DateTime.parse(b).millisecondsSinceEpoch) {
      print(
          "current time is greater than end time so, cannto play notification");
      await flutterLocalNotificationsPlugin.cancel(0);
    }
  }

  Future notificationCompare() async {
    await initSharedPrefs();
    var now = DateTime.now();
    var currentTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);

    var a = sharedPreferences.getString('startTime');
    var b = sharedPreferences.getString('endTime');

    var onlyCurrentDate = currentTime.toString().substring(0, 10);
    var onlyStartDate = a.toString().substring(0, 10);
    var onlyEndDate = b.toString().substring(0, 10);

    if (onlyEndDate == onlyCurrentDate && onlyStartDate == onlyCurrentDate) {
      print("same date");
      print(a.substring(11, 13));
    } else {
      print('date different');
      String startHour = a.substring(11, 13);
      String endHour = b.substring(11, 13);
      var setStart =
      DateTime(now.year, now.month, now.day, int.parse(startHour), 00);
      await setStartTime(setStart);
      var setEnd =
      DateTime(now.year, now.month, now.day, int.parse(endHour), 00);
      await setEndTime(setEnd);
    }
  }

  Future initSharedPrefs() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    // TODO: implement build
    return AspectRatio(
      aspectRatio: 0.8,
      child: ListView.builder(
        itemBuilder: (context, int index) {
          return Container(
            margin: new EdgeInsets.symmetric(
                horizontal: 10.0, vertical: 6.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
              onTap: () {
                showDialog(context: context,
                    builder: (_) =>
                    new AlertDialog(
                      title:
                      new Text(
                          '${druglists[index]
                              .drugName}', style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                          textAlign: TextAlign.center),
                      content: new Text('ครั้งละ ${druglists[index]
                          .drugDose} ${druglists[index]
                          .drugUnitdose}'
                          '  ${statusOrderDrug[int.parse(
                          druglists[index].drugOrder)]}'),

                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            "Skip", style: TextStyle(
                              color: kPrimaryColor, fontSize: 16),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        FlatButton(
                          child: Text(
                            "Take", style: TextStyle(
                              color: kPrimaryColor, fontSize: 16),),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(
                          width: 20,
                        ),
                      ],
                    )

                );
              },

              //leading: Image.asset('assets/images/pill.png', fit: BoxFit.cover, width: 60, height: 60,),
              //leading: Text('${druglist[index].drugTime1}',
              //  style: TextStyle(color: kPrimaryColor)),
              leading: Container(
                padding: EdgeInsets.only(right: 12.0),
                decoration: new BoxDecoration(
                    border: new Border(
                        right: new BorderSide(
                            width: 1.0, color: Colors.orange))),
                child: Text(setupTime(druglists[index])),
              ),
              title: Text('วันที่ ${druglists[index].drugStart}',
                  style: TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis),
              subtitle: Text(
                  '${druglists[index].drugName} ครั้งละ ${druglists[index]
                      .drugDose} ${druglists[index].drugUnitdose}'),
              trailing: IconButton(
                  icon: Icon(
                    Icons.alarm, color: Colors.orangeAccent, size: 30,),
                  onPressed: () {}
              ),
            ),
          );
        },
        itemCount: druglists != null ? druglists.length : 0,
      ),
    );
  }
}


  
