import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo/Notification/notificationHelper.dart';
import 'package:flutter_demo/Notification/sharedPrefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:flutter_demo/models/Druglist.dart';
import 'package:flutter_demo/components/reminder/body.dart';

class CustomizedNotification extends StatefulWidget {
  @override
  _CustomizedNotificationState createState() => _CustomizedNotificationState();

}

class _CustomizedNotificationState extends State<CustomizedNotification> {
  String startTime = "";
  String endTime = "";


  @override
  void initState() {
    super.initState();
    getTime();
  }

  static periodicCallback() {
    NotificationHelper().showNotificationBtweenInterval();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Notification Start From",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        startTime,
                        style: TextStyle(fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Notification Stop From",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        endTime,
                        style: TextStyle(fontSize: 30),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: RaisedButton(
                          color: Colors.blue,
                          onPressed: () async {
                            WidgetsFlutterBinding.ensureInitialized();
                            await AndroidAlarmManager.initialize();
                            onTimePeriodic();
                          },
                          child: Text(
                            "Okay , Trigger Alarm",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  // getD(){
  //   SharedPreferences.getInstance().then((value) {
  //     var a = value.getString('dai');
  //     print(a);
  //   });
  // }

  //   Future sujan() async {
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   sharedPreferences.setString("dai", "lado");
  // }

  onTimePeriodic() {
    SharedPreferences.getInstance().then((value) async {
      var a = value.getBool('oneTimePeriodic') ?? false;
      if (!a) {
        await AndroidAlarmManager.periodic(
            Duration(hours: 1), 0, periodicCallback);
        onlyOneTimePeriodic();
      } else {
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
class NotificationHelper {
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
    androidInitializationSettings =
        AndroidInitializationSettings('ic_notification');
    iosInitializationSettings = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    initializationSettings = InitializationSettings(
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

  Future<void> showNotificationBtweenInterval() async {
    await initSharedPrefs();
    await notificationCompare();

    var now = DateTime.now();
    var currentTime =
    DateTime(now.year, now.month, now.day, now.hour, now.minute);

    var a = sharedPreferences.getString('startTime');
    var b = sharedPreferences.getString('endTime');

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
    NotificationDetails notificationDetails =
    NotificationDetails(androidNotificationDetails, iosNotificationDetails);

    var star = DateTime
        .parse(a)
        .millisecondsSinceEpoch;
    var end = DateTime
        .parse(b)
        .millisecondsSinceEpoch;
    print(star);
    print(currentTime.millisecondsSinceEpoch);
    print(end);


    if ((star < currentTime.millisecondsSinceEpoch) &&
        (end > currentTime.millisecondsSinceEpoch)) {
      print('check OK');
      await flutterLocalNotificationsPlugin.show(0, "Hello there!",
          "สถานะ : ถึงเวลากินยาแล้วค่ะ", notificationDetails);
    }
  }

/*
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
      await flutterLocalNotificationsPlugin.show(0, "Hello there!",
          "Please subscribe my channel", notificationDetails);
    }

    if (currentTime.millisecondsSinceEpoch >
        DateTime.parse(b).millisecondsSinceEpoch) {
      print(
          "current time is greater than end time so, cannto play notification");
      await flutterLocalNotificationsPlugin.cancel(0);
    }
  }
*/
  Future notificationCompare() async {
    await initSharedPrefs();
    var now = DateTime.now();
    var currentTime =
    DateTime(now.year, now.month, now.day, now.hour, now.minute);

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
}