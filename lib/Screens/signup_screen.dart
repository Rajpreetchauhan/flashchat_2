import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_2/Controller/Getxcontroller.dart';
import 'package:flashchat_2/Screens/search_screen.dart';
import 'package:flashchat_2/Screens/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../Firebase/database.dart';
import '../Widgets/login_signup_button.dart';
import '../Widgets/textfield_widget.dart';
import 'chat_screen.dart';

class Signup extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
final Appcontroller _appcontroller=Get.put(Appcontroller());
final FirebaseAuth _auth = FirebaseAuth.instance;
  Databasefunctions databasefunctions=Databasefunctions();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: const Color(0xff33907C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
      ),
      body: _appcontroller.isloading.value ? const Center(child: CircularProgressIndicator()) :Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text(
                  "Welcome to FlashChat 2",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Text(
                  "Signup to your account",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child: Column(children: [
                  Userdatatextfield(
                    controller: _appcontroller.rfirstnametexteditingcontroller,
                    validator: MultiValidator([
                      RequiredValidator(errorText: "Required"),
                    ]),
                    hinttext: "FirstName",
                  ),
                  Userdatatextfield(
                    controller: _appcontroller.rlastnametexteditingcontroller,
                    validator: RequiredValidator(errorText: "Required"),
                    hinttext: "Last Name",
                  ),
                  Userdatatextfield(
                    controller: _appcontroller.remailtexteditingcontroller,
                    validator: MultiValidator([RequiredValidator(errorText: "Required"),EmailValidator(errorText: "Enter Correct Email")]),
                    hinttext: "Email ID/Phone Number",
                  ),
                  Userdatatextfield(
                    controller: _appcontroller.rpasswordtexteditingcontroller,
                    validator: RequiredValidator(errorText: "Required"),
                    hinttext: "Password",
                  ),
                  Userdatatextfield(
                    controller: _appcontroller.rpassword2texteditingcontroller,
                    validator: RequiredValidator(errorText: "Required"),
                    hinttext: "Re-enter Password",
                  )
                ]),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Loginsignupbutton(
                  onpressed: () async {
                    try{if (_formKey.currentState!.validate()) {
                      Map<String,String> userdatainmapform={"firstname": _appcontroller.rfirstnametexteditingcontroller.text,"lastname": _appcontroller.rlastnametexteditingcontroller.text,"email": _appcontroller.remailtexteditingcontroller.text,};
                      _appcontroller.isloading.value=true;
                      databasefunctions.uploaduserdata(userdatainmapform);
                      UserCredential usercredential=await _auth.createUserWithEmailAndPassword(email: _appcontroller.remailtexteditingcontroller.text, password: _appcontroller.rpasswordtexteditingcontroller.text);
                      if(usercredential !=null){
                        _appcontroller.isloading.value=false;
                        Get.to(()=>Searchcontainer());
                      }
                    }} catch(e){
                      _appcontroller.isloading.value=false;
                      Get.snackbar("Error while creating account",
                          "Try Signup again" ,icon: Icon(Icons.person,color: Colors.white,),
                          backgroundColor: Colors.green,snackPosition: SnackPosition.BOTTOM);
                    }
                  },
                  textofbutton: "Create",
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Have an account?",
                      style: TextStyle(color: Colors.white),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(() => Signin());
                        },
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                              fontWeight: FontWeight.w700, color: Colors.white),
                        ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
