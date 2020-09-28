import 'package:flutter/material.dart';
import 'package:flutter_demo/Notification/sharedPrefs.dart';
import 'package:flutter_demo/button/my_bottom_nav_bar.dart';
import 'package:flutter_demo/components/reminder/body.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/screens/main_drawer.dart';
import 'package:flutter_demo/size.config.dart';
import 'package:flutter_svg/svg.dart';

class ReminderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var now = DateTime.now();
    var startTime = DateTime(now.year, now.month, now.day, 08, 00); // eg 7 AM
    var endTime = DateTime(now.year, now.month, now.day, 23, 59); // eg 10 PM
    setStartTime(startTime);
    setEndTime(endTime);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      drawer: MainDrawer(),
      body: Body(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text("Wang Reminder"),
      actions: <Widget>[
        IconButton(
            icon: SvgPicture.asset("assets/icons/search.svg"),
            onPressed: (){}
        ),
        SizedBox(width: SizeConfig.defaultSize * 0.5,)
      ],
    );

  }
}

