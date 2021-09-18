import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nookat/controler/home_coltroller.dart';
import 'package:nookat/models/advert.dart';
import 'package:nookat/serviceFire/add_to_firebase.dart';

class AddAdvertController extends GetxController {
  Rx<TextEditingController> title = TextEditingController().obs;
  Rx<TextEditingController> titleDescription = TextEditingController().obs;
  Rx<TextEditingController> descriptions = TextEditingController().obs;
  Rx<TextEditingController> price = TextEditingController().obs;
  Rx<TextEditingController> whatsapp = TextEditingController().obs;
  Rx<TextEditingController> telegram = TextEditingController().obs;
  Rx<TextEditingController> phone = TextEditingController().obs;
  Rx<TextEditingController> youtube = TextEditingController().obs;
  Rx<TextEditingController> data = TextEditingController().obs;
  Rx<TextEditingController> user = TextEditingController().obs;
  Rx<TextEditingController> address = TextEditingController().obs;
  Rx<TextEditingController> website = TextEditingController().obs;
  Rx<TextEditingController> email = TextEditingController().obs;
  Rx<TextEditingController> category = TextEditingController().obs;
  RxString type = "".obs;
  RxString collection = "".obs;
  RxList<Asset> images = <Asset>[].obs;
  List<String> photos = <String>[].obs;
  List<Asset> resultList = <Asset>[].obs;
  RxString error = 'Selectionner une image'.obs;
  RxString file = "".obs;
  RxList<Asset> resultList1 = <Asset>[].obs;

  Future<void> loadAssets() async {
    String _error = 'No Error Dectected';
    try {
      resultList1.value = await MultiImagePicker.pickImages(
        maxImages: 6,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Example App",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      _error = e.toString();
    }
    images.value = resultList1;
    error.value = _error;
    update();
  }

  Future<List<String>> uploadImages(List<Asset> _images) async {
    await Future.wait(
      _images.map(
        ((_image) async {
          try {
            var firebaseStorageRef =
                FirebaseStorage.instance.ref().child('${user.value.text}/${DateTime.now()}');
            var uploadTask =
                firebaseStorageRef.putData((await _image.getByteData()).buffer.asUint8List());
            var taskSnapshot = await uploadTask;
            await taskSnapshot.ref.getDownloadURL().then(
              (value) {
                photos.add(value);
                print(photos);
              },
            );
          } on FirebaseException {}
        }),
      ),
    );
    return photos;
  }

  Future<void> toFire()async {
    HomeController homeController = Get.put(HomeController());
    Get.defaultDialog(
        barrierDismissible: false,
        onWillPop: () async=>false,
        content: Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        )
    );
    await addAdvert();
    Get.back();
    homeController.backPage();
  }

  Future<void> addAdvert() async {
    await uploadImages(images);
    if (type.value != "") {
      if (type.value == "Кабар") {
        collection.value = "news";
      } else if (type.value == "Шашылыш сатуу") {
        collection.value = "urgent";
      } else {
        collection.value = "advert";
      }
    } else {
      collection.value = "advert";
    }
    try {
      print("form is valid");
      Advert newAdvert = Advert(
        title: title.value.text,
        descriptions: descriptions.value.text,
        user: user.value.text,
        data: data.value.text,
        titleDescription: titleDescription.value.text,
        price: price.value.text,
        whatsapp: whatsapp.value.text,
        telegram: telegram.value.text,
        phone: phone.value.text,
        youtube: youtube.value.text,
        photos: photos,
        address: address.value.text,
        website: website.value.text,
        email: email.value.text,
        advertCategory: category.value.text,
      );
      await AddToFirebase().addAdvertToFire(newAdvert, collection.value);
    } catch (e) {
      print(e);
    }
    title.value.text = "";
    descriptions.value.text = "";
    user.value.text = "";
    data.value.text = "";
    titleDescription.value.text = "";
    price.value.text = "";
    whatsapp.value.text = "";
    telegram.value.text = "";
    phone.value.text = "";
    youtube.value.text = "";
    address.value.text = "";
    website.value.text = "";
    email.value.text = "";
    type.value = "";
    photos = [];
    category.value.text = "";
    collection.value = "";
    images.value = [];
    resultList = [];
    file.value = "";
    resultList1.value = [];
    update();
  }
}
