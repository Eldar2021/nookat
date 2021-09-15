import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/views/first/first2_screen.dart';
import 'package:nookat/widgets/first_widgets.dart';

class First1Screen extends StatelessWidget {
  const First1Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FirstScreenWidget(
        text:
            "Бул негизги баракча болуп анда алгач шашылыш сатуулар кабарлар андан кийин башка жарнамалар тизмектелет.".tr,
        photo: "assets/image/photo_2021-09-15_22-53-47-removebg-preview.png",
        function: (){
          Get.off(First2Screen());
        },
      ),
    );
  }
}

