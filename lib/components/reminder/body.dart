import 'package:flutter/material.dart';
import 'package:flutter_demo/components/reminder/background.dart';
import 'package:flutter_demo/components/reminder/categories.dart';
import 'package:flutter_demo/components/reminder/druglistCard.dart';
import 'package:flutter_demo/constants.dart';
import 'package:flutter_demo/models/Druglist.dart';

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
              alignment: Alignment.topRight,
              child: new FloatingActionButton(child: new Icon(Icons.calendar_today), heroTag: 2,
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
                backgroundColor: Colors.orange,
              ),
            ),
            Text(_dateTime == null ? '' : _dateTime.toString()),
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
