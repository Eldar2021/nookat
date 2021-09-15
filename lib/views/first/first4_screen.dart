import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/views/first/first5_screen.dart';
import 'package:nookat/widgets/first_widgets.dart';

class First4Screen extends StatelessWidget {
  const First4Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstScreenWidget(
        text:
        "Бул баракчада тиркменин максаты жана кандай колдонуу керектигин окуй аласыз.".tr,
        photo: "assets/image/photo_2021-09-15_22-53-53-removebg-preview.png",
        function: (){
          Get.off(First5Screen());
        },
      ),
    );
  }
}
