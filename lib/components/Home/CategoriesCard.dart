import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    this.icon,
    this.title,
  }) : super(key: key);
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 125,
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(20),
        //boxShadow: [
          //BoxShadow(
            //color: Color(0xFF073738),
            //offset: Offset(1, 2),
            //blurRadius: 10,
          //),
       // ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}