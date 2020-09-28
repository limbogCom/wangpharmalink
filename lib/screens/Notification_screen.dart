import 'package:flutter/material.dart';
import 'package:flutter_demo/button/my_bottom_nav_bar.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/size.config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      //body: Background(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text("ข่าวสารใหม่"),
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

