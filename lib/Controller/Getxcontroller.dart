import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../Models/models.dart';

class Appcontroller extends GetxController {




  TextEditingController emailtexteditingcontroller=TextEditingController();
  TextEditingController passwordtexteditingcontroller=TextEditingController();

  TextEditingController remailtexteditingcontroller=TextEditingController();
  TextEditingController rpasswordtexteditingcontroller=TextEditingController();
  TextEditingController rpassword2texteditingcontroller=TextEditingController();
  TextEditingController rfirstnametexteditingcontroller=TextEditingController();
  TextEditingController rlastnametexteditingcontroller=TextEditingController();

  TextEditingController sendmessagecotroller =TextEditingController();

var  isloading=false.obs;
  var  currentuserfirstnamebylogin="".obs;
  var  currentuserlastnamebylogin="".obs;

TextEditingController searchbarcontroller= TextEditingController();

 var userDataListForSearch=<Userdata>[].obs;

 var userDataListForSharedpreferance=<Userdata>[].obs;

  var chatroomid="".obs;

  var username1="".obs;
  var username2="".obs;

  var isMessageSendByMe=false.obs;


  var usernam1listforrecentchat =[].obs;
}
