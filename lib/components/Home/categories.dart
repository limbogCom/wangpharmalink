import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/size.config.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}
class _CategoriesState extends State<Categories>{
  List<String> categories = ["All","8.00 AM", "12.00 PM", "6.00 PM",
    "10.00 PM", "12.00 AM"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: SizeConfig.defaultSize),
      child: SizedBox(
        height: SizeConfig.defaultSize * 3.5,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context,index) => buildCategoriItem(index),
        ),
      ),
    );
  }

  Widget buildCategoriItem(int index){
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: SizeConfig.defaultSize *2),
        padding: const EdgeInsets.symmetric(
          horizontal : 20 , //20
          vertical:  5, //5
        ),
        decoration: BoxDecoration(
            color: selectedIndex ==index ? Color(0xFFEFF3EE) : Colors.transparent,
            borderRadius: BorderRadius.circular(SizeConfig.defaultSize *1.6,
            )
        ),
        child: Text(
          categories[index],
          style: TextStyle(fontWeight: FontWeight.bold,
            color: selectedIndex == index? kPrimaryColor: Color(0xFFC2C2B5),
          ),
        ),
      ),
    );
  }
}