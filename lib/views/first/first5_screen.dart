import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/controler/first_controller.dart';
import 'package:nookat/mainscreen.dart';
import 'package:nookat/widgets/first_widgets.dart';

class First5Screen extends StatelessWidget {
  final FirstController firstController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstScreenWidget(
        text:
        "Бул баракча аркылуу тиркеменин тилин, арткы фон түсүн, жана билдирүүсүн өзгөртө аласыз.".tr,
        photo: "assets/image/photo_2021-09-15_22-53-50-removebg-preview.png",
        function: (){
          firstController.second();
          Get.off(MainScreen());
        },
      ),
    );
  }
}

