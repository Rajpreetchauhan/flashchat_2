import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_2/Controller/Getxcontroller.dart';
import 'package:flashchat_2/Screens/search_screen.dart';
import 'package:flashchat_2/Screens/signin_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Firebase/database.dart';
import '../Models/models.dart';
import '../sharedpreferance/sharedpreferance.dart';
import 'chat_screen.dart';

class RecentchatScreen extends StatefulWidget {
  const RecentchatScreen({super.key});

  @override
  State<RecentchatScreen> createState() => _RecentchatScreenState();
}

class _RecentchatScreenState extends State<RecentchatScreen> {
  Databasefunctions databasefunctions = Databasefunctions();
  final Appcontroller _appcontroller = Get.put(Appcontroller());
  final FirebaseAuth _auth = FirebaseAuth.instance;

  getusername2() async {
    _appcontroller.username2.value =
        await SharedPreferenceData.getUserNameFirstName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    _auth.signOut();
                    SharedPreferenceData.setIsLogin(false);
                    Get.to(Signin());
                    _appcontroller.usernam1listforrecentchat.clear();
                  },
                )
              ],
            ),
          ),
          Expanded(child: Getrecentchats()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => Searchcontainer());
          },
          child: const Icon(Icons.search)),
    );
  }
}





class Getrecentchats extends StatefulWidget {
  Getrecentchats({super.key});

  @override
  State<Getrecentchats> createState() => _GetrecentchatsState();
}

class _GetrecentchatsState extends State<Getrecentchats> {
  Databasefunctions databasefunctions = Databasefunctions();

  final Appcontroller _appcontroller = Get.put(Appcontroller());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  getusername2() async {
    _appcontroller.username2.value =
        await SharedPreferenceData.getUserNameFirstName();
  }

  @override
  void initState() {
    getusername2();
    super.initState();
  }
  getChatRoomId(String a,String b){
    if(a.substring(0,1).codeUnitAt(0)>b.substring(0,1).codeUnitAt(0)){
      return "$b\_$a";
    }else{
      return "$a\_$b";
    }
  }


  createcommucntionroom(index,clickrecentchatuser) async {

    _appcontroller.username1.value= clickrecentchatuser.trim().toLowerCase();
    _appcontroller.username2.value= await SharedPreferenceData.getUserNameFirstName();

      List bothUser=getListOfUsernameInOrder(_appcontroller.username1.value,_appcontroller.username2.value);
      _appcontroller.chatroomid.value =getChatRoomId(_appcontroller.username1.value,_appcontroller.username2.value);

      Map<String,dynamic> chatroommap={"chatroomid":_appcontroller.chatroomid.value,"chatroomusers":bothUser};
      await databasefunctions.createchatroom(_appcontroller.chatroomid.value,chatroommap);
      Get.to(()=>ChatScreen());
      
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
    return StreamBuilder(
        stream:
            databasefunctions.getRecentChats(_appcontroller.username2.value),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error : ${snapshot.error}");
          } else {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {

                  String getSencodeUserName(){
                    if(_appcontroller.username2.value == snapshot.data!.docs[index]
                        .get('chatroomusers')[0]
                        .toString()){
                      _appcontroller.usernam1listforrecentchat.value.add(snapshot.data!.docs[index]
                          .get('chatroomusers')[1]
                          .toString());

                      return snapshot.data!.docs[index]
                          .get('chatroomusers')[1]
                          .toString();
                    }else
                    {
                      _appcontroller.usernam1listforrecentchat.value.add(snapshot.data!.docs[index]
                          .get('chatroomusers')[0]
                          .toString());
                      return snapshot.data!.docs[index]
                          .get('chatroomusers')[0]
                          .toString();
                    }
                  }
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: (){createcommucntionroom(index,_appcontroller.usernam1listforrecentchat.value[index]);},
                        child: Container(
                          height: 70,
                            color: Colors.grey,
                            child: Row(
                              children: [
                                const SizedBox(width: 30,),
                                Text( getSencodeUserName()),
                              ],
                            )),
                      ),
                      const SizedBox(height: 10,)
                    ],
                  );
                });
          }
        });
  }
}
