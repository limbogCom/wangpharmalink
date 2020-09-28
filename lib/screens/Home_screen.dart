import 'package:flutter/material.dart';
import 'package:flutter_demo/button/my_bottom_nav_bar.dart';
import 'package:flutter_demo/components/Home/background.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/screens/main_drawer.dart';
import 'package:flutter_demo/size.config.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: buildAppBar(),
      drawer: MainDrawer(),
      body: Background(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
    AppBar buildAppBar() {
    return AppBar(
        //leading: IconButton(
          //  icon: SvgPicture.asset("assets/icons/menu.svg"),
            //onPressed: (){}
        //),
       centerTitle: true,
       title: Text("Wang Pharmalink"),
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

