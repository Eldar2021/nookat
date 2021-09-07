import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
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
          MyTextFormField(
            textEditingController: addAdvertController.title.value,
            text: "Жаңылыктын темасы",
            valid: true,
            info: "Жарнамаңызга тема бериңиз М: Автоунаа сатылат (манилүү)",
          ),
          SizedBox(height: 20),
          Text("Фото кошуу үчүн камераны басыңыз (манилүү эмес!)"),
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
            textEditingController: addAdvertController.titleDescription.value,
            text: "Кыскача тема",
            info: "Жарнаманын темасын ачыктоочу тема (манилүү эмес!)",
          ),
          MyTextFormField(
            textEditingController: addAdvertController.descriptions.value,
            text: "Баяндама",
            valid: true,
             info: "Жармаңызды толук баяндаңыз! (манилүү)",
            maxLines: 5,
          ),
          MyTextFormField(
            textEditingController: addAdvertController.price.value,
            text: "Баасы",
            info: "Эгер бир нерсе сатып же кызмат көрсөтүп жатсаңыз анан баасын жазыңыз",
          ),
          MyTextFormField(
            textEditingController: addAdvertController.whatsapp.value,
            text: "whatsapp",
            info: "Whatsapp номериңизди жазаңыз",
          ),
          MyTextFormField(
            textEditingController: addAdvertController.telegram.value,
            text: "telegram",
            info: "telegram атыңызды жазаңыз",
          ),
          MyTextFormField(
            textEditingController: addAdvertController.phone.value,
            text: "Телефон номер",
            info: "Телефон номериңизди жазаңыз",
          ),
          MyTextFormField(
            textEditingController: addAdvertController.youtube.value,
            text: "youtube ссылка",
            info: "Эгер ютубтады видеоңуз болсо аны бул жакка кошуу үчүн https://www.youtube.com/watch?v=u3IkBhDIlfo ссылкасын алып анан юарабардан кийинкисин жазыңыз u3IkBhDIlfo",
          ),
          MyTextFormField(
            textEditingController: addAdvertController.user.value,
            text: "Атыңыз",
            valid: true,
            info: "Өзүңүздүн атыңызды жазаңыз",
          ),
          MyTextFormField(
            textEditingController: addAdvertController.address.value,
            text: "Адресиңиз",
            info: "Адресиңизди жазаңыз",
          ),
          MyTextFormField(
            textEditingController: addAdvertController.website.value,
            text: "website",
            info: "Эгер веб сайтыңыз болсо анан ссылкасын жазаңыз",
          ),
          MyTextFormField(
            textEditingController: addAdvertController.email.value,
            text: "email",
            info: "Эгер email болсо анан email адресиңизди жазаңыз",
          ),
          Obx(
            () => TextFormField(
              controller: addAdvertController.data.value,
              decoration: InputDecoration(
                icon: Icon(Icons.calendar_today),
                labelText: "Дата кириңиз",
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
            text: "Кошумча категория",
             info: "Эгер Кошумча категория кирсениз анда жогорудагы Каабар жана Шашылыш сатуу категириялары өчүрүлөт да сиз жазган категорияда кетет",
          ),
          SizedBox(height: 20),
          Text("Толом жургузуу учун бирин танданызы"),
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
                        Get.defaultDialog(title: "Форманы толук толтуруңуз");
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
                        Get.defaultDialog(title: "Форманы толук толтуруңуз");
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
                        Get.defaultDialog(title: "Форманы толук толтуруңуз");
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

