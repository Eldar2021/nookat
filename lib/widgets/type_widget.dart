import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/controler/read_category_controller.dart';

class TypeAdvert extends StatelessWidget {
  final Function function;

  TypeAdvert({required this.function});

  final ReadController readController = Get.put(ReadController());

  final List<Map<String, String>> types = [
    {
      "title": "Кабар".tr,
      "value": "Кабар"
    },
    {
      "title": "Шашылыш сатуу".tr,
      "value": "Шашылыш сатуу"
    },
    {
      "title": "Сатуу".tr,
      "value": "Сатуу"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: Get.width / 2, //200,
        childAspectRatio: 4 / 1,
      ),
      itemCount: types.length,
      itemBuilder: (context, index) {
        Map<String, String> type = types[index];
        return GestureDetector(
          onTap: () {
            function(type["value"]);
            readController.show("${type["title"]}");
          },
          child: Container(
            padding: const EdgeInsets.all(7.0),
            margin: EdgeInsets.all(7.0),
            decoration: BoxDecoration(
              color: MyColors.priceBackColor,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${type["title"]}",
                  style: MyTextStyle.homeCategory,
                ),
                Obx(
                  () => Visibility(
                    visible: readController.visible.value == type["title"] ? true : false,
                    child: Icon(Icons.check_outlined, color: MyColors.whiteColor),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
