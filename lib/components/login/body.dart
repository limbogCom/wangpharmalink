import 'package:flutter/material.dart';
import 'package:flutter_demo/button/rounded_button.dart';
import 'package:flutter_demo/button/rounded_input_field.dart';
import 'package:flutter_demo/button/rounded_password_field.dart';
import 'package:flutter_demo/components/login/background.dart';
import 'package:flutter_demo/constants.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Body extends StatefulWidget {
  @override
  State createState() => new BodyState();

}

class BodyState extends State<Body>{


  var userName;
  var passWord;

  _doLogin() async{

    print(userName);

    SharedPreferences prefs = await SharedPreferences.getInstance();

    final response = await http.post(
        'https://wangpharma.com/pharmalink/API/login.php',
        body: {'Username': userName, 'Password': passWord, 'btn_login': '1'});

    if(response.statusCode == 200){
      var jsonResponse = json.decode(response.body);
      print(jsonResponse['msg']);

      if(jsonResponse['msg'][0] != '0'){

        prefs.setString("patient_code", jsonResponse['msg']['patient_code']);

        Navigator.pushReplacementNamed(context, '/Home');

      }else{
        _showAlert();
      }

    }else{
      print('Connect ERROR');
    }
  }

  void _showAlert() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)), //this right here
          title: Container(
            height: 220.0,
            width: 300.0,

            child: Column(
              children: <Widget>[
                Padding(
                  padding:  EdgeInsets.all(15.0),
                  child: Icon(Icons.error,color: kPrimaryColor,size: 30),
                ),
                Padding(
                  padding:  EdgeInsets.all(10.0),
                  child: Text('แจ้งเตือน', style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง', style: TextStyle(color: Colors.black,fontSize: 18),),
                ),
                Padding(padding: EdgeInsets.only(top: 10.0)),
                FlatButton(onPressed: (){
                  Navigator.of(context).pop();
                },
                    child: Text('OK', style: TextStyle(color: kPrimaryColor, fontSize: 16.0),))
              ],
            ),
          ),
          //title: Text('แจ้งเตือน'),
          //content: Text('ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    // TODO: implement build
    return Background(
      child: SingleChildScrollView(// Fix error bottom overflow
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03,
            ),
            Image.asset("assets/images/wang1.png",
              height: size.height * 0.38,),
            SizedBox(height: size.height * 0.03,
            ),
            RoundedInputField(
              hintText: "Username",
              onChanged: (value){
                userName = value;
              },
            ),
            RoundedPasswordField(
              onChange: (value) {
                passWord = value;
              },
            ),
            SizedBox(height: size.height * 0.015,
            ),
            RoundedButton(
              text: "LOGIN",
              press: () {
                _doLogin();
              },
            ),
          ],
        ),
      ),
    );
  }
}
