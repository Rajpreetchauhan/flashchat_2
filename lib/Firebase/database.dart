import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class Databasefunctions{
  final userDataFromUserDataCollection =FirebaseFirestore.instance.collection("userdata");
  final userDataFromChatRoomCollection =FirebaseFirestore.instance.collection("chatroom");

  Future<void> uploaduserdata(userdata,uid) async {
 await userDataFromUserDataCollection.doc(uid).set(userdata);

  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserDataWithName(name) async {
     var results =await userDataFromUserDataCollection.where("firstname",isEqualTo: name).get();

    return results;
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserDataWithEmail(Email) async {
     var results =await userDataFromUserDataCollection.where("email",isEqualTo: Email).get();

    return results;
  }

Future<void> createchatroom(chatroomid,chatroommap) async {
  await userDataFromChatRoomCollection.doc(chatroomid).set(chatroommap).catchError((e){print(e.toString());});
}


 addconersationmessage(String chatRoomId,messageMap){
   userDataFromChatRoomCollection.doc(chatRoomId).collection("chats").doc().set(messageMap);
 }

  Stream<QuerySnapshot<Map<String, dynamic>>> getconersationmessage(String chatRoomId)  {
  var results = userDataFromChatRoomCollection.doc(
      chatRoomId).collection("chats").orderBy("time",descending: false).snapshots();
  return results;
 }

  Stream<QuerySnapshot<Map<String, dynamic>>> getRecentChats(String user)  {
  var result = userDataFromChatRoomCollection.where('chatroomusers' ,arrayContains: user ).snapshots();

return result;
}


}