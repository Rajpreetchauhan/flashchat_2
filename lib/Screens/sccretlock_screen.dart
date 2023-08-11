import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'home_screen.dart';

class Scretlockscreen extends StatelessWidget {
   Scretlockscreen({super.key});

List secretlocklist =[];

compareList(){
  bool isvalid=false;
  if(secretlocklist[0] == 'a' && secretlocklist[1] == 'b' && secretlocklist[2] == 'c' && secretlocklist[3] == 'd'){
    return true;
  }

  return isvalid;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
         height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: GestureDetector(onTap: (){secretlocklist.add("a");},child: Container(color: Colors.grey))),
                Expanded(child: GestureDetector(onTap: (){secretlocklist.add("b");},child: Container(color: Colors.grey))),]),
          ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){secretlocklist.add("c");},
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){secretlocklist.add("d");
                        if(compareList() == true){
                          Get.to(()=>const Checkisloginpage());
                        } else{
                          print(secretlocklist);
                          secretlocklist.clear();
                          Get.snackbar(".", "");

                        }
                          },
                        child: Container(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              )

        ]),
      ),
    );
  }
}
