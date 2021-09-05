import 'package:flutter/material.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/widgets/home_screen_widgets.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MyStreamBuilder(),
        Container(
          margin: const EdgeInsets.only(top: 25, bottom: 15),
          child: Text(
            "Кабарлар".tr,
            style: MyTextStyle.homeTheme,
          ),
        ),
        MyNewsStreamBuilder(),
        Container(
          margin: const EdgeInsets.only(top: 25, bottom: 15),
          child: Text("Башка жарнамалар".tr,
            style: MyTextStyle.homeTheme,),
        ),
        MyOtherStreamBuilder(),
      ],
    );
  }
}
