import 'package:flutter/material.dart';
import 'package:flutter_demo/components/reminder/background.dart';
import 'package:flutter_demo/components/reminder/categories.dart';
import 'package:flutter_demo/components/reminder/druglistCard.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/models/Druglist.dart';
import 'package:flutter_demo/size.config.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  State createState() => BodyState();
}

class BodyState extends State<Body>{
  var patient_code;

  List <druglist>druglistAll = [];


  _connectDrug() async {
    print(patient_code);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    patient_code = prefs.getString('patient_code');

    final response = await http.post(
        'https://wangpharma.com/pharmalink/API/drugs.php',
        body: {'patient_code': patient_code, 'drugs_list': '1'});

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      //print(jsonResponse);

      if (jsonResponse != null) {
        jsonResponse.forEach((druglists) => druglistAll.add(druglist.fromJson(druglists)));

        print(druglistAll);

        setState(() {
          return druglistAll;
        });

      } else {
        print('Connect ERROR');
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectDrug();
  }
  @override
  DateTime _dateTime;
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Background(child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Categories(),
            Container(
              decoration: BoxDecoration(
                boxShadow:[BoxShadow(
                  color: Colors.orangeAccent.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 9,
                  offset: Offset(0, 1),
                ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FlatButton(
                  onPressed: () {
                    showDatePicker(
                        context: context, initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                        firstDate: DateTime(2001),
                        lastDate: DateTime(2025)
                    ).then((date) {
                      setState(() {
                        _dateTime = date;
                      });
                    });
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  color: Colors.orange,
                  splashColor: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today,
                        color: Colors.white,
                        size: 25,
                      ),
                      Text(" Select Date"),
                      SizedBox(width: 10),
                      Text(_dateTime == null ? '' : _dateTime.toString()),
                    ],
                  ),
                ),
              ),
            ),
            //Container(
              //alignment: Alignment.topRight,
              //child: new FloatingActionButton(child: new Icon(Icons.calendar_today), heroTag: 2,
                //onPressed: () {
                  //showDatePicker(
                    //  context: context, initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                      //firstDate: DateTime(2001),
                      //lastDate: DateTime(2025)
                  //).then((date) {
                    //setState(() {
                      //_dateTime = date;
                    //});
                  //});
                //},
                //backgroundColor: Colors.orange,
              //),
            //),
            //Text(_dateTime == null ? '' : _dateTime.toString()),
            DruglistCard(druglist:druglistAll),

            //Text("รายละเอียดยา",
            //style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            //),
            //Image.asset("assets/images/Artboard 1.png",
            //height: size.height * 0.1,
            //),

          ],
        ),
      ),
      ),
    );
  }
}

class DruglistCard extends StatelessWidget {

  var druglist;

  List statusOrderDrug = ['','ก่อนอาหาร 30 นาที','หลังอาหารทันที','หลังอาหาร 15 นาที','ขณะท้องว่าง'];

  DruglistCard({Key key, this.druglist }) : super(key: key);


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
                showDialog(context: context,
                    builder: (_) => new AlertDialog(
                      title: new Text('แจ้งเตือนรับประทานยาวันที่ :${druglist[index].drugStart}',style: TextStyle(color: kPrimaryColor)),
                      content: new Text('${druglist[index].drugName} ครั้งละ ${druglist[index]
                          .drugDose} ${druglist[index].drugUnitdose} ${druglist[index].drugIndication} '
                          '${druglist[index].drugDescription} ${statusOrderDrug[int.parse(druglist[index].drugOrder)]}'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("OK",style: TextStyle(color: kPrimaryColor),),
                          onPressed: (){ Navigator.of(context).pop();
                          },
                        ),
                      ],
                    )
                );
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
                child: Text('${druglist[index].drugAlert}',
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



