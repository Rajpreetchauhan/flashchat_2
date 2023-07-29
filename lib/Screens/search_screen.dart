import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flashchat_2/Controller/Getxcontroller.dart';
import 'package:flashchat_2/Firebase/database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Models/models.dart';

class Searchcontainer extends StatelessWidget {
  final Appcontroller appcontroller = Get.put(Appcontroller());
  final Databasefunctions databsefunction = Databasefunctions();

  getlistiles() async {


    var results = await databsefunction
        .getdataoduderwithname(appcontroller.searchbarcontroller.text.trim());
appcontroller.userdatafromquery.value.clear();
    results.docs.forEach((element) {  appcontroller.userdatafromquery.value.add(Userdata.fromMap(element.data()));});


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton()),
      body: Column(children: [
        const SizedBox(height: 3),
        TextFormField(controller: appcontroller.searchbarcontroller,),
        TextButton(onPressed: (){getlistiles();}, child: const Text("Search")),
        const SizedBox(
          height: 7,
        ),
        Obx(() {
          return ListView.builder(
            shrinkWrap: true,
            physics: const ScrollPhysics(),
            itemCount: appcontroller.userdatafromquery.value.length,
            itemBuilder: (context, index) {
              return ListTile(
                tileColor: Colors.blue,
                title: Text(
                    appcontroller.userdatafromquery.value[index].firstname,
                    style: const TextStyle(color: Colors.white)),
                subtitle: Text(
                    appcontroller.userdatafromquery.value[index].email,
                    style: const TextStyle(color: Colors.white)),
                trailing: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Message",
                      style: TextStyle(color: Colors.white),
                    )),
              );
            });
        })
      ]),
    );
  }
}
