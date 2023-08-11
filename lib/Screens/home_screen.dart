

import 'package:flashchat_2/Screens/recentchats_screen.dart';
import 'package:flashchat_2/Screens/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../sharedpreferance/sharedpreferance.dart';

class Checkisloginpage extends StatelessWidget {
  const Checkisloginpage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
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