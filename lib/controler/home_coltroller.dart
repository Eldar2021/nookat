import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/controler/settings_controller.dart';

class HomeController extends GetxController {
  final SettingsController settingsController = Get.find();

  RxBool visible = true.obs;

  void toBottom() {
    visible.value = false;
    update();
  }

  toUp() {
    visible.value = true;
    update();
  }

  void handleScroll(ScrollController _scrollController) async {
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection == ScrollDirection.forward) {
        toUp();
      } else if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
        toBottom();
      }
    });
  }

  RxInt page = 4.obs;

  void changePage(int index) {
    page.value = index;
    update();
  }

  void backPage() {
    page.value = 4;
    update();
  }

  late FirebaseMessaging messaging;
  ScrollController scrollController = ScrollController();


  @override
  void onInit() async {
    super.onInit();
    handleScroll(scrollController);
    messaging = FirebaseMessaging.instance;
    if(settingsController.notRead.read(settingsController.notKey) == true){
      await messaging.subscribeToTopic("topics-all");
    }else if(settingsController.notRead.read(settingsController.notKey) == false){
      await messaging.unsubscribeFromTopic("topics-all");
    }else{
      await messaging.subscribeToTopic("topics-all");
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      Get.snackbar(
        event.notification!.title!,
        event.notification!.body!,
        colorText: const Color(0xff000000),
        backgroundColor: MyColors.whiteColor,
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      Get.snackbar(
        message.notification!.title!,
        message.notification!.body!,
        colorText: const Color(0xff000000),
        backgroundColor: MyColors.whiteColor,
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    scrollController.removeListener(() {});
    super.dispose();
  }
}
