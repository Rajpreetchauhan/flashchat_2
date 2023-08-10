import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceData {
  static String sharedPreferenceLoginKey = "loginkey";
  static String sharedPreferenceUserFirstName = "firstusernamekey";
  static String sharedPreferenceUserLastname = "lastusernamekey";
  static String sharedPreferenceUserEmail = "useremailkey";

  static setUserFirstName(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharedPreferenceUserFirstName, username);
  }
  static setUserLastName(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharedPreferenceUserLastname, username);
  }

  static setIsLogin(bool isLogin) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(sharedPreferenceLoginKey, isLogin);
  }

  static setUserEmail(String userEmail) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(sharedPreferenceUserEmail, userEmail);
  }





  static getUserNameFirstName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserFirstName);
  }
  static getUserNameLastName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserLastname);
  }

  static getIsLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(sharedPreferenceLoginKey);
  }

  static getUserEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(sharedPreferenceUserEmail);
  }
}
