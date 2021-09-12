import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/theme.dart';
import 'package:nookat/controler/first_controller.dart';
import 'package:nookat/mainscreen.dart';
import 'package:nookat/service/theme_service.dart';
import 'package:nookat/service/translations.dart';
import 'package:nookat/views/first/first_screen.dart';
import 'controler/settings_controller.dart';

Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
  Get.snackbar(
    message.notification!.title!,
    message.notification!.body!,
    colorText: const Color(0xff000000),
    backgroundColor: MyColors.whiteColor,
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp();
  FirebaseFunctions.instance.useFunctionsEmulator('localhost', 5001);
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SettingsController settingsController = Get.put(SettingsController());
  final FirstController firstController = Get.put(FirstController());

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
      home: AnimatedSplashScreen(
        duration: 100,
        splash: "assets/image/logo.png",
        nextScreen: firstController.firstStorage.read(firstController.firstKey) == null
            ? FirstScreen()
            : MainScreen(),
        splashTransition: SplashTransition.sizeTransition,
        backgroundColor: MyColors.whiteColor,
      ),
    );
  }
}
