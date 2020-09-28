import 'package:shared_preferences/shared_preferences.dart';

Future setshowTime(DateTime showTime) async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setString("showTime", showTime.toString());
}

Future onlyOneTimePeriodic() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("oneTimePeriodic", true);
}

Future onlyOneTimePeriodicEnd() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.setBool("oneTimePeriodic", false);
}

