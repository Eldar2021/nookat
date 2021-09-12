import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/controler/ad_advert_cotroller.dart';
import 'package:nookat/controler/read_category_controller.dart';
import 'package:nookat/serviceFire/read_from_firebase.dart';
import 'package:nookat/views/credit_card_screen.dart';
import 'package:nookat/widgets/add_advert_widgets.dart';

class AddAdvertScreen extends StatelessWidget {
  final AddAdvertController addAdvertController = Get.put(AddAdvertController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ReadController readController = Get.put(ReadController());

  Widget buildGridView() {
    return Obx(
      () => GridView.count(
        crossAxisCount: 3,
        primary: false,
        shrinkWrap: true,
        children: List.generate(addAdvertController.images.length, (index) {
          Asset asset = addAdvertController.images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Жарнама берүү".tr,
            style: MyTextStyle.settingTextStyle,
          ),
          MyTextFormField(
            textEditingController: addAdvertController.user.value,
            text: "Атыңыз".tr,
            valid: true,
            info: "Өзүңүздүн атыңызды жазыңыз".tr,
          ), // user
          MyTextFormField(
            textEditingController: addAdvertController.title.value,
            text: "Жарнаманын темасы".tr,
            valid: true,
            info: "Жарнамаңызга тема бериңиз М: Автоунаа сатылат (манилүү)".tr,
          ), // title
          MyTextFormField(
            textEditingController: addAdvertController.descriptions.value,
            text: "Кененирээк".tr,
            valid: true,
            info: "Кененирээк маалымат жазыңыз (манилүү)".tr,
            maxLines: 5,
          ), // descriptions
          SizedBox(height: 20),
          Text("Сүрөт жүктөө үчүн камераны басыңыз (манилүү эмес!)".tr),
          Container(
            width: double.infinity,
            height: 50,
            child: Center(
              child: IconButton(
                icon: Icon(Icons.add_a_photo_outlined, size: 40,),
                onPressed: () {
                  addAdvertController.loadAssets();
                },
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 300,
            child: buildGridView(),
          ),
          MyTextFormField(
            textEditingController: addAdvertController.price.value,
            text: "Баасы:".tr,
            info: "Эгер бир нерсе сатып же кызмат көрсөтүп жатсаңыз анан баасын жазыңыз".tr,
          ),
          MyTextFormField(
            textEditingController: addAdvertController.address.value,
            text: "Адресиңиз".tr,
          ),
          MyTextFormField(
            textEditingController: addAdvertController.phone.value,
            text: "Телефон номер".tr,
          ),
          MyTextFormField(
            textEditingController: addAdvertController.whatsapp.value,
            text: "Whatsapp номер".tr,
          ),
          MyTextFormField(
            textEditingController: addAdvertController.telegram.value,
            text: "Telegram",
          ),
          MyTextFormField(
            textEditingController: addAdvertController.youtube.value,
            text: "Youtube ссылка".tr,
            info: "Эгер ютубтады видеоңуз болсо аны бул жакка кошуу үчүн https://www.youtube.com/watch?v=u3IkBhDIlfo ссылкасын алып анан юарабардан кийинкисин жазыңыз u3IkBhDIlfo".tr,
          ),
          MyTextFormField(
            textEditingController: addAdvertController.website.value,
            text: "Website",
            info: "Эгер веб сайтыңыз болсо анан ссылкасын жазаңыз".tr,
          ),
          MyTextFormField(
            textEditingController: addAdvertController.email.value,
            text: "email address",
          ),
          Obx(
            () => TextFormField(
              controller: addAdvertController.data.value,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Дата кириңиз".tr,
              ),
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101));
                if (pickedDate != null) {
                  print(pickedDate);
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                  print(formattedDate);
                  addAdvertController.data.value.text = formattedDate;
                } else {
                  print("Date is not selected");
                }
              },
            ),
          ),
          SizedBox(height: 20),
          ReadCategory(
            function: (String value) {
              addAdvertController.category.value = value;
              print(addAdvertController.category.value);
            },
          ),
          MyTextFormField(
            textEditingController: addAdvertController.extraCategory.value,
            text: "Кошумча категория".tr,
            info: "Эгер Кошумча категория кирсениз анда жогорудагы Каабар жана Шашылыш сатуу категириялары өчүрүлөт да сиз жазган категорияда кетет".tr,
          ),
          SizedBox(height: 20),
          Text("Толом жургузуу учун бирин танданызы".tr),
          Container(
            child: Row(
              children: [
                Expanded(
                  child: CartItem(
                    image: "assets/image/elsom.png",
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        Get.to(CreditCardScreen());
                      } else {
                        Get.defaultDialog(title: "Жогорудагы 'Атыңыз', 'Жарнаманын темасы', 'Кененирээк' формаларын толук толтуруңуз".tr);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: CartItem(
                    image: "assets/image/optima24.png",
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        Get.to(CreditCardScreen());
                      } else {
                        Get.defaultDialog(title: "Жогорудагы 'Атыңыз', 'Жарнаманын темасы', 'Кененирээк' формаларын толук толтуруңуз".tr);
                      }
                    },
                  ),
                ),
                Expanded(
                  child: CartItem(
                    image: "assets/image/elcart.png",
                    function: () {
                      if (_formKey.currentState!.validate()) {
                        Get.to(CreditCardScreen());
                      } else {
                        Get.defaultDialog(title: "Жогорудагы 'Атыңыз', 'Жарнаманын темасы', 'Кененирээк' формаларын толук толтуруңуз".tr);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

