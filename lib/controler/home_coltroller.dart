import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
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

  @override
  void onInit() async{
    print("heeey i am Eldar--------------------------");
    messaging = FirebaseMessaging.instance;
    await messaging.subscribeToTopic("topics-all");
    print("heeey i am topic--------------------------");
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      Get.defaultDialog(
        content: AlertDialog(
          title: Text(event.notification!.title!),
          content: Text(event.notification!.body!),
          actions: [
            TextButton(
              child: Text("Ok"),
              onPressed: () {},
            )
          ],
        ),
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("yes!!!");
    });
    super.onInit();
  }
}
