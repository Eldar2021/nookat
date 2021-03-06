import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  /// Save isDarkMode to local storage
  saveThemeToBox1(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Switch theme and save to local storage
  void darkTheme() {
    Get.changeTheme(ThemeData.dark());
    saveThemeToBox1(true);
  }

  void lightTheme() {
    Get.changeTheme(ThemeData.light());
    saveThemeToBox1(false);
  }
}