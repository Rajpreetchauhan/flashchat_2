import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Column(children: [
      ]),
      bottomNavigationBar: Container(
          child: Row(
        children: [
          Expanded(child: TextFormField()),
          TextButton(onPressed: () {}, child: Icon(Icons.send))
        ],
      )),
    );
  }
}
