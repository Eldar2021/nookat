import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/text_style.dart';

class FirstScreenWidget extends StatelessWidget {
  const FirstScreenWidget({
    Key? key,
    required this.function,
    required this.text,
    required this.photo,
  }) : super(key: key);

  final String text;
  final String photo;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Text(
                  text,
                  style: MyTextStyle.settingItemTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  photo,
                  width: Get.width / 2,
                  alignment: Alignment.bottomRight,
                ),
              ),
            ),
          ],
        ),
        InkWell(
          onTap:(){
            function();
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: MyColors.myRed,
            ),
            child: Text(
              "Андан ары".tr,
              style: TextStyle(
                color: MyColors.whiteColor,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}