import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/views/first/first4_screen.dart';
import 'package:nookat/widgets/first_widgets.dart';

class First3Screen extends StatelessWidget {
  const First3Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstScreenWidget(
        text:
        "Бул баракча аркылуу Ноокат районуна жарнама же кабар тарата аласыз.".tr,
        photo: "assets/image/photo_2021-09-15_22-53-59-removebg-preview.png",
        function: (){
          Get.off(First4Screen());
        },
      ),
    );
  }
}
