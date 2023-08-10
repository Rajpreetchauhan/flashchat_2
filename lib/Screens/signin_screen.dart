import 'package:firebase_auth/firebase_auth.dart';
import 'package:flashchat_2/Screens/chat_screen.dart';
import 'package:flashchat_2/Screens/recentchats_screen.dart';
import 'package:flashchat_2/Screens/search_screen.dart';
import 'package:flashchat_2/Screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controller/Getxcontroller.dart';
import '../Firebase/database.dart';
import '../Models/models.dart';
import '../Widgets/login_signup_button.dart';
import '../Widgets/textfield_widget.dart';
import '../sharedpreferance/sharedpreferance.dart';

class Signin extends StatelessWidget {
  Signin({Key? key}) : super(key: key);
  Appcontroller _appcontroller=Get.put(Appcontroller());
  FirebaseAuth _auth=FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Databasefunctions databasefunctions =Databasefunctions();


  updateDataoOnSharedpreferance() async {
    var results = await databasefunctions
        .getUserDataWithEmail(_appcontroller.emailtexteditingcontroller.text.trim().toLowerCase());

    _appcontroller.userDataListForSharedpreferance.clear();

    for (var element in results.docs) {
      _appcontroller.userDataListForSharedpreferance.value
          .add(Userdata.fromMap(element.data()));}

    SharedPreferenceData.setIsLogin(true);
    _appcontroller.currentuserfirstnamebylogin.value=_appcontroller.userDataListForSharedpreferance.value[0].firstname;
    _appcontroller.currentuserlastnamebylogin.value=_appcontroller.userDataListForSharedpreferance.value[0].lastname;
    await SharedPreferenceData.setUserFirstName(_appcontroller.currentuserfirstnamebylogin.value);
    await SharedPreferenceData.setUserLastName(_appcontroller.currentuserlastnamebylogin.value);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
      backgroundColor: const Color(0xff33907C),
      body: _appcontroller.isloading.value? Center(child: CircularProgressIndicator()): SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 150),
              child: Text(
                "Welcome to tadly",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 60, bottom: 20),
              child: Text(
                "Login to your account",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.always,
                child:  Column(
                  children: [
                    Userdatatextfield(
                      validator: MultiValidator([RequiredValidator(errorText: "Required"),EmailValidator(errorText: "Write Correct Email")]),
                      hinttext: "Email/Mobile Number",controller: _appcontroller.emailtexteditingcontroller,
                    ),
                    Userdatatextfield(
                      validator: RequiredValidator(errorText: "Required"),
                      hinttext: "Password",controller: _appcontroller.passwordtexteditingcontroller,
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 37, vertical: 10),
              child: Loginsignupbutton(
                textofbutton: "Login",
                onpressed: () async{
                  if(_formKey.currentState!.validate()){
                    SharedPreferenceData.setIsLogin(true);
                    updateDataoOnSharedpreferance();
                    _appcontroller.isloading.value=true;
                    try{UserCredential usercrdintial=await _auth.signInWithEmailAndPassword(email: _appcontroller.emailtexteditingcontroller.text.trim(), password: _appcontroller.passwordtexteditingcontroller.text.trim());
                    if(usercrdintial !=null){
                      _appcontroller.isloading.value=false;
                      Get.to(()=>const RecentchatScreen());
                    }
                    
                    }catch(e){
                        _appcontroller.isloading.value=false;
                        Get.snackbar(
                          "User not found",
                          "Create a account",
                          icon: const Icon(Icons.person, color: Colors.white),
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                        );

                      print(e);

                    }}
                  }


              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                "Forgot your password?",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have account?",
                    style: TextStyle(color: Colors.white),
                  ),
                  TextButton(
                      onPressed: () {
                        Get.to(Signup());
                      },
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: Colors.white),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
