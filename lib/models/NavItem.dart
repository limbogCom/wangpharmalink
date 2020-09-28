import 'package:flutter/material.dart';
import 'package:flutter_demo/screens/Home_screen.dart';
import 'package:flutter_demo/screens/Notification_screen.dart';
import 'package:flutter_demo/screens/Profile_screen.dart';

class NavItem {
  final int id;
  final String icon,text;
  final Widget destination;

  NavItem({this.id, this.icon ,this.text, this.destination});

  bool destinationChecker() {
    if (destination != null ){
      return true;
    }
      return false;
  }
}

class NavItems extends ChangeNotifier{
  int selectedIndex = 1;

  void changeNavIndex({int index}) {
    selectedIndex= index;
    notifyListeners();
  }
  List<NavItem> items = [
    NavItem(
      id: 1,
      icon: "assets/icons/home.svg",
      text: "",
      destination: Home(),
  ),
    NavItem(
    id: 2,
    icon: "assets/icons/comment.svg",
    ),
    NavItem(
    id: 3,
    icon: "assets/icons/notification.svg",
      destination: NotificationScreen(),
    ),
    NavItem(
    id: 4,
     icon: "assets/icons/user.svg",
      destination: ProfileScreen(),
      ),
  ];
}