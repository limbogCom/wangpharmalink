import 'package:flutter/material.dart';
import 'package:flutter_demo/components/Medicine/mydrug/Mydrug_screen.dart';
import 'package:flutter_demo/components/Medicine/page.dart';
import 'package:flutter_demo/constants.dart';

class Body extends StatefulWidget {
  @override
  _MyDrugPageState createState() => _MyDrugPageState();
}

class _MyDrugPageState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kPrimary,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'รายการยาของฉัน',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
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
                child:
                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MedicineReminder()),
                    );
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  color: Colors.white,
                  splashColor: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline,
                        color: kPrimaryColor,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'ยาที่ใช้ปัจจุบัน',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
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
                child:
                FlatButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MydrugScreen()),
                    );
                  },
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  color: Colors.white,
                  splashColor: Colors.black,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_outline,
                        color: kPrimaryColor,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'ประวัติยา',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}