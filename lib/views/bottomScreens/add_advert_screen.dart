import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/constants/text_style.dart';
import 'package:nookat/controler/add_advert_cotroller.dart';
import 'package:nookat/widgets/type_widget.dart';
import 'package:nookat/widgets/add_advert_widgets.dart';
import 'package:nookat/widgets/category_dropdown_widget.dart';
import 'package:readmore/readmore.dart';

class AddAdvertScreen extends StatelessWidget {
  final AddAdvertController addAdvertController = Get.put(AddAdvertController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
          Row(
            children: [
              Text("Манилүү".tr, style: MyTextStyle.settingTextStyle),
            ],
          ),
          ReadMoreText(
            "Бул бөлүмдөрдү сөзсүз толтурууңуз кажет!".tr,
            trimLines: 1,
            style: TextStyle(),
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Дагы оку'.tr,
            trimExpandedText: 'Жабуу'.tr,
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 40, top: 5),
            decoration: BoxDecoration(border: Border.all()),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  info: "Жарнамаңызга тема бериңиз Мисалы Автоунаа сатылат (манилүү)".tr,
                ), // title
                MyTextFormField(
                  textEditingController: addAdvertController.descriptions.value,
                  text: "Кененирээк".tr,
                  valid: true,
                  info: "Кененирээк маалымат жазыңыз (манилүү)".tr,
                  maxLines: 5,
                ),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: addAdvertController.data.value,
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Күнүн жазыңыз".tr,
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
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text("Манилүү эмес".tr, style: MyTextStyle.settingTextStyle),
            ],
          ),
          ReadMoreText(
            "Бул бөлүмдөрдү сөзсүз толтуруунун кажети жок кошумча маалыматыңыз болсо, жазып койсоңуз жакшы".tr,
            trimLines: 1,
            style: TextStyle(),
            colorClickableText: Colors.pink,
            trimMode: TrimMode.Line,
            trimCollapsedText: 'Дагы оку'.tr,
            trimExpandedText: 'Жабуу'.tr,
            moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(border: Border.all()),
            child: Column(
              children: [
                Text("Сүрөт жүктөө үчүн камераны басыңыз (манилүү эмес!)".tr),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.add_a_photo_outlined,
                        size: 40,
                      ),
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
                  info: "Эгер бир нерсе сатып же кызмат көрсөтүп жатсаңыз анын баасын жазыңыз".tr,
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
                  text: "YouTube ссылка".tr,
                  info:
                  "Эгер YouTube видеоңуз болсо аны бул жакка кошуу үчүн https://www.youtube.com/watch?v=u3IkBhDIlfo ссылкасын алып анан барабардан кийинкисин жазыңыз u3IkBhDIlfo".tr,
                ),
                MyTextFormField(
                  textEditingController: addAdvertController.website.value,
                  text: "Website",
                  info: "Эгер веб-сайтыңыз болсо анын ссылкасын жазыңыз".tr,
                ),
                MyTextFormField(
                  textEditingController: addAdvertController.email.value,
                  text: "email address",
                ),
                SizedBox(height: 20),
                TypeAdvert(
                  function: (String value) {
                    addAdvertController.type.value = value;
                    print(addAdvertController.type.value);
                  },
                ),
                CategoryDropdown(textEditingController: addAdvertController.category.value,),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                addAdvertController.toFire();
              } else {
                Get.defaultDialog(
                  title: "Жогорудагы 'Атыңыз', 'Жарнаманын темасы', 'Кененирээк' формаларын толук толтуруңуз".tr,
                );
              }
            },
            child: Container(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 10, bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: MyColors.priceBackColor,
              ),
              child: Text("Жиберүү".tr, style: MyTextStyle.homeCategory),
            ),
          ),
        ],
      ),
    );
  }
}
