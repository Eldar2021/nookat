import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:nookat/constants/color.dart';
import 'package:nookat/controler/admin_controller.dart';
import 'package:nookat/widgets/type_widget.dart';
import 'package:nookat/widgets/add_advert_widgets.dart';

class AddAdvertForAdminScreen extends StatelessWidget {

  final AddAdvertFromAdminController addAdvertFromAdminController = Get.put(AddAdvertFromAdminController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget buildGridView() {
    return Obx(
      () => GridView.count(
        crossAxisCount: 3,
        primary: false,
        shrinkWrap: true,
        children: List.generate(addAdvertFromAdminController.images.length, (index) {
          Asset asset = addAdvertFromAdminController.images[index];
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.primaryColor,
      ),
      body: GestureDetector(
        onTap:()=> FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyTextFormField(
                    textEditingController: addAdvertFromAdminController.title.value,
                    text: "title",
                    valid: true,
                  ),
                  Container(
                    width: double.infinity,
                    height: 50,
                    child: Center(
                      child: IconButton(
                        icon: Icon(Icons.add_a_photo_outlined),
                        onPressed: () {
                          addAdvertFromAdminController.loadAssets();
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
                    textEditingController: addAdvertFromAdminController.titleDescription.value,
                    text: "titleDescription",
                  ),
                  MyTextFormField(
                    textEditingController: addAdvertFromAdminController.descriptions.value,
                    text: "descriptions",
                    valid: true,
                  ),
                  MyTextFormField(
                    textEditingController: addAdvertFromAdminController.price.value,
                    text: "price",
                  ),
                  MyTextFormField(
                    textEditingController: addAdvertFromAdminController.whatsapp.value,
                    text: "whatsapp",
                  ),
                  MyTextFormField(
                    textEditingController: addAdvertFromAdminController.telegram.value,
                    text: "telegram",
                  ),
                  MyTextFormField(
                    textEditingController: addAdvertFromAdminController.phone.value,
                    text: "phone",
                  ),
                  MyTextFormField(
                    textEditingController: addAdvertFromAdminController.youtube.value,
                    text: "youtube",
                  ),
                  MyTextFormField(
                    textEditingController: addAdvertFromAdminController.user.value,
                    text: "user",
                    valid: true,
                  ),
                  MyTextFormField(
                    textEditingController: addAdvertFromAdminController.address.value,
                    text: "address",
                  ),
                  MyTextFormField(
                    textEditingController: addAdvertFromAdminController.website.value,
                    text: "website",
                  ),
                  MyTextFormField(
                    textEditingController: addAdvertFromAdminController.email.value,
                    text: "email",
                  ),
                  Obx(
                    () => TextFormField(
                      controller: addAdvertFromAdminController.data.value,
                      decoration: InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        labelText: "Enter Date",
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
                          addAdvertFromAdminController.data.value.text = formattedDate;
                        } else {
                          print("Date is not selected");
                        }
                      },
                    ),
                  ),
                  TypeAdvert(
                    function: (String value) {
                      addAdvertFromAdminController.category.value = value;
                      print(addAdvertFromAdminController.category.value);
                    },
                  ),
                  MyTextFormField(
                    textEditingController: addAdvertFromAdminController.extraCategory.value,
                    text: "extraCategory",
                  ),
                  ElevatedButton(
                    child: Text("жиберүү"),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addAdvertFromAdminController.toFire();
                      } else {
                        print("forn inValid");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
