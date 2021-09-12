import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/controler/first_controller.dart';
import 'package:nookat/mainscreen.dart';

class First5Screen extends StatelessWidget {
  final FirstController firstController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 20),
          Container(
              child: Image.asset("assets/image/nookat_admin.jpeg")
          ),
          InkWell(
            onTap: (){
              firstController.second();
              Get.off(MainScreen());
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: MyColors.myRed,
              ),
              child: Text(
                "Далее",
                style: TextStyle(
                  color: MyColors.whiteColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
