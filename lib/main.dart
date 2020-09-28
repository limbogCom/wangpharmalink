import 'package:flutter/material.dart';
import 'package:flutter_demo/models/NavItem.dart';
import 'package:flutter_demo/screens/Home_screen.dart';
import 'package:flutter_demo/screens/welcome_screen.dart';
import 'package:flutter_demo/constants.dart';
import 'package:provider/provider.dart';

void main() => runApp(
    MyApp()
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NavItems(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        routes: <String,WidgetBuilder>{
          '/Home': (BuildContext context) => Home(),
        },
        theme: ThemeData(
          appBarTheme: AppBarTheme(color: Colors.orangeAccent),
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        )
        ,
        home: WelcomeScreen(),
      ),
    );
  }
}