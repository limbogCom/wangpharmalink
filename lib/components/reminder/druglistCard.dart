import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/components/reminder/druglistDetail.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/models/Druglist.dart';
import 'package:flutter_demo/size.config.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DruglistCard extends StatelessWidget {

  var druglist;

  DruglistCard({Key key, this.druglist}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      double defaultSize = SizeConfig.defaultSize;
      // TODO: implement build
      return AspectRatio(
        aspectRatio: 0.8,
        child: ListView.builder(
          itemBuilder: (context, int index) {
            return Container(
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: ListTile(
                contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                onTap: () {

                },
                //leading: Image.asset('assets/images/pill.png', fit: BoxFit.cover, width: 60, height: 60,),
                //leading: Text('${druglist[index].drugTime1}',
                //  style: TextStyle(color: kPrimaryColor)),
                leading: Container(
                  padding: EdgeInsets.only(right: 12.0),
                  decoration: new BoxDecoration(
                      border: new Border(
                          right: new BorderSide(
                              width: 1.0, color: Colors.orange))),
                  child: Text('${druglist[index].drugTime1}',
                      style: TextStyle(color: kPrimaryColor)),
                ),
                title: Text('วันที่ ${druglist[index].drugStart}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis),
                subtitle: Text(
                    '${druglist[index].drugName} ครั้งละ ${druglist[index]
                        .drugDose} ${druglist[index].drugUnitdose}'),
                trailing: IconButton(
                    icon: Icon(
                      Icons.alarm, color: Colors.orangeAccent, size: 30,),
                    onPressed: () {

                    }
                ),
              ),
            );
          },
          itemCount: druglist != null ? druglist.length : 0,
        ),
      );
    }
  }

