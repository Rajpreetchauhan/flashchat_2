import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Databasefunctions{


  uploaduserdata(userdatainmapform){
  FirebaseFirestore.instance.collection("userdata").doc().set(userdatainmapform);
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getdataoduderwithname(name) async {
    return await FirebaseFirestore.instance.collection("userdata").get();
  }

}