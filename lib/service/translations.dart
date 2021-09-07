import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/myLanguage/kg.dart';
import 'package:nookat/myLanguage/ru.dart';
import 'package:nookat/myLanguage/uz.dart';

class LocalizationService extends Translations {

  static final locale = Locale('kg', 'KG');

  static final fallbackLocale = Locale('kg', 'KG');

  static final langs = [
    'Кыргызча',
    'Русский',
    'O‘zbekcha',
  ];

  static final locales = [
    Locale('kg', 'KG'),
    Locale('ru', 'RU'),
    Locale('uz', 'UZ'),
  ];

  @override
  Map<String, Map<String, String>> get keys => {
    'kg_KG': kgKG,
    'ru_RU': ruRU,
    'uz_UZ': uzUZ,
  };

  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
