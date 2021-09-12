import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FirstController extends GetxController {
  RxBool isFirst = true.obs;
  final firstStorage = GetStorage();
  String firstKey = "isFirst";

  void second() {
    isFirst.value = false;
    firstStorage.write(firstKey, isFirst.value);
    update();
  }

}