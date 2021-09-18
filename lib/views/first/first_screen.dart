import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/controler/settings_controller.dart';
import 'package:get/get.dart';
import 'package:nookat/views/first/first1_screen.dart';
import 'package:nookat/widgets/setting_widget.dart';

class FirstScreen extends StatelessWidget {
  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 20),
          Container(
            child: Expanded(child: Image.asset("assets/image/logo.png"))
          ),
          const SizedBox(height: 20),
          MySettingsContainer(
            onTab: () {
              settingsController.kg();
            },
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    "assets/icons/kyrgyzstan_round_icon_256.png",
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "Кыргызча",
                  style: MyTextStyle.settingItemTextStyle,
                ),
                Obx(() {
                  return CircleAvatar(
                    backgroundColor: settingsController.colorKg.value,
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          MySettingsContainer(
            onTab: () {
              settingsController.uz();
            },
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SvgPicture.asset(
                    "assets/icons/uzbekistan.svg",
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "O‘zbekcha",
                  style: MyTextStyle.settingItemTextStyle,
                ),
                Obx(() {
                  return CircleAvatar(
                    backgroundColor: settingsController.colorUz.value,
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          MySettingsContainer(
            onTab: () {
              settingsController.ru();
            },
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: SvgPicture.asset(
                    "assets/icons/russia.svg",
                    width: 45,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  "Русский",
                  style: MyTextStyle.settingItemTextStyle,
                ),
                Obx(() {
                  return CircleAvatar(
                    backgroundColor: settingsController.colorRu.value,
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: (){
              Get.off(First1Screen());
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
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
