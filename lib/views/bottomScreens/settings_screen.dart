import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/controler/settings_controller.dart';
import 'package:nookat/widgets/setting_widget.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController settingsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Тил тандаңыз".tr,
            style: MyTextStyle.settingTextStyle,
          ),
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
          Text(
            "Тема тандаңыз".tr,
            style: MyTextStyle.settingTextStyle,
          ),
          Row(
            children: [
              Expanded(
                child: MySettingsContainer(
                  child: Image.asset(
                    "assets/image/light.jpg",
                    width: Get.width / 3,
                    height: Get.width / 2,
                    fit: BoxFit.cover,
                  ),
                  padding: const EdgeInsets.all(10),
                  onTab: () {
                    Get.changeTheme(ThemeData.light());
                  },
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: MySettingsContainer(
                  child: Image.asset(
                    "assets/image/dark.jpg",
                    width: Get.width / 3,
                    height: Get.width / 2,
                    fit: BoxFit.cover,
                  ),
                  padding: EdgeInsets.all(10),
                  onTab: () {
                    Get.changeTheme(ThemeData.dark());
                  },
                ),
              ),
            ],
          ),
          Text(
            "Билдирүү эскертмеси".tr,
            style: MyTextStyle.settingTextStyle,
          ),
          MySettingsContainer(
            padding: const EdgeInsets.all(10),
            onTab: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Билдирүүнү иштетүү".tr,
                  style: MyTextStyle.settingItemTextStyle,
                ),
                Obx(() {
                  return Switch(
                    value: settingsController.notification.value,
                    onChanged: (value) {
                      settingsController.notification.value = value;
                      settingsController.changedNot(settingsController.notification.value);
                      print(settingsController.notification.value);
                    },
                    activeTrackColor: Colors.lightGreenAccent,
                    activeColor: Colors.green,
                  );
                }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

