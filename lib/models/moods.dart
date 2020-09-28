import 'package:flutter/material.dart';
import 'package:flutter_demo/constants.dart';

class Mymoods extends StatefulWidget{
  @override
  _MyMoodsState createState() => _MyMoodsState();
}

class _MyMoodsState extends State<Mymoods> {
  List<bool> isSelecketed = List.generate(5, (_) => false);
  @override
Widget build(BuildContext context){
// TODO: implement build
return Center(
  child: ToggleButtons(
    selectedBorderColor: kPrimaryColor,
    renderBorder: false,
    fillColor: Colors.transparent,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0),
        child: Icon(Icons.sentiment_very_dissatisfied,size: 36,),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0),
        child: Icon(Icons.sentiment_dissatisfied,size: 36,),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0),
        child: Icon(Icons.sentiment_neutral,size: 36,),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0),
        child: Icon(Icons.sentiment_satisfied,size: 36,),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 12.0,right: 12.0),
        child: Icon(Icons.sentiment_very_satisfied,size: 36,),
      ),
    ],
    isSelected: isSelecketed,
    onPressed: (int index) {
      setState(() {
        isSelecketed[index]=!isSelecketed[index];
      });
    },
  ),
);
}
}

