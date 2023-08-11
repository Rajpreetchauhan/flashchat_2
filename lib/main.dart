import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flashchat_2/sharedpreferance/sharedpreferance.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Screens/chat_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/recentchats_screen.dart';
import 'Screens/sccretlock_screen.dart';
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
    return   GetMaterialApp(
      home: Scretlockscreen()
    );
  }
}






