import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nookat/service/translations.dart';

class SettingsController extends GetxController {
  RxString _selectedLang = LocalizationService.langs.first.obs;

  final langRead = GetStorage();
  String key = "language";

  @override
  void onInit() {
    lang = langRead.read(key) == 1
        ? 1.obs
        : langRead.read(key) == 2
            ? 2.obs
            : 3.obs;
    colorKg = langRead.read(key) == 1
        ? Colors.green.obs
        :langRead.read(key) == null ? Colors.green.obs : Colors.grey.obs;
    colorRu = langRead.read(key) == 3 ? Colors.green.obs : Colors.grey.obs;
    colorUz = langRead.read(key) == 2 ? Colors.green.obs : Colors.grey.obs;
    super.onInit();
  }

  late Rx<Color> colorKg;
  late Rx<Color> colorRu;
  late Rx<Color> colorUz;
  late RxInt lang;

  void kg() {
    _selectedLang.value = "Кыргызча";
    LocalizationService().changeLocale("Кыргызча");
    colorKg.value = Colors.green;
    colorRu.value = Colors.grey;
    colorUz.value = Colors.grey;
    lang.value = 1;
    langRead.write(key, lang.value);
    update();
  }

  void uz() {
    _selectedLang.value = "O‘zbekcha";
    LocalizationService().changeLocale("O‘zbekcha");
    colorKg.value = Colors.grey;
    colorRu.value = Colors.grey;
    colorUz.value = Colors.green;
    lang.value = 2;
    langRead.write(key, lang.value);
    update();
  }

  void ru() {
    _selectedLang.value = "Русский";
    LocalizationService().changeLocale("Русский");
    colorKg.value = Colors.grey;
    colorRu.value = Colors.green;
    colorUz.value = Colors.grey;
    lang.value = 3;
    langRead.write(key, lang.value);
    update();
  }

  RxBool notification = true.obs;

  void changedNot() {
    notification.value = !notification.value;
    update();
  }
}
