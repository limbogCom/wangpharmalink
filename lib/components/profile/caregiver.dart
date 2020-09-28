import 'package:flutter/material.dart';
import 'package:flutter_demo/button/my_bottom_nav_bar.dart';
import 'package:flutter_demo/components/profile/caregiverprofile.dart';
import '../../size.config.dart';

class CaregiverScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        centerTitle: true,
        title: Text("Caregiver"),
        actions: <Widget>[
        ],
      ),
      body: CaregiverProfile(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}
