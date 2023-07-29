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

var  isloading=false.obs;

TextEditingController searchbarcontroller= TextEditingController();

 var userdatafromquery=<Userdata>[].obs;


}
