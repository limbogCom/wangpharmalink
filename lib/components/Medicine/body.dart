import 'package:flutter/material.dart';
import 'package:flutter_demo/components/Medicine/mydrug/Mydrug_screen.dart';

class Body extends StatefulWidget {
  @override
  _MyMedicinePageState createState() => _MyMedicinePageState();
}

class _MyMedicinePageState extends State<Body> {
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
              'ระบบเกี่ยวกับยาสำหรับคุณ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
              FlatButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => MydrugScreen()),
                    );

                },
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                color: Colors.orangeAccent,
                splashColor: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'รายการยาของฉัน',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
              FlatButton(
                onPressed: () {},
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                color: Colors.orangeAccent,
                splashColor: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.search,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Drug A-Z',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
              FlatButton(
                onPressed: () {},
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                color: Colors.orangeAccent,
                splashColor: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.do_not_disturb,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Drug Interactions',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
              FlatButton(
                onPressed: () {},
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                color: Colors.orangeAccent,
                splashColor: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.category,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Pill Identifier',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
              FlatButton(
                onPressed: () {},
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                color: Colors.orangeAccent,
                splashColor: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.featured_play_list,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'ยาที่ใช้ตามอาการ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
              FlatButton(
                onPressed: () {},
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                color: Colors.orangeAccent,
                splashColor: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_box,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'เปรียบเทียบยา',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 15),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:
              FlatButton(
                onPressed: () {},
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                color: Colors.orangeAccent,
                splashColor: Colors.black,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.create,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'ประวัติแพ้ยา',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

