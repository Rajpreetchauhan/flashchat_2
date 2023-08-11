import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_2/Controller/Getxcontroller.dart';
import 'package:flashchat_2/Firebase/database.dart';
import 'package:flashchat_2/Screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../sharedpreferance/sharedpreferance.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  Databasefunctions databasefunctions = Databasefunctions();
  final Appcontroller _appcontroller = Get.put(Appcontroller());
  ScrollController _scrollController =ScrollController();

scrolltobottom(){
  _scrollController.animateTo(_scrollController.position.maxScrollExtent,duration: Duration(milliseconds: 500), curve: Curves.ease);
}

  sendMessage() async {
    if (_appcontroller.sendmessagecotroller.value != null) {
      Map<String, dynamic> messageMap = {
        "message": _appcontroller.sendmessagecotroller.text,
        "sentby": _appcontroller.username2.value,
        "time": DateTime.now().millisecondsSinceEpoch
      };
      await databasefunctions.addconersationmessage(
          _appcontroller.chatroomid.value, messageMap);
      _appcontroller.sendmessagecotroller.text = "";
    }
  }

  Widget chatListStreambuilder() {

    return StreamBuilder(
        stream: databasefunctions
            .getconersationmessage(_appcontroller.chatroomid.value),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              controller: _scrollController,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {

                  if (snapshot.data!.docs[index]['sentby'] !=
                      _appcontroller.username1.value) {
                    return messageTileWidget(
                        message: snapshot.data!.docs[index]['message'],
                        IsMe: true);
                  } else {
                    return messageTileWidget(
                        message: snapshot.data!.docs[index]['message'],
                        IsMe: false);
                  }
                });
          } else if (snapshot.hasError) {
            return const Icon(Icons.error_outline);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: BackButton()),
      body: Column(children: [
        Expanded(child: chatListStreambuilder()),
        Container(
          height: 70,
          color: Colors.brown,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: _appcontroller.sendmessagecotroller,
                )),
                TextButton(
                    onPressed: () {
                      sendMessage();
                      scrolltobottom();
                    },
                    child: const Icon(Icons.send))
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

Widget messageTileWidget({required String message, required bool IsMe}) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: IsMe ? MainAxisAlignment.end : MainAxisAlignment.start,
    children: [
      Container(
        constraints: BoxConstraints.loose(const Size.fromWidth(160)),
        decoration: IsMe
            ? BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23)),
                color: IsMe ? Colors.blue : Colors.white)
            : BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23)),
                color: IsMe ? Colors.blue : Colors.white),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Text(
          softWrap: true,
          maxLines: 10,
          message,
          style: TextStyle(
            color: IsMe ? Colors.white : Colors.blue,
          ),
        ),
      ),
    ],
  );
}
