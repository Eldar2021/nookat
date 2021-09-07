import 'package:get/get.dart';

class ReadController extends GetxController {
  RxString visible = "".obs;
  RxBool visibleUrgent = true.obs;

  void show(String name) {
    visible.value = name;
    update();
  }

}