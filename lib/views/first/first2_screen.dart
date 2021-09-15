import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/views/first/first3_screen.dart';
import 'package:nookat/widgets/first_widgets.dart';

class First2Screen extends StatelessWidget {
  const First2Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstScreenWidget(
        text:
        "Бул баракчада Ноокат районундагы жанылыктар камтылат.".tr,
        photo: "assets/image/photo_2021-09-15_22-53-43-removebg-preview.png",
        function: (){
          Get.off(First3Screen());
        },
      ),
    );
  }
}
