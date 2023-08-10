import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_2/Controller/Getxcontroller.dart';
import 'package:flashchat_2/Firebase/database.dart';
import 'package:flashchat_2/Screens/chat_screen.dart';
import 'package:flashchat_2/Screens/recentchats_screen.dart';
import 'package:flashchat_2/Screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Models/models.dart';
import '../sharedpreferance/sharedpreferance.dart';

class Searchcontainer extends StatefulWidget {
  @override
  State<Searchcontainer> createState() => _SearchcontainerState();
}

class _SearchcontainerState extends State<Searchcontainer> {
  final Appcontroller _appcontroller = Get.put(Appcontroller());
  final Databasefunctions databsefunction = Databasefunctions();
  FirebaseAuth _auth = FirebaseAuth.instance;

  //gelisttiles is function to get data from firebase by giving username that current user is searching and store it in list(userDataListForSearch) of type Userdata(Model)
  getlistiles() async {
    var results = await databsefunction.getUserDataWithName(
        _appcontroller.searchbarcontroller.text.trim().toLowerCase());

    _appcontroller.userDataListForSearch.clear();

    for (var element in results.docs) {
      _appcontroller.userDataListForSearch.value
          .add(Userdata.fromMap(element.data()));
    }

    if (_appcontroller.userDataListForSearch.value.isEmpty) {
      return Get.snackbar("User doesn't exist", "",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          backgroundColor: Colors.green);
    }
  }

  createcommucntionroom(index) async {
    _appcontroller.username1.value = await _appcontroller
        .userDataListForSearch.value[index].firstname
        .trim()
        .toLowerCase();
    _appcontroller.username2.value =
        await SharedPreferenceData.getUserNameFirstName();

    if (_appcontroller.username1.value != _appcontroller.username2.value) {
      List bothUser = getListOfUsernameInOrder(
        _appcontroller.username1.value,
        _appcontroller.username2.value
      );
      _appcontroller.chatroomid.value = getChatRoomId(
          _appcontroller.username1.value, _appcontroller.username2.value);

      Map<String, dynamic> chatroommap = {
        "chatroomid": _appcontroller.chatroomid.value,
        "chatroomusers": bothUser
      };
      print("_______$chatroommap");
      await databsefunction.createchatroom(
          _appcontroller.chatroomid.value, chatroommap);
      Get.to(() => ChatScreen());
    } else {
      Get.snackbar("Can't send message to yourself", "",
          snackPosition: SnackPosition.BOTTOM,
          icon: const Icon(
            Icons.person,
            color: Colors.white,
          ),
          backgroundColor: Colors.green);
    }
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  List getListOfUsernameInOrder(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return [b,a];
    } else {
      return [a,b];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Column(
        children: [
          const SizedBox(height: 3),
          TextFormField(
            controller: _appcontroller.searchbarcontroller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () async {
                    if (_appcontroller.searchbarcontroller.text.isEmpty) {
                      Get.snackbar(
                          "you have not enterd anything", "try searching",
                          snackPosition: SnackPosition.BOTTOM,
                          icon: const Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.green);
                    } else {
                      await getlistiles();
                    }
                  },
                  child: const Text("Search")),
              TextButton(
                  onPressed: () async {
                    _appcontroller.userDataListForSearch.clear();
                    _appcontroller.searchbarcontroller.text = "";
                  },
                  child: const Text("clear")),
            ],
          ),
          const SizedBox(
            height: 7,
          ),
          Obx(
            () {
              return ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: _appcontroller.userDataListForSearch.value.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.blue,
                    title: Text(
                        _appcontroller.userDataListForSearch.value[index]
                            .firstname.capitalizeFirst!,
                        style: const TextStyle(color: Colors.white)),
                    subtitle: Text(
                        _appcontroller.userDataListForSearch.value[index].email
                            .capitalizeFirst!,
                        style: const TextStyle(color: Colors.white)),
                    trailing: TextButton(
                      onPressed: () {
                        createcommucntionroom(index);
                      },
                      child: const Text(
                        "Message",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
