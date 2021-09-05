import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nookat/myLanguage/kg.dart';
import 'package:nookat/myLanguage/ru.dart';
import 'package:nookat/myLanguage/uz.dart';

class LocalizationService extends Translations {
  // Default locale
  static final locale = Locale('kg', 'KG');

  // fallbackLocale saves the day when the locale gets in trouble
  static final fallbackLocale = Locale('kg', 'KG');

  // Supported languages
  // Needs to be same order with locales
  static final langs = [
    'Кыргызча',
    'Русский',
    'O‘zbekcha',
  ];

  // Supported locales
  // Needs to be same order with langs
  static final locales = [
    Locale('kg', 'KG'),
    Locale('ru', 'RU'),
    Locale('uz', 'UZ'),
  ];

  // Keys and their translations
  // Translations are separated maps in `lang` file
  @override
  Map<String, Map<String, String>> get keys => {
    'kg_KG': kgKG, // lang/en_us.dart
    'ru_RU': ruRU, // lang/tr_tr.dart
    'uz_UZ': uzUZ, // lang/ja_jp.dart
  };

  // Gets locale from language, and updates the locale
  void changeLocale(String lang) {
    final locale = _getLocaleFromLanguage(lang);
    Get.updateLocale(locale!);
  }

  // Finds language in `langs` list and returns it as Locale
  Locale? _getLocaleFromLanguage(String lang) {
    for (int i = 0; i < langs.length; i++) {
      if (lang == langs[i]) return locales[i];
    }
    return Get.locale;
  }
}
