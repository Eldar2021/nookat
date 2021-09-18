import 'package:flutter/material.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/models/category_model.dart';
import 'package:get/get.dart';

class MyCategoryListStreamBuilder extends StatelessWidget {
  MyCategoryListStreamBuilder({required this.function});

  final Function function;


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemCount: categories.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> cat = categories[index];
        return GestureDetector(
          onTap: () {
            function(cat);
          },
          child: Container(
            margin: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.arrow_forward_rounded,
                  color: MyColors.whiteColor,
                ),
                const SizedBox(width: 20),
                Text(
                  "${cat["label"]}".tr,
                  style: MyTextStyle.homeCategory,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
