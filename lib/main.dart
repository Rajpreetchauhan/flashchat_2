import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashchat_2/sharedpreferance/sharedpreferance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/chat_screen.dart';
import 'Screens/recentchats_screen.dart';
import 'Screens/search_screen.dart';
import 'Screens/signin_screen.dart';
import 'Screens/signup_screen.dart';


void main() async {WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp();


runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: FutureBuilder<Widget>(
        future: getscreen(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Error loading data."),
              ),
            );
          } else {
            return snapshot.data ?? Signin(); // Show Signin screen by default if data is null
          }
        },
      ),
    );
  }
}





Future<Widget> getscreen() async {
  try {
    bool isLogin = await SharedPreferenceData.getIsLogin();
    return isLogin ? RecentchatScreen() : Signin();
  } catch (e) {
    print("____ $e ____");
    return Signin(); // Return Signin screen in case of any error
  }
}
