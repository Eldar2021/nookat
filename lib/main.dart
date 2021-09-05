import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/theme.dart';
import 'package:nookat/mainscreen.dart';
import 'package:nookat/service/theme_service.dart';
import 'package:nookat/service/translations.dart';
import 'controler/settings_controller.dart';
import 'not.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SettingsController settingsController = Get.put(SettingsController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: Themes.light,
      themeMode: ThemeService().theme,
      darkTheme: Themes.dark,
      locale: settingsController.langRead.read(settingsController.key) == 1
          ? Locale('kg', 'KG')
          : settingsController.langRead.read(settingsController.key) == 2
              ? Locale('uz', 'UZ')
              : settingsController.langRead.read(settingsController.key) == 3
                  ? Locale('ru', 'RU')
                  : Locale('kg', 'KG'),
      fallbackLocale: settingsController.langRead.read(settingsController.key) == 1
          ? Locale('kg', 'KG')
          : settingsController.langRead.read(settingsController.key) == 2
              ? Locale('uz', 'UZ')
              : settingsController.langRead.read(settingsController.key) == 3
                  ? Locale('ru', 'RU')
                  : Locale('kg', 'KG'),
      translations: LocalizationService(),
      // home: Not(),
      home: AnimatedSplashScreen(
        duration: 2000,
        splash: "assets/image/logo.png",
        nextScreen: MainScreen(),
        splashTransition: SplashTransition.sizeTransition,
        backgroundColor: MyColors.whiteColor,
      ),
    );
  }
}
