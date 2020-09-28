import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/models/NavItem.dart';
import 'package:flutter_demo/size.config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MyBottomNavBar extends StatelessWidget {
  const MyBottomNavBar({
    Key key,
  }) : super (key: key);

  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    return Consumer<NavItems>(
      builder: (context, navItems, child) =>
          Container(
            padding: EdgeInsets.symmetric(horizontal: defaultSize * 3),
            //height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, -7),
                  blurRadius: 30,
                  color: Color(0xFF4B1A39).withOpacity(0.2),
                ),
              ],
            ),
            child: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  navItems.items.length,
                      (index) =>
                      buildIconNavBarItem(
                        isActive: navItems.selectedIndex == index ? true : false,
                        icon: navItems.items[index].icon,
                        press: () {
                         navItems.changeNavIndex(index: index);
                         if (navItems.items [index].destinationChecker())
                           Navigator.push(
                             context,
                             MaterialPageRoute(
                               builder: (context) => navItems.items[index].destination,
                             ),
                           );
                        }
                      ),
                  ),
                ),
              ),
            ),
    );
  }
}


      IconButton buildIconNavBarItem({String icon, Function press, bool isActive = false}){
        return IconButton(
          icon: SvgPicture.asset(
              icon,
            color: isActive ? kPrimaryColor : Color(0xFF37474F),
            height: 22,
          ),
            onPressed: press,
        );
      }